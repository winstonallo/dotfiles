export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git docker python golang docker-compose git-auto-fetch rust alias-finder ssh)

# Enables autoload of alias-finder, disabled by default
zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' longer yes
zstyle ':omz:plugins:alias-finder' exact yes
zstyle ':omz:plugins:alias-finder' cheaper yes

source $ZSH/oh-my-zsh.sh

alias gcl="git -c http.sslVerify=false clone"

export PATH="$PATH:/home/arthur/.cargo/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:/opt/homebrew/bin"

# Binaries installed with pip
export PATH="$PATH:/home/arthur/.local/bin/"
