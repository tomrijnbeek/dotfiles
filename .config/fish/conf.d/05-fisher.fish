# Fisher installs plugins into four directories and does no wiring of its own, so
# relocating fisher_path off the default (~/.config/fish) makes all three search
# paths our responsibility. Keeping plugins out of the stow'd tree is worth it.
#
# The source loop is not optional: fish only scans conf.d in $__fish_config_dir,
# $__fish_sysconf_dir and $__fish_vendor_confdirs, and that last one is consumed
# once in share/config.fish before any user config runs, so it cannot be extended
# from here the way fish_function_path and fish_complete_path can.
#
# Numbered after 00-homebrew.fish so plugins needing a brew binary find it.
set -gx fisher_path "$HOME/.config/fisher"

set fish_function_path $fisher_path/functions $fish_function_path
set fish_complete_path $fisher_path/completions $fish_complete_path

for file in $fisher_path/conf.d/*.fish
  source $file
end
