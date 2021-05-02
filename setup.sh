#!/usr/bin/env bash

# clone the repo
if [ -d "$HOME/fedora-setup" ]; then
  echo Repo downloaded starting setup...
else
  echo Downloading repo...
  git clone https://github.com/jhessin/fedora-setup.git $HOME/fedora-setup
fi

# add repo for enpass password manager
sudo dnf config-manager --add-repo \
  https://yum.enpass.io/enpass-yum.repo

# add repo for github cli tool
sudo dnf config-manager --add-repo \
  https://cli.github.com/packages/rpm/gh-cli.repo

# install dnf packages
sudo dnf -y install cat $HOME/fedora-setup/dnf.packages

# setup gh login
echo Logging in to github - Ctrl-C if this is unnecessary
gh auth login

# remap the keyboard properly
localectl set-x11-keymap us pc105 dvp compose:102,numpad:shift3,kpdl:semi,keypad:atm,caps:escape

# import all dconf settings/gsettings
dconf load / < $HOME/fedora-setup/dconf.settings

# copy bin from github
rm -rf $HOME/.local/bin
gh repo clone jhessin/bin $HOME/.local/bin

# add the bin to you path for tools
PATH=$PATH:$HOME/.local/bin

# copy config from github
pushd $HOME/.config
gmerge .config
popd

# setup zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# setup zinit
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

# setup neovim
pip install pynvim --user
$HOME/config/nvim/install.sh

# add util-linux-user and configure zsh as default shell
chsh -s /usr/bin/zsh

# setup pluckey
$HOME/fedora-setup/pluck-setup.sh
