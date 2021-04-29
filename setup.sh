#!/usr/bin/env bash

# add repositories
sudo dnf install fedora-workstation-repositories
# sudo dnf config-manager --set-enabled # Some repositories to enable?

# setup homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/jhessin/.bash_profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"


# Add gnome-tweaks and set the most important settings
sudo dnf install gnome-tweaks
sudo dnf install gnome-extensions-app

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

# copy this repo if necessary
if [ -d "~/Documents/github/fedora-setup" ]; then
  gh repo clone jhessin/fedora-setup ~/Documents/github/fedora-setup
else
  echo fedora-setup directory exists
fi

# copy bin from github
rm -rf ~/.local/bin
gh repo clone jhessin/bin ~/.local/bin

# copy config from github
cd ~/.config
gmerge .config

# setup zsh
sudo dnf install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# copy dotfiles from github
cd ~
gmerge dotfiles

# setup neovim
sudo dnf install neovim
pip install pynvim --user
nvim/install.sh

# add util-linux-user and configure zsh as default shell
sudo dnf install neofetch
sudo dnf install util-linux-user
chsh -s /usr/bin/zsh

# add powerline
sudo dnf install powerline

# add ripgrep
sudo dnf install ripgrep

# add ruby support
sudo dnf install rubypick

# setup pluckey
~/Documents/github/fedora-setup/pluck-setup.sh
