#!/usr/bin/env bash

# Capture JSON input
input=$(cat)

# Extract fields from JSON
model_display=$(echo "$input" | jq -r '.model.display_name // empty')
current_dir=$(echo "$input" | jq -r '.workspace.current_dir // empty')
project_dir=$(echo "$input" | jq -r '.workspace.project_dir // empty')
git_worktree=$(echo "$input" | jq -r '.workspace.git_worktree // empty')
session_name=$(echo "$input" | jq -r '.session_name // empty')
output_style=$(echo "$input" | jq -r '.output_style.name // empty')
context_used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
context_remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
five_hr_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
seven_day_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
vim_mode=$(echo "$input" | jq -r '.vim.mode // empty')
agent_name=$(echo "$input" | jq -r '.agent.name // empty')
worktree_name=$(echo "$input" | jq -r '.worktree.name // empty')

# Get git branch (skip locks)
git_branch=""
git_dir=$(git -C "$current_dir" rev-parse --git-dir 2>/dev/null) || true
if [ -n "$git_dir" ]; then
  branch=$(git -C "$current_dir" branch --show-current 2>/dev/null) || true
  if [ -n "$branch" ]; then
    git_branch="$branch"
  fi
fi

# Shorten directory path
if [ -n "$project_dir" ] && [ "$current_dir" = "$project_dir" ]; then
  dir_display=$(basename "$current_dir")
else
  dir_display=$(basename "$current_dir")
fi

# Get OS icon
if [[ "$OSTYPE" == darwin* ]]; then
  os_icon="󰀵"
else
  os_icon="󰌽"
fi

# Build status line segments using printf for colors
# Color scheme based on your Starship One Dark palette
GREEN='\033[38;2;152;195;121m'  # color_green
RED='\033[38;2;224;108;117m'    # color_red0
ORANGE='\033[38;2;209;154;102m' # color_orange
YELLOW='\033[38;2;229;192;123m' # color_yellow
CYAN='\033[38;2;86;182;194m'    # color_cyan
BLUE='\033[38;2;97;175;239m'    # color_blue
PURPLE='\033[38;2;198;120;221m' # color_purple
GRAY='\033[38;2;95;107;130m'    # mono4
RESET='\033[0m'

# Start building the status line
output=""

# OS icon
if [ -n "$os_icon" ]; then
  output+="$(printf "${GREEN}${os_icon}${RESET} ")"
fi

# Directory
output+="$(printf "${RED}${dir_display}${RESET}")"

# Git branch
if [ -n "$git_branch" ]; then
  output+=" $(printf "${ORANGE}○${RESET} ${git_branch}")"
fi

# Vim mode
if [ -n "$vim_mode" ]; then
  output+=" $(printf "${CYAN}${vim_mode}${RESET}")"
fi

# Agent mode
if [ -n "$agent_name" ]; then
  output+=" $(printf "${PURPLE}${agent_name}${RESET}")"
fi

# Worktree
if [ -n "$worktree_name" ]; then
  output+=" $(printf "${BLUE}⟨${worktree_name}⟩${RESET}")"
fi

# Context usage
if [ -n "$context_remaining" ]; then
  if [ "$context_remaining" -lt 20 ]; then
    output+=" $(printf "${RED}ctx: ${context_remaining}%%${RESET}")"
  elif [ "$context_remaining" -lt 50 ]; then
    output+=" $(printf "${YELLOW}ctx: ${context_remaining}%%${RESET}")"
  else
    output+=" $(printf "${GREEN}ctx: ${context_remaining}%%${RESET}")"
  fi
fi

# Rate limits (5-hour and 7-day)
if [ -n "$five_hr_pct" ] || [ -n "$seven_day_pct" ]; then
  rate_info=""
  if [ -n "$five_hr_pct" ]; then
    rate_info+="5h:${five_hr_pct}%%"
  fi
  if [ -n "$seven_day_pct" ]; then
    if [ -n "$rate_info" ]; then
      rate_info+=" "
    fi
    rate_info+="7d:${seven_day_pct}%%"
  fi
  output+=" $(printf "${GRAY}${rate_info}${RESET}")"
fi

# Output style
if [ -n "$output_style" ] && [ "$output_style" != "default" ]; then
  output+=" $(printf "${BLUE}${output_style}${RESET}")"
fi

# Print the final status line
echo "$output"
