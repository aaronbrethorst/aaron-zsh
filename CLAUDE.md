# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A collection of personal git helper utilities for zsh. No build system, no tests, no dependencies beyond git and Python 3.11+.

## Files

- **git-tools.zsh** — Zsh functions meant to be sourced into a shell session:
  - `git-make-wt <n>` — Creates n additional git worktrees as sibling directories (e.g. `repo2`, `repo3`), each on a new branch derived from the current branch.
  - `git-branch-prune [--force]` — Removes all worktrees (except the main one), deletes all local branches except `main` and `develop`, then runs `git fetch --prune`.

- **git-make-worktrees** — Standalone Python equivalent of `git-make-wt`, runnable via `uvx`. Uses PEP 723 inline script metadata.

- **git-branch-prune** — Standalone Python equivalent of `git-branch-prune` from git-tools.zsh, runnable via `uvx`. Accepts optional `--force` flag.

- **git-commits-on** — Standalone Python script (PEP 723, runnable via `uvx`) that finds commits authored on a given date across every git repo under a folder. Recurses into subfolders but stops descending once it finds a `.git`. Date is `YYYY-MM-DD` or `MM-DD` (current year), leading zeros optional. Matches the author date in the commit's own timezone across all local branches (deduped). Defaults to one line per commit; `--long` adds email, full timestamp, and the complete message. `--author` filters by a case-insensitive substring of `Name <email>`.

## Conventions

- Zsh functions use `git-` prefix naming.
- Protected branches are `main` and `develop` — never auto-delete these.
- Python scripts target Python 3.11+ and use `uvx` as their script runner (shebang: `#!/usr/bin/env -S uvx python3`).
