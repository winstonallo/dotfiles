export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git docker python golang docker-compose git-auto-fetch rust alias-finder ssh)

# Enables autoload of alias-finder, disabled by default
zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' longer yes
zstyle ':omz:plugins:alias-finder' exact yes
zstyle ':omz:plugins:alias-finder' cheaper yes

source $ZSH/oh-my-zsh.sh

# Fixes broken dependency issue in go-sqlite
export GOFLAGS="-tags=sqlite_omit_load_extension,libsqlite3"
export PATH=$PATH:$(go env GOPATH)/bin

alias gcl="git -c http.sslVerify=false clone"

