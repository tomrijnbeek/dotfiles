function clean_merged_branches_custom -d "Git: clean all branches merged with the specified branch, allowing editing"
  is_in_git_repo || return
  set branch $argv[1]
  git branch --merged master --no-color | grep -v "$branch\|*" | string trim > /tmp/merged-branches
  eval $EDITOR /tmp/merged-branches; and xargs git branch -d < /tmp/merged-branches
end
