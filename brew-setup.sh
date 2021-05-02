#!/usr/bin/env zsh

# setup homebrew
if [ -d "/home/linuxbrew" ]; then
  echo Linuxbrew installed
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/jhessin/.bash_profile
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# add and configure gh (github cli)
brew install gh
gh auth login

# copy dotfiles from github
pushd ~
gmerge dotfiles
popd

# copy this repo if necessary
if [ -d "$HOME/Documents/github/fedora-setup" ]; then
  echo fedora-setup directory exists
else
  gh repo clone jhessin/fedora-setup ~/Documents/github/fedora-setup
fi
