#!/usr/bin/env bash

# add repo for enpass password manager
sudo dnf config-manager --add-repo \
  https://yum.enpass.io/enpass-yum.repo

# add repo for github cli tool
sudo dnf config-manager --add-repo \
  https://cli.github.com/packages/rpm/gh-cli.repo

# install dnf packages
sudo dnf -y install \
  $(curl -fsSL https://raw.githubusercontent.com/jhessin/fedora-setup/master/dnf.packages)

# setup gh login
echo Logging in to github - Ctrl-C if this is unnecessary
gh auth login

# remap the keyboard properly
localectl set-x11-keymap us pc105 dvp compose:102,numpad:shift3,kpdl:semi,keypad:atm,caps:escape

# import all dconf settings/gsettings
dconf load / < $(curl -fsSL
https://raw.githubusercontent.com/jhessin/fedora-setup/master/dconf.settings)

# copy bin from github
rm -rf $HOME/.local/bin
gh repo clone jhessin/bin $HOME/.local/bin

# add the bin to you path for tools
PATH=$PATH:$HOME/.local/bin

# copy config from github
pushd $HOME/config
gmerge .config
popd

# setup zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

# setup neovim
pip install pynvim --user
$HOME/config/nvim/install.sh

# add util-linux-user and configure zsh as default shell
chsh -s /usr/bin/zsh

# setup pluckey
"$HOME/Documents/github/fedora-setup/pluck-setup.sh"
sh -c "$(curl -fsSL
https://raw.githubusercontent.com/jhessin/fedora-setup/pluck-setup.sh)"
