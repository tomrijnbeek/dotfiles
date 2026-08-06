function clean_merged_branches -d "Git: clean all branches merged with the specified branch"
  is_in_git_repo || return
  set branch $argv[1]
  git branch --merged $branch --no-color | grep -v "$branch\|*" | xargs -n 1 git branch -d
end
