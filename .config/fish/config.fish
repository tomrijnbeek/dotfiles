source "$HOME/.config/fish/exports.fish"
source "$HOME/.config/fish/abbreviations.fish"

for f in $fisher_path/conf.d/*
  source $f
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end
