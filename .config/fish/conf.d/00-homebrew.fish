# Sourced from conf.d, and named to sort first, so that brew's bin is on PATH
# before any other conf.d snippet that relies on a brew-installed tool.
# Pass the shell explicitly: without it brew guesses from $SHELL and falls back to
# POSIX syntax, which fish cannot parse.
if test -f "/home/linuxbrew/.linuxbrew/bin/brew"
  eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)
end
if test -f "/opt/homebrew/bin/brew"
  eval (/opt/homebrew/bin/brew shellenv fish)
end

# One `brew --prefix` rather than four: each call is a ~45ms ruby start.
# shellenv already exported HOMEBREW_PREFIX, so prefer that.
if type -q brew
  set -l brew_prefix $HOMEBREW_PREFIX
  test -n "$brew_prefix"; or set brew_prefix (brew --prefix)

  for dir in $brew_prefix/share/fish/completions $brew_prefix/share/fish/vendor_completions.d
    test -d $dir; and set -gx fish_complete_path $fish_complete_path $dir
  end
end
