source "$HOME/.config/fish/exports.fish"
source "$HOME/.config/fish/abbreviations.fish"

for f in $fisher_path/conf.d/*
  source $f
end

fish_add_path ~/.local/bin

if status is-interactive
  # Commands to run in interactive sessions can go here
end

function fish_refresh --description "Refresh fish configuration"
  source ~/.config/fish/config.fish
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/trb/google-cloud-sdk/path.fish.inc' ]; . '/home/trb/google-cloud-sdk/path.fish.inc'; end

# Homebrew
if test -f "/home/linuxbrew/.linuxbrew/bin/brew"
  eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

if type -q brew
  if test -d (brew --prefix)"/share/fish/completions"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
  end

  if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
  end
end
