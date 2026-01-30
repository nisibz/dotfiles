##### ENVIRONMENT VARIABLES #####
export EDITOR='nvim'
export VISUAL='nvim'
command -v nvim >/dev/null && export MANPAGER='nvim +Man!'
alias n=$EDITOR

##### HISTORY CONFIGURATION #####
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt BANG_HIST EXTENDED_HISTORY INC_APPEND_HISTORY SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS HIST_VERIFY
setopt AUTO_CD
setopt GLOB_DOTS
setopt INTERACTIVE_COMMENTS

##### PATH MANAGEMENT #####
path_add() {
    [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]] && export PATH="$1:$PATH"
}

path_add "$HOME/bin"
path_add "$HOME/.local/bin"
path_add "$HOME/.cargo/bin"
path_add "$HOME/.opencode/bin"
path_add "$HOME/fvm/default/bin"

if [[ "$OSTYPE" == darwin* ]]; then
    path_add "/opt/homebrew/bin"
    path_add "/opt/homebrew/sbin"
    path_add "$HOME/Library/pnpm"

    if [ -d "$HOME/Library/Android/sdk" ]; then
        export ANDROID_HOME="$HOME/Library/Android/sdk"
        path_add "$ANDROID_HOME/platform-tools"
        path_add "$ANDROID_HOME/cmdline-tools/latest/bin"
    fi
elif [[ "$OSTYPE" == linux* ]]; then
    path_add "/home/linuxbrew/.linuxbrew/bin"
    path_add "$HOME/.pnpm"
fi

##### ZINIT & PLUGINS (Turbo Mode) #####
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
[ -d "$ZINIT_HOME/.git" ] || {
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
}
source "$ZINIT_HOME/zinit.zsh"

# Snippets with Turbo Mode
zinit wait'!' lucid for \
    OMZP::git \
    OMZP::sudo \
    OMZP::copyfile \
    OMZP::copybuffer \
    OMZP::tmux \
    OMZP::tmuxinator \
    OMZP::dirhistory \
    OMZP::z \
    OMZP::docker \
    OMZP::docker-compose

# Core Plugins
zinit light-mode for \
    zsh-users/zsh-completions \
    MichaelAquilina/zsh-you-should-use \
    marlonrichert/zsh-autocomplete

# Visual/Deferred Plugins (Loaded last for performance)
zinit wait lucid atinit"zpcompinit; zpcdreplay" for \
    zdharma-continuum/fast-syntax-highlighting \
    zsh-users/zsh-history-substring-search

##### ALIASES #####
alias c='clear'
alias cc='claude'
alias pn='pnpm'
alias op='opencode'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Eza Logic
if command -v eza >/dev/null; then
    alias ls='eza -a --icons=always'
    alias ll='eza -al --icons=always'
    alias la='eza -la --icons=always'
    alias lx='eza -lbhHigUmuSa --time-style=long-iso --git --color-scale --icons=always'
    alias lt='eza -a --tree --level=1 --icons=always'
    alias lt2='eza -a --tree --level=2 --icons=always'
    alias lt3='eza -a --tree --level=3 --icons=always'
    alias tree='eza --tree --icons=always'
    alias lsize='eza -1 --icons=always --sort=size'
    alias ltime='eza -1 --icons=always --sort=modified'
fi

##### PROMPT #####
command -v starship >/dev/null && eval "$(starship init zsh)"
