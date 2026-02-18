git-branch-prune() {
  local force=0
  [[ "$1" == "--force" ]] && force=1

  local root=$(git rev-parse --show-toplevel 2>/dev/null) || { echo "Not in a git repo"; return 1 }

  # Remove worktrees
  local worktrees=($(git worktree list --porcelain | grep "^worktree " | awk '{print $2}' | tail -n +2))
  for wt in $worktrees; do
    echo "Removing worktree: $wt"
    if (( force )); then
      git worktree remove --force "$wt"
    else
      git worktree remove "$wt" || echo "  ✗ Could not remove $wt (try --force)"
    fi
  done

  # Delete branches except main and develop
  local branches=($(git branch | sed 's/^[+* ]*//' | grep -Ev '^(main|develop)$'))
  for branch in $branches; do
    echo "Deleting branch: $branch"
    if (( force )); then
      git branch -D "$branch"
    else
      git branch -d "$branch" || echo "  ✗ Could not delete $branch (try --force)"
    fi
  done

  # Fetch and prune
  echo "Running git fetch --prune..."
  git fetch --prune
}