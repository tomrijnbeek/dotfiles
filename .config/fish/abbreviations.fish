# Folder navigation
abbr -a up cd ..

abbr -a ll ls -alF
abbr -a la ls -A
abbr -a l ls -CF

abbr -a dev cd ~/dev

# Python
abbr -a py python3
abbr -a venv virtualenv --system-site-packages
abbr -a mkenv virtualenv --system-site-packages .venv
abbr -a activate activate_venv .venv
abbr -a django python3 manage.py

# Git
abbr -a g git

# Kubernetes
abbr -a exitkube kubectl config unset current-context
