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
