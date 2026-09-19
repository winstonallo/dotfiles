export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git python git-auto-fetch rust alias-finder ssh globalias)

GLOBALIAS_FILTER_VALUES=(grep ls)

# Enables autoload of alias-finder, disabled by default
zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' longer yes
zstyle ':omz:plugins:alias-finder' exact yes
zstyle ':omz:plugins:alias-finder' cheaper yes

source "$ZSH/oh-my-zsh.sh"

alias glo="git log"
alias gc="git commit --signoff --verbose"
alias gc!="git commit --signoff --amend --verbose"
alias gse="git send-email --suppress-cc=all"
alias grbx="git rebase -x"
alias grbim="git rebase --interactive origin/master"
alias gw="git worktree"
alias gwls="git worktree list"
alias gwmv="git worktree move"
alias gwrm="git worktree remove"
alias apply="b4 shazam -t"
alias clip="xclip -selection clipboard"
alias fzed='zed "$(fzf -i)"'

function gpsu() {
    git push --set-upstream "$1" "$(git_current_branch)"
}

function tmx() {
    (( $# )) || { echo "usage: tmx host [host...]" >&2; return 2; }

    local cmd=(tmux new-session)
    local arg first=1
    for arg in "$@"; do
        (( first )) || cmd+=(';' split-window ';' select-layout tiled)
        cmd+=(';' send-keys "ssh root@$arg" C-m)
        first=0
    done
    cmd+=(';' select-layout tiled ';' setw synchronize-panes on)

    printf '%q ' "${cmd[@]}"; printf '\n'   # drop this once it works
    "${cmd[@]}"
}

eval "$(starship init zsh)"

source <(fzf --zsh)

PATH="$PATH:/opt/nvim-linux-arm64/bin"; export PATH;
PATH="$PATH:$HOME/.local/bin"; export PATH;
PATH="$PATH:/usr/sbin"; export PATH;
PATH="$PATH:/home/$USER/.cargo/bin"; export PATH;
PATH="$PATH:/home/$USER/.local/bin"; export PATH;

export EDITOR="nvim"

autoload -U compinit
compinit

