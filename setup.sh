#!/usr/bin/env bash

# install function
function dnfinstall {
  sudo dnf -y install $1
}

# add repositories
dnfinstall fedora-workstation-repositories
# sudo dnf config-manager --set-enabled # Some repositories to enable?

# Add gnome-tweaks and set the most important settings
dnfinstall gnome-tweaks
dnfinstall gnome-extensions-app

# remap the keyboard properly
localectl set-x11-keymap us pc105 dvp compose:102,numpad:shift3,kpdl:semi,keypad:atm,caps:escape

# import all dconf settings/gsettings
dconf load / < "$HOME/Documents/github/fedora-setup/dconf.settings"

# copy bin from github
pushd ~/.local/bin
gh repo clone jhessin/bin ~/.local/bin

# copy config from github
pushd ~/.config
# gmerge .config
rm -rf .git
git init
git remote add origin git@github.com:$USER/.config
git fetch
git reset origin/master
git reset --hard
git push -u origin master
popd

# setup zsh
dnfinstall zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"


# setup neovim
dnfinstall neovim
pip install pynvim --user
~/.config/nvim/install.sh

# add util-linux-user and configure zsh as default shell
dnfinstall neofetch
dnfinstall util-linux-user
chsh -s /usr/bin/zsh

# add powerline
dnfinstall powerline

# add ripgrep
dnfinstall ripgrep

# add ruby support
dnfinstall rubypick

# add enpass password manager
pushd /etc/yum.repos.d/
sudo wget https://yum.enpass.io/enpass-yum.repo
popd
dnfinstall enpass

# add yarn
dnfinstall yarnpkg

# add fzf
dnfinstall fzf

# setup pluckey
"$HOME/Documents/github/fedora-setup/pluck-setup.sh"
