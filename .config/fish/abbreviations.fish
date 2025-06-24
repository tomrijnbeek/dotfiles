# Folder navigation
abbr -a up cd ..

if type -q eza
  alias ls="eza"
  abbr -a ll eza -alF --icons
  abbr -a la eza -A --icons
  abbr -a l eza -F --colour
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
