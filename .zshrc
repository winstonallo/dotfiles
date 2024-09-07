export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git docker python golang docker-compose git-auto-fetch rust alias-finder ssh)

zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' longer yes
zstyle ':omz:plugins:alias-finder' exact yes
zstyle ':omz:plugins:alias-finder' cheaper yes

source $ZSH/oh-my-zsh.sh

if [ -z "$IN_NIX_SHELL" ]; then
    echo "starting nix-shell.."
    nix-shell ~/env/default.nix
fi
