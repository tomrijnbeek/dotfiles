function is_in_git_repo
  git rev-parse --git-dir > /dev/null 2>&1
end
