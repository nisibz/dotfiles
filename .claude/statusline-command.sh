#!/bin/sh
input=$(cat)

# =========================
# Colors
# =========================
GREEN=$'\e[38;2;152;195;121m'
RED=$'\e[38;2;224;108;117m'
ORANGE=$'\e[38;2;209;154;102m'
YELLOW=$'\e[38;2;229;192;123m'
CYAN=$'\e[38;2;86;182;194m'
BLUE=$'\e[38;2;97;175;239m'
PURPLE=$'\e[38;2;198;120;221m'
GRAY=$'\e[38;2;95;107;130m'
RESET=$'\e[0m'

# =========================
# Format duration
# arg1 = milliseconds
# arg2 = max units
# =========================
format_duration() {
  ms=$1
  max_units=$2

  [ -z "$ms" ] && ms=0

  d=$((ms / 86400000))
  h=$((ms / 3600000 % 24))
  m=$((ms / 60000 % 60))
  s=$((ms / 1000 % 60))
  ms=$((ms % 1000))

  count=0
  out=""

  append() {
    value=$1
    suffix=$2

    if [ "$value" -gt 0 ] || [ "$count" -gt 0 ]; then
      out="${out}${value}${suffix} "
      count=$((count + 1))
    fi
  }

  append "$d" "d"
  [ "$count" -lt "$max_units" ] && append "$h" "h"
  [ "$count" -lt "$max_units" ] && append "$m" "m"
  [ "$count" -lt "$max_units" ] && append "$s" "s"

  if [ "$count" -lt "$max_units" ]; then
    out="${out}${ms}ms"
  fi

  printf "%s" "$(echo "$out" | sed 's/[[:space:]]*$//')"
}

# =========================
# OS icon
# =========================
if [[ "$OSTYPE" == darwin* ]]; then
  os_icon="󰀵"
else
  os_icon="󰌽"
fi

# =========================
# Repo
# =========================
repo_root=$(cd "$current_dir" 2>/dev/null && git rev-parse --show-toplevel 2>/dev/null || echo "$current_dir")
dir_display=$(basename "$repo_root")

# =========================
# Git branch
# =========================
git_branch=""
git_dir=$(git -C "$current_dir" rev-parse --git-dir 2>/dev/null) || true

if [ -n "$git_dir" ]; then
  branch=$(git -C "$current_dir" branch --show-current 2>/dev/null) || true

  if [ -n "$branch" ]; then
    git_branch="$branch"
  fi
fi

# =========================
# Context usage
# =========================
used_percentage=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
max_ctx=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')
# Calculate used tokens from total input + output
used_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens + .context_window.total_output_tokens // 0')

used_k=$((used_tokens / 1000))
max_k=$((max_ctx / 1000))

if [ "$used_percentage" -ge 80 ]; then
  ctx_color=$RED
elif [ "$used_percentage" -ge 50 ]; then
  ctx_color=$YELLOW
else
  ctx_color=$GREEN
fi

# =========================
# Git changes
# =========================
lines_added=$(echo "$input" | jq -r '.cost.total_lines_added // 0')
lines_removed=$(echo "$input" | jq -r '.cost.total_lines_removed // 0')

# =========================
# Duration
# =========================
total_duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')
total_api_duration_ms=$(echo "$input" | jq -r '.cost.total_api_duration_ms // 0')

duration_text=$(format_duration "$total_duration_ms" 1)
api_duration_text=$(format_duration "$total_api_duration_ms" 2)

# =========================
# Segments
# =========================
os="${GREEN}${os_icon}${RESET}"
dir="${RED}${dir_display}${RESET}"
branch="${ORANGE}○${RESET} ${git_branch}"
ctx="${ctx_color}󰘦 ${used_k}k/${max_k}k (${used_percentage}%)${RESET}"
git_change="${GREEN}+${lines_added}${RESET} ${RED}-${lines_removed}${RESET}"
duration="${YELLOW}󰔛 ${duration_text}${RESET}"
api_duration="${GRAY}󰇚 ${api_duration_text}${RESET}"
# =========================
# Output
# =========================
printf "%s | %s | %s\n%s | %s | %s | %s\n" \
  "$os" \
  "$dir" \
  "$branch" \
  "$ctx" \
  "$git_change" \
  "$duration" \
  "$api_duration"
