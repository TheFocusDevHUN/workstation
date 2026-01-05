#!/usr/bin/env bash

set -oue pipefail

git clone https://github.com/vinceliuice/Colloid-kde kde_theme/
./kde_theme/sddm/6.0/install
cp -r kde_theme/Kvantum/Colloid /usr/share/Kvantum/Colloid
