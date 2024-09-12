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
alias nsh="nix-shell ~/env/default.nix"
alias ni="nix-env -iA"

if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
    . ~/.nix-profile/etc/profile.d/nix.sh
fi

# Starts default nix-shell 
if [ -z "$IN_NIX_SHELL" ]; then
    echo "starting nix-shell.."
    nix-shell ~/.config/default.nix
fi

if [ -e /home/winstonallo/.nix-profile/etc/profile.d/nix.sh ]; then . /home/winstonallo/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
