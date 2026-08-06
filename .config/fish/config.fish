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

# Pyenv. --no-rehash on both: the generated script ends in a `pyenv rehash` call
# that costs ~170ms per shell. Run `pyenv rehash` by hand after installing a
# version. --path stays so non-interactive login shells still get the shims.
if type -q pyenv
  status is-login; and pyenv init --path --no-rehash | source
  status is-interactive; and pyenv init - --no-rehash | source
  set -gx CLOUDSDK_PYTHON "/usr/bin/python3"
end

# Bashhub.com Installation
if [ -f "$HOME/.bashhub/bashhub.fish" ]
  source "$HOME/.bashhub/bashhub.fish"
end

# jEnv. Both probes use `command` to bypass fish's function autoloader: any bare
# reference to `jenv` pulls in Homebrew's vendor_functions.d/jenv.fish, which runs
# `jenv rehash` and costs ~300ms on every shell. `jenv init -` defines its own
# equivalent wrapper, so that file is never needed.
if command -q jenv
  fish_add_path ~/.jenv/bin
  if status --is-interactive
    # jenv's own generated script calls `jenv refresh-plugins` a few lines before
    # it defines its `jenv` function, and that bare call is what autoloads the
    # vendor file. Defining a stub first keeps the autoloader out of it; the
    # generated script overwrites this immediately.
    function jenv; command jenv $argv; end
    command jenv init - --no-rehash fish | source
  else
    contains $HOME/.jenv/shims $PATH; or set -gx PATH $HOME/.jenv/shims $PATH
  end
end

# Jetbrains toolbox
if test -d ~/Library/Application\ Support/JetBrains/Toolbox/scripts
  fish_add_path ~/Library/Application\ Support/JetBrains/Toolbox/scripts
end

if type -q zoxide
  zoxide init fish | source
end
