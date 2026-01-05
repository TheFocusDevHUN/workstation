#!/usr/bin/env bash

set -oue pipefail

git clone https://github.com/vinceliuice/Colloid-gtk-theme/ gtk_theme/
./gtk_theme/install --dest /usr/share/themes \
--theme blue \
--libadwaita system \
--size all \
--tweaks normal
