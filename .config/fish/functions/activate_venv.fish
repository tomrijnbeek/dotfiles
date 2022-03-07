function activate_venv --description 'Activates a virtual environment with the provided name'
  set -l env_path $argv[1]
  if test ! -d "./"$env_path
    echo "Could not find virtual environment at " $env_path
    return 1
  end
  source $env_path"/bin/activate.fish"
end
