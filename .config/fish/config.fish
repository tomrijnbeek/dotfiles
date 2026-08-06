source "$HOME/.config/fish/exports.fish"
source "$HOME/.config/fish/abbreviations.fish"

fish_add_path ~/.local/bin
fish_add_path ~/.krew/bin

if status is-interactive
  # Commands to run in interactive sessions can go here
end

function fish_refresh --description "Refresh fish configuration"
  source ~/.config/fish/config.fish
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.fish.inc" ]; . "$HOME/google-cloud-sdk/path.fish.inc"; end
if test -f "$HOME/google-cloud-sdk/completion.bash.inc"; and type -q replay
  replay source "$HOME/google-cloud-sdk/completion.bash.inc"
end

# Homebrew lives in conf.d/00-homebrew.fish, which fish sources before this file

# Pyenv
if type -q pyenv
  status is-login; and pyenv init --path | source
  status is-interactive; and pyenv init - | source
  set -gx CLOUDSDK_PYTHON "/usr/bin/python3"
end

# Bashhub.com Installation
if [ -f "$HOME/.bashhub/bashhub.fish" ]
  source "$HOME/.bashhub/bashhub.fish"
end

# jEnv
if type -q jenv
  fish_add_path ~/.jenv/bin
  status --is-interactive; and jenv init - fish | source
end

# Jetbrains toolbox
if test -d ~/Library/Application\ Support/JetBrains/Toolbox/scripts
  fish_add_path ~/Library/Application\ Support/JetBrains/Toolbox/scripts
end

if type -q zoxide
  zoxide init fish | source
end
