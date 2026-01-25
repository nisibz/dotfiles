export EDITOR='nvim'

alias n=$EDITOR

alias c=clear
alias cc=claude
alias pn=pnpm

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# Enhanced ls with eza 
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

 # History configuration
 HISTFILE=~/.zsh_history
 HISTSIZE=100000
 SAVEHIST=100000

 setopt BANG_HIST                 # Treat the '!' character specially during expansion.
 setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
 setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
 setopt SHARE_HISTORY             # Share history between all sessions.
 setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
 setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
 setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
 setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
 setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
 setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
 setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
 setopt HIST_BEEP                 # Beep when accessing non-existent history.

eval "$(starship init zsh)"

# Source local machine-specific configuration
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::web-search
zinit snippet OMZP::copyfile
zinit snippet OMZP::copybuffer
zinit snippet OMZP::tmux
zinit snippet OMZP::tmuxinator
zinit snippet OMZP::dirhistory
zinit snippet OMZP::z
zinit snippet OMZP::docker
zinit snippet OMZP::docker-compose

# External plugins 

zinit light "zsh-users/zsh-autosuggestions"
zinit light "zsh-users/zsh-syntax-highlighting"
zinit light "zdharma-continuum/fast-syntax-highlighting"
zinit light "marlonrichert/zsh-autocomplete"
zinit light "MichaelAquilina/zsh-you-should-use"
zinit light "zsh-users/zsh-completions"
zinit light "zsh-users/zsh-history-substring-search"

# opencode
export PATH=/Users/nantachai.s/.opencode/bin:$PATH

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
