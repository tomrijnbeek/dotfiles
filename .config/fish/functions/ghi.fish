function ghi -d "Github: View Open Issues"
  is_in_git_repo || return
  gh issue list |
  fzf --height 50% --border --ansi --no-sort \
    --preview 'gh issue view (echo {} | cut -f1)' \
    --bind "enter:execute(gh issue view --web (echo {} | cut -f1))"
end
