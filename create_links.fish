set -l basedir (dirname (readlink -m (status --current-filename)))

function make_link
  echo "$argv[1] -> $argv[2]"
  if find $argv[2]
    mv $argv[2] $argv[2].bak
  end
  ln -sfn $argv[1] $argv[2]
end

make_link $basedir/.gitconfig ~/.gitconfig

for i in $basedir/.config/*
  make_link $i ~/.config/(basename $i)
end

source $basedir/.config/fish/config.fish
