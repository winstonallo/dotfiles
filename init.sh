#!/bin/bash

sudo apt update
sudo apt install -y zsh git

if [ ! -f ~/.ssh/id_ed25519 ]; then
  ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
  echo "SSH public key:"
  cat ~/.ssh/id_ed25519.pub
else
  echo "SSH key already exists."
fi

sudo apt install -y neovim golang rustup

rustup default stable

for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
  sudo apt-get remove -y $pkg
done

sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

if [ -d ~/.config ]; then
  echo "~/.config directory already exists. Skipping git clone."
else
  git clone https://github.com/winstonallo/.config.git ~/.config
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
  ln -s ~/.config/.zshrc ~/.zshrc
fi
