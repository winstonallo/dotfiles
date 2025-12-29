#!/bin/bash

sudo apt update
sudo apt install -y neovim curl git zsh

if [ ! -f ~/.ssh/id_ed25519 ]; then
  ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
  echo "SSH public key:"
  cat ~/.ssh/id_ed25519.pub
else
  echo "SSH key already exists."
fi


curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

rustup component add rust-analyzer

if [ -d ~/.config ]; then
  echo "~/.config directory already exists. Skipping git clone."
else
  git clone https://github.com/winstonallo/dotfiles.git
  ln -s dotfiles .config
fi

if [ ! -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y
else
  echo "Oh My Zsh is already installed."
fi

if [ -L ~/.zshrc ]; then
  echo "Symlink for .zshrc already exists."
else
  rm -f ~/.zshrc
  ln -s ~/dotfiles/.zshrc ~/.zshrc
fi
