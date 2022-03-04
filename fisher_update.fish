set --query fisher_path || set --local "$HOME/.config/fisher"
curl -sL https://git.io/fisher | source && fisher update
