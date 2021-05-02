#!/usr/bin/env bash

# add the flathub server
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# add gcc if necessary?
# sudo flatpak -y install org.freedesktop.Sdk.Extension.gcc8

# install this in a toolbox
toolbox create

# clone the repo
git clone https://github.com/jhessin/fedora-setup.git $HOME/fedora-setup
toolbox run $HOME/fedora-setup/setup.sh
