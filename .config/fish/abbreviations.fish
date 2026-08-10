# Folder navigation
abbr -a up cd ..

# eza's --icons, --classify and --color all take an *optional* WHEN value, so the
# bare flags swallow a trailing path as that value. Attaching `=auto` is what makes
# `ll somedir` work. The alias is interactive-only because fish sources this file
# for scripts too, where eza's short flags mean different things to ls's (-h is
# --header, -S is --blocksize, -t demands a FIELD).
if type -q eza
  status is-interactive; and alias ls="eza"
  abbr -a ll eza -alF=auto --icons=auto --no-user
  # --git costs a libgit2 status scan: ~0.6s in a 12k-file repo, so not on `ll`.
  abbr -a llg eza -alF=auto --icons=auto --no-user --git
  abbr -a la eza -A --icons=auto
  abbr -a l eza -F=auto
else
  abbr -a ll ls -alF
  abbr -a la ls -A
  abbr -a l ls -CF
end

abbr -a dev cd ~/dev

# Python
abbr -a py python3
abbr -a venv virtualenv --system-site-packages
abbr -a mkenv virtualenv --system-site-packages .venv
abbr -a activate activate_venv .venv
abbr -a django python3 manage.py

# Git
abbr -a g git
abbr -a gpb clean_merged_branches
abbr -a gpbc clean_merged_branches_custom

# Kubernetes
abbr -a exitkube kubectl config unset current-context
