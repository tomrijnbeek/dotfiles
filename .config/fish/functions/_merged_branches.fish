function _merged_branches -d "Git: branches already merged into the given branch, excluding it and HEAD"
  # --format rather than plain `git branch`, so there is no "* current" marker to
  # strip and no leading whitespace to trim.
  git branch --merged $argv[1] --format='%(refname:short)' \
    | string match -v $argv[1] \
    | string match -v (git rev-parse --abbrev-ref HEAD)
end
