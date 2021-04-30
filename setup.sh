#!/usr/bin/env bash

# install function
function dnfinstall {
  sudo dnf -y install $1
}

# add repositories
dnfinstall fedora-workstation-repositories
# sudo dnf config-manager --set-enabled # Some repositories to enable?

# setup homebrew
if [ -d "/home/linuxbrew" ]; then
  echo Linuxbrew installed
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/jhessin/.bash_profile
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi


# Add gnome-tweaks and set the most important settings
dnfinstall gnome-tweaks
dnfinstall gnome-extensions-app

# remap the keyboard properly
localectl set-x11-keymap us pc105 dvp compose:102,numpad:shift3,kpdl:semi,keypad:atm,caps:escape

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

# setup pluckey
"$HOME/Documents/github/fedora-setup/pluck-setup.sh"
