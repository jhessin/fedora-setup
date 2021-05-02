#!/usr/bin/env zsh

# remove old firefox
sudo dnf -y remove firefox

sudo sh -c $(curl -fsSL https://raw.githubusercontent.com/jhessin/fedora-setup/master/pluck.installer)

pluck import $(curl -fsSL https://raw.githubusercontent.com/jhessin/fedora-setup/master/pluck.settings)
