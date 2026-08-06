function clean_merged_branches -d "Git: delete every branch already merged into the given branch"
  is_in_git_repo || return

  if test -z "$argv[1]"
    echo "clean_merged_branches: needs a branch to compare against" >&2
    return 1
  end

  set -l stale (_merged_branches $argv[1])
  if test (count $stale) -eq 0
    echo "No branches merged into $argv[1]."
    return 0
  end

  for branch in $stale
    git branch -d $branch
  end
end
