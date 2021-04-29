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

# focus follows mouse
gsettings set org.gnome.desktop.wm.preferences focus-mode 'sloppy'
gsettings set org.gnome.mutter center-new-windows true

# right click windowshade
gsettings set org.gnome.desktop.wm.preferences action-right-click-titlebar 'toggle-shade'

# turn off hot corners
gsettings set org.gnome.desktop.interface enable-hot-corners false

# show everything on the clock and battery
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface show-battery-percentage true

# ctrl locates the pointer
gsettings set org.gnome.desktop.interface locate-pointer true

# programmer dvorak tweaks
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape', 'keypad:atm']"

# Dark theme
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

# boost speakers
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true

# default extensions
gsettings set org.gnome.shell enabled-extensions "['background-logo@fedorahosted.org', 'apps-menu@gnome-shell-extensions.gcampax.github.com', 'places-menu@gnome-shell-extensions.gcampax.github.com', 'window-list@gnome-shell-extensions.gcampax.github.com']"


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
if [ -d "~/Documents/github/fedora-setup" ]; then
  gh repo clone jhessin/fedora-setup ~/Documents/github/fedora-setup
else
  echo fedora-setup directory exists
fi

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

# setup pluckey
"$HOME/Documents/github/fedora-setup/pluck-setup.sh"
