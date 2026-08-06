function tm --description 'Attach to a tmux session, creating it if needed'
  set -l name $argv[1]

  if test -z "$name"
    tmux list-sessions
    return
  end

  # -d so creation works whether or not we are already inside tmux, where the
  # attaching forms of new-session refuse to nest.
  tmux has-session -t=$name 2>/dev/null
  or tmux new-session -d -s $name

  # -t= is an exact match; without the = tmux prefix-matches, so `tm dot` would
  # silently pick dotfiles over dotfiles-main.
  if set -q TMUX
    tmux switch-client -t=$name
  else
    tmux attach-session -t=$name
  end
end
