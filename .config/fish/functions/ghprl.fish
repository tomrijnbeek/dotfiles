function ghprl -d "Github: View Open PRs"
  is_in_git_repo || return
  gh pr list -L100 |
  fzf --height 50% --border --ansi --no-sort \
    --preview 'gh pr view (echo {} | cut -f1)' \
    --bind "enter:execute(gh pr view --web (echo {} | cut -f1))"
end
