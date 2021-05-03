#!/usr/bin/env bash

# add the flathub server
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# add gcc if necessary?
# sudo flatpak -y install org.freedesktop.Sdk.Extension.gcc8

# install this in a toolbox
toolbox create

# clone the repo
if [ -d "$HOME/fedora-setup" ]; then
  echo Repo downloaded starting setup...
else
  echo Downloading repo...
  git clone https://github.com/jhessin/fedora-setup.git $HOME/fedora-setup
fi

# setup google launcher
cd ~/fedora-setup
xdg-icon-resource --size 256 google-chrome.png
cp google-chrome.desktop ~/.local/share/applications/

echo "
The rest of the setup needs to be run inside your toolbox:
toolbox enter
cd ~/fedora-setup
./setup.sh
"
