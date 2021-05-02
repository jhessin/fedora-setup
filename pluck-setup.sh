#!/usr/bin/env bash

# remove old firefox only works on standard workstation
sudo dnf -y remove firefox

sudo $HOME/fedora-setup/pluck.installer

pluck import $HOME/fedora-setup/pluck.settings
