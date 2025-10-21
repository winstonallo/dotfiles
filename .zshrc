export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git docker python golang docker-compose git-auto-fetch rust alias-finder ssh)

# Enables autoload of alias-finder, disabled by default
zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' longer yes
zstyle ':omz:plugins:alias-finder' exact yes
zstyle ':omz:plugins:alias-finder' cheaper yes

source $ZSH/oh-my-zsh.sh

alias k=kubectl

git config --global user.name "Arthur Bied-Charreton"
git config --global user.email "arthur@biedcharreton.com"
git config --global user.signingkey ~/.ssh/id_ed25519
git config --global commit.gpgsign true
git config --global gpg.format ssh

export UID=$(id -u $USER)
export GID=$(id -g $USER)

alias i386-elf-ld=ld
