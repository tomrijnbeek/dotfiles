# fzf emits its own fish integration from the binary, so this needs no
# platform-specific paths and always matches the installed version. It also gives
# us shift-tab completion, which the old key-bindings.fish symlink did not.
#
# Numbered after 00-homebrew.fish, which puts fzf on PATH.
if type -q fzf
  # fzf.fish binds ctrl-r as well. Drop its history search so fzf's own widget
  # owns the key. Order matters: fzf_configure_bindings erases its own previous
  # key set, so calling it after `fzf --fish` would leave ctrl-r unbound.
  functions -q fzf_configure_bindings; and fzf_configure_bindings --history=

  fzf --fish | source
end
