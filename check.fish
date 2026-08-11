#!/usr/bin/env fish
# Sanity checks for this repo. Run directly, or via the pre-commit hook installed
# by install_hooks.fish.
#
# The startup check is the one that matters. Both bugs found on 2026-08-06 (fnm
# unreachable because Homebrew loaded after conf.d, and brew shellenv emitting
# POSIX syntax when it cannot detect the shell) surfaced only as noise on stderr,
# which nothing was watching. Note it deliberately does not set SHELL: that is
# what makes brew fall back to POSIX output, and setting it hides the bug.

set -l repo (realpath (dirname (status filename)))
set -l fish_bin (status fish-path)
set -l failures 0

function fail --no-scope-shadowing
  printf 'FAIL: %s\n' $argv >&2
  set failures (math $failures + 1)
end

# 1. Every fish file parses. Includes untracked files, so a newly added broken
#    file is caught before it is committed rather than after.
for file in (git -C $repo ls-files --cached --others --exclude-standard '*.fish')
  test -f $repo/$file; or continue
  set -l output (fish -n $repo/$file 2>&1)
  test -n "$output"; and fail "$file does not parse:" $output
end

# 2. A login shell starts silently, in a cleared environment so this cannot pass
#    by inheriting a usable PATH or SHELL from the caller.
set -l startup (env -i HOME=$HOME TERM=xterm PATH=/usr/bin:/bin:/usr/sbin:/sbin \
  $fish_bin -l -c true 2>&1)
test -n "$startup"; and fail "login shell is not silent:" $startup

# 3. The same, from a directory carrying a Node version file. Check 2 cannot see
#    this: fnm announces a switch only when there is a version to apply, and
#    $HOME has none.
#
#    The version has to differ from the default. The child inherits no fnm state
#    through env -i, so it starts on the default alias, and fnm says nothing when
#    the file asks for the version already in use. That also means the check can
#    only run with two versions installed; with one it is skipped.
if type -q fnm
  set -l default (fnm default 2>/dev/null)
  set -l node_version
  for installed in (fnm ls | string match -gr '^\* (v[0-9][^ ]*)')
    test "$installed" = "$default"; and continue
    set node_version $installed
    break
  end

  if test -n "$node_version"
    set -l dir (mktemp -d)
    echo $node_version >$dir/.node-version

    # The child has to *start* in $dir, so the cwd change cannot be pushed into
    # its -c argument. This fires the outer shell's own PWD hook, harmlessly.
    pushd $dir
    set -l startup (env -i HOME=$HOME TERM=xterm PATH=/usr/bin:/bin:/usr/sbin:/sbin \
      $fish_bin -l -c true 2>&1)
    popd

    rm -f $dir/.node-version
    rmdir $dir

    test -n "$startup"; and fail "login shell is not silent in a Node directory:" $startup
  end
end

# 4. tmux config parses, on its own socket so an already-running server carrying
#    this config cannot mask a problem.
if type -q tmux
  set -l socket check-(random)
  set -l output (tmux -L $socket -f $repo/.tmux.conf new-session -d 2>&1)
  set -l rc $status

  # Ask the server where its socket is before killing it: kill-server unlinks
  # nothing, so without this every run leaves a dead check-* socket behind.
  set -l socket_path (tmux -L $socket display-message -p '#{socket_path}' 2>/dev/null)
  tmux -L $socket kill-server 2>/dev/null
  test -n "$socket_path" -a -S "$socket_path"; and rm -f $socket_path

  test $rc -ne 0 -o -n "$output"; and fail "tmux config does not parse:" $output
end

if test $failures -eq 0
  echo "All checks passed."
else
  echo "$failures check(s) failed." >&2
  exit 1
end
