function clean_merged_branches_custom -d "Git: as clean_merged_branches, but review the list in \$EDITOR first"
  is_in_git_repo || return

  if test -z "$argv[1]"
    echo "clean_merged_branches_custom: needs a branch to compare against" >&2
    return 1
  end

  set -l stale (_merged_branches $argv[1])
  if test (count $stale) -eq 0
    echo "No branches merged into $argv[1]."
    return 0
  end

  set -l list (mktemp)
  printf '%s\n' $stale >$list

  # eval because $EDITOR carries flags ("code -w")
  if eval $EDITOR (string escape $list)
    for branch in (string trim <$list | string match -rv '^$')
      git branch -d $branch
    end
  end

  rm -f $list
end
