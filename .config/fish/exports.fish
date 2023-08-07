# Editor
set -x EDITOR "code -w"

# Colorful man pages
# from http://pastie.org/pastes/206041/text
set -gx LESS_TERMCAP_mb (set_color -o red)
set -gx LESS_TERMCAP_md (set_color -o red)
set -gx LESS_TERMCAP_me (set_color normal)
set -gx LESS_TERMCAP_se (set_color normal)
set -gx LESS_TERMCAP_so (set_color -b blue -o yellow)
set -gx LESS_TERMCAP_ue (set_color normal)
set -gx LESS_TERMCAP_us (set_color -o green)

# Fisher
set -gx fisher_path "$HOME/.config/fisher"
set fish_function_path $fisher_path"/functions" $fish_function_path
set fish_complete_path $fisher_path"/functions" $fish_complete_path

# Vagrant access to VirtualBox when running inside WSL2
if type -q vagrant
  if test -d "/mnt/c/Program Files/Oracle/VirtualBox"
    fish_add_path "/mnt/c/Program Files/Oracle/VirtualBox"
  end

  set -gx VAGRANT_WSL_ENABLE_WINDOWS_ACCESS "1"
end

# Bashhub
set -gx BH_URL "https://bh.tomrijnbeek.me/"

# GCloud
set -gx USE_GKE_GCLOUD_AUTH_PLUGIN True

# SDKMan
if test -d "~/.sdkman"
  set -g __sdkman_custom_dir ~/.sdkman
end
