# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A collection of personal git helper utilities for zsh. No build system, no tests, no dependencies beyond git and Python 3.11+.

## Files

- **git-tools.zsh** — Zsh functions meant to be sourced into a shell session:
  - `git-make-wt <n>` — Creates n additional git worktrees as sibling directories (e.g. `repo2`, `repo3`), each on a new branch derived from the current branch.
  - `git-branch-prune [--force]` — Removes all worktrees (except the main one), deletes all local branches except `main` and `develop`, then runs `git fetch --prune`.

- **git-make-worktrees** — Standalone Python equivalent of `git-make-wt`, runnable via `uvx`. Uses PEP 723 inline script metadata.

## Conventions

- Zsh functions use `git-` prefix naming.
- Protected branches are `main` and `develop` — never auto-delete these.
- The Python script targets Python 3.11+ and uses `uvx` as its script runner (shebang: `#!/usr/bin/env -S uvx python3`).
