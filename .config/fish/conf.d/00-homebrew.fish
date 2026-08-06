# Sourced from conf.d, and named to sort first, so that brew's bin is on PATH
# before any other conf.d snippet that relies on a brew-installed tool.
if test -f "/home/linuxbrew/.linuxbrew/bin/brew"
  eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end
if test -f "/opt/homebrew/bin/brew"
  eval (/opt/homebrew/bin/brew shellenv)
end

if type -q brew
  if test -d (brew --prefix)"/share/fish/completions"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
  end

  if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
  end
end
