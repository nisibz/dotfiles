export EDITOR='nvim'

alias n=$EDITOR

alias c=clear
alias cc=claude
alias pn=pnpm

alias mux=tmuxinator
alias muxs='tmuxinator start'
alias muxp='tmuxinator stop'

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
