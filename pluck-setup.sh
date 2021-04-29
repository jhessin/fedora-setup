#!/usr/bin/env zsh

# install google chrome if necessary
if [ -e "/usr/bin/google-chrome" ]; then
  echo Google Chrome already installed.
else
  wget "https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm" \
    -O google-chrome-stable_current_x86_64.rpm

  sudo dnf -y localinstall google-chrome-stable_current_x86_64.rpm
  # cleanup download
  rm google-chrome-stable_current_x86_64.rpm
fi

# # setup firefox-esr
# if [ -e "/usr/local/bin/firefox-esr" ]; then
#   echo Firefox ESR already installed.
# else
#   wget "https://download.mozilla.org/?product=firefox-esr-latest-ssl&os=linux64&lang=en-US"\
#     -O firefox.tar.bz2
#
#   tar xaf firefox.tar.bz2
#   sudo chown -R root:root firefox
#   sudo mv firefox /opt/firefox-esr
#   sudo ln -s /opt/firefox-esr/firefox /usr/local/bin/firefox-esr
#   sudo cp firefox-esr.desktop /usr/share/applications
#   # cleanup firefox download
#   rm firefox.tar.bz2
# fi

# remove old firefox
sudo dnf -y remove firefox

sudo "$HOME/Documents/github/fedora-setup/pluck.installer"

pluck import pluck.settings
