#!/usr/bin/env bash
set -euo pipefail

SDDM_THEME_DIR="/usr/share/sddm/themes"
KVANTUM_DIR="/usr/share/Kvantum"
TMP_DIR="$(mktemp -d)"

git clone https://github.com/vinceliuice/Colloid-kde "$TMP_DIR"

mkdir -p "$SDDM_THEME_DIR" "$KVANTUM_DIR"

install_sddm_variant() {
  local color="$1"
  local name="Colloid${color}"

  rm -rf "${SDDM_THEME_DIR}/${name}"
  cp -r "${TMP_DIR}/sddm/6.0/Colloid" "${SDDM_THEME_DIR}/${name}"

  # required background
  cp "${TMP_DIR}/sddm/6.0/images/Colloid${color}.png" \
     "${SDDM_THEME_DIR}/${name}/background.png"

  # strip preview
  rm -f "${SDDM_THEME_DIR}/${name}/Preview.png"
  sed -i "/Preview=/d" "${SDDM_THEME_DIR}/${name}/metadata.desktop"

  # rename theme internally
  sed -i "s/Colloid/${name}/g" \
    "${SDDM_THEME_DIR}/${name}/metadata.desktop" \
    "${SDDM_THEME_DIR}/${name}/Main.qml"
}

install_sddm_variant "-light"
install_sddm_variant "-dark"

# Kvantum theme (no extras)
rm -rf "${KVANTUM_DIR}/Colloid"
cp -r "${TMP_DIR}/Kvantum/Colloid" "${KVANTUM_DIR}/Colloid"

rm -rf "$TMP_DIR"
