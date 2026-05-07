#!/usr/bin/env bash

# Capture JSON input
input=$(cat)

# Extract fields from JSON
current_dir=$(echo "$input" | jq -r '.workspace.current_dir // empty')
project_dir=$(echo "$input" | jq -r '.workspace.project_dir // empty')
total_duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // empty')
total_api_duration_ms=$(echo "$input" | jq -r '.cost.total_api_duration_ms // empty')
lines_added=$(echo "$input" | jq -r '.cost.total_lines_added // empty')
lines_removed=$(echo "$input" | jq -r '.cost.total_lines_removed // empty')
total_input_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
total_output_tokens=$(echo "$input" | jq -r '.context_window.total_output_tokens // empty')
context_window_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
context_used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
context_remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
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

# Format large numbers with k/m suffix
format_number() {
  num=$1
  if [ "$num" -ge 1000000 ]; then
    printf "%.0fm" "$(echo "scale=2; $num / 1000000" | bc -l)"
  elif [ "$num" -ge 1000 ]; then
    printf "%.0fk" "$(echo "scale=2; $num / 1000" | bc -l)"
  else
    printf "%s" "$num"
  fi
}

# Format total duration: largest unit only (S/M/H/D)
format_duration() {
  ms=$1
  if [ -z "$ms" ] || [ "$ms" = "null" ] || [ "$ms" = "0" ]; then
    return
  fi
  if [ "$ms" -ge 86400000 ]; then
    printf "%dd" $((ms / 86400000))
  elif [ "$ms" -ge 3600000 ]; then
    printf "%dh" $((ms / 3600000))
  elif [ "$ms" -ge 60000 ]; then
    printf "%dm" $((ms / 60000))
  elif [ "$ms" -ge 1000 ]; then
    printf "%ds" $((ms / 1000))
  else
    printf "%dms" "$ms"
  fi
}

# Format API duration: two largest units (Sec, M+S, H+M, D+H)
format_api_duration() {
  ms=$1
  if [ -z "$ms" ] || [ "$ms" = "null" ] || [ "$ms" = "0" ]; then
    return
  fi
  if [ "$ms" -ge 86400000 ]; then
    days=$((ms / 86400000))
    hours=$(((ms % 86400000) / 3600000))
    if [ "$hours" -gt 0 ]; then
      printf "%dd %dh" "$days" "$hours"
    else
      printf "%dd" "$days"
    fi
  elif [ "$ms" -ge 3600000 ]; then
    hours=$((ms / 3600000))
    minutes=$(((ms % 3600000) / 60000))
    if [ "$minutes" -gt 0 ]; then
      printf "%dh %dm" "$hours" "$minutes"
    else
      printf "%dh" "$hours"
    fi
  elif [ "$ms" -ge 60000 ]; then
    minutes=$((ms / 60000))
    seconds=$(((ms % 60000) / 1000))
    if [ "$seconds" -gt 0 ]; then
      printf "%dm %ds" "$minutes" "$seconds"
    else
      printf "%dm" "$minutes"
    fi
  elif [ "$ms" -ge 1000 ]; then
    printf "%ds" $((ms / 1000))
  else
    printf "%dms" "$ms"
  fi
}

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

# Token usage
if [ -n "$total_input_tokens" ] && [ -n "$total_output_tokens" ]; then
  total_tokens=$((total_input_tokens + total_output_tokens))
  if [ -n "$context_window_size" ]; then
    used_fmt=$(format_number "$total_tokens")
    max_fmt=$(format_number "$context_window_size")
    output+=" $(printf "${CYAN}${used_fmt}/${max_fmt} ${RESET}")"
  fi
fi

# Lines added/removed (git style)
if [ -n "$lines_added" ] && [ "$lines_added" != "null" ] && [ "$lines_added" != "0" ]; then
  output+=" $(printf "${GREEN}+${lines_added}${RESET}")"
fi
if [ -n "$lines_removed" ] && [ "$lines_removed" != "null" ] && [ "$lines_removed" != "0" ]; then
  output+=" $(printf "${RED}-${lines_removed}${RESET}")"
fi

# Duration info
if [ -n "$total_duration_ms" ] && [ "$total_duration_ms" != "null" ] && [ "$total_duration_ms" != "0" ]; then
  duration_fmt=$(format_duration "$total_duration_ms")
  if [ -n "$duration_fmt" ]; then
    output+=" $(printf "${YELLOW}⏱️ ${duration_fmt}${RESET}")"
  fi
fi
if [ -n "$total_api_duration_ms" ] && [ "$total_api_duration_ms" != "null" ] && [ "$total_api_duration_ms" != "0" ]; then
  api_duration_fmt=$(format_api_duration "$total_api_duration_ms")
  if [ -n "$api_duration_fmt" ]; then
    output+=" $(printf "${GRAY}🌐 ${api_duration_fmt}${RESET}")"
  fi
fi

# Print the final status line
echo "$output"
