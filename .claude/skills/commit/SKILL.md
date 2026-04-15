---
name: commit
description: Create a git commit
when_to_use: When the user wants to commit changes to git. Always use for creating commits with appropriate commit messages.
---

# Git Commit Skill

Create a git commit with an appropriate commit message based on the changes.

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`

## Your task

1. Analyze the diff content to understand the nature and purpose of the changes
2. Generate 3 commit message candidates based on the changes
   - Each candidate should be concise, clear, and capture the essence of the changes
   - Prefer Conventional Commits format (feat:, fix:, docs:, refactor:, etc.)
3. Select the most appropriate commit message from the 3 candidates and explain the reasoning for your choice
4. Stage changes if necessary using git add
5. Execute git commit using the selected commit message

## Constraints

- DO NOT add Claude co-authorship footer to commits
- Just oneline commit message
