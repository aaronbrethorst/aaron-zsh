# aaron-zsh

Git utilities for working with multiple worktrees.

## The problem

When you use Claude Code (or other AI coding agents) on a project, each session needs its own working directory. Git worktrees let you check out the same repo into multiple sibling directories without cloning — they share the same `.git` history and can each be on a different branch.

The annoying part is the lifecycle: creating several worktrees by hand is tedious, and cleaning them up afterward means removing the worktree directories, deleting the leftover branches, and pruning stale remote refs. These scripts automate both sides of that.

## Scripts

### git-make-worktrees

Creates `n` worktrees as sibling directories alongside your repo. If your repo is at `~/code/myapp`, running `git-make-worktrees 3` creates `~/code/myapp2`, `~/code/myapp3`, and `~/code/myapp4`, each on its own branch.

```
git-make-worktrees 3
```

### git-branch-prune

Tears down everything `git-make-worktrees` set up: removes all worktrees except the main one, deletes all local branches except `main` and `develop`, and runs `git fetch --prune`. Pass `--force` to force-remove worktrees with uncommitted changes and force-delete unmerged branches.

```
git-branch-prune
git-branch-prune --force
```

### git-commits-on

Finds every commit authored on a given date across all the git repos under a folder. It recurses through subfolders but stops descending the moment it hits a `.git`, so pointing it at `~/repos` scans `~/repos` and `~/repos/onebusaway` without diving into the innards of each individual repo.

Dates are `YYYY-MM-DD` or `MM-DD` (current year), and leading zeros are optional — `5-1`, `05-01`, and `2026-05-01` all work. A commit matches if its author date, in the commit's own timezone, falls on that day. All local branches are scanned and deduped.

```
git-commits-on 5-1 ~/repos
git-commits-on 2026-05-01 ~/repos --author aaron --long
```

The default output is one line per commit (`{sha} {author} {subject}`), grouped by repo:

```
/Users/aaron/repos/aaron-zsh

2026-05-01

a1b2c3d Aaron Brethorst Fix date parsing
```

Pass `--long` for the full message, author email, and timestamp; pass `--author <substr>` to filter by a case-insensitive substring of `Name <email>`. The `path` argument defaults to the current directory.

### git-tools.zsh

Zsh shell functions (`git-make-wt`, `git-branch-prune`) that do the same thing as the standalone scripts. Source this file in your `.zshrc` if you prefer shell functions over standalone commands.

## Setup

The Python scripts use [uvx](https://docs.astral.sh/uv/concepts/tools/) as their runner — no virtualenv or `pip install` needed. Just make sure `uv` is installed and the scripts are on your `PATH`.

```
# Copy or symlink the scripts somewhere on your PATH
cp git-make-worktrees git-branch-prune git-commits-on ~/.local/bin/
```
