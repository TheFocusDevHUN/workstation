#!/usr/bin/env bash

set -oue pipefail

git clone https://github.com/vinceliuice/Colloid-icon-theme icon_theme/
./icon_theme/install --dest /usr/share/icons \
--theme blue \
--bold \
--notint
