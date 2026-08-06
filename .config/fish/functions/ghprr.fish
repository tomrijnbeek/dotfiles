function ghprr -d "Github: View Open PRs needing my review"
  is_in_git_repo || return
  gh pr list -L100 --search "is:open is:pr review-requested:@me" |
  fzf --height 50% --border --ansi --no-sort \
    --preview 'gh pr view (echo {} | cut -f1)' \
    --bind "enter:execute(gh pr view --web (echo {} | cut -f1))"
end
