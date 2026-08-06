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

# 3. tmux config parses, on its own socket so an already-running server carrying
#    this config cannot mask a problem.
if type -q tmux
  set -l socket check-(random)
  set -l output (tmux -L $socket -f $repo/.tmux.conf new-session -d 2>&1)
  set -l rc $status
  tmux -L $socket kill-server 2>/dev/null
  test $rc -ne 0 -o -n "$output"; and fail "tmux config does not parse:" $output
end

if test $failures -eq 0
  echo "All checks passed."
else
  echo "$failures check(s) failed." >&2
  exit 1
end
