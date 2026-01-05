#!/usr/bin/env bash
set -euo pipefail

# Temporary clone directory
TMP_DIR="$(mktemp -d)"
git clone https://github.com/vinceliuice/Colloid-gtk-theme "$TMP_DIR"
chmod +x "$TMP_DIR/install.sh"

SRC_DIR="$TMP_DIR/src"
DEST_DIR="/usr/share/themes"
THEME_NAME="Colloid"
COLOR_VARIANT="-Light"   # Options: -Light, -Dark, or "" for standard
SIZE_VARIANT=""          # Options: "" or -Compact

# Ensure sassc exists
command -v sassc >/dev/null || { echo "sassc is required. Install it first."; exit 1; }

# Prepare the tweaks-temp file (required for SASS imports)
mkdir -p "$SRC_DIR/sass"
cp "$SRC_DIR/sass/_tweaks.scss" "$SRC_DIR/sass/_tweaks-temp.scss"

# ============================= GTK2 =============================
mkdir -p "$DEST_DIR/$THEME_NAME/gtk-2.0"
cp -r "$SRC_DIR/main/gtk-2.0/"* "$DEST_DIR/$THEME_NAME/gtk-2.0"

# ============================= GTK3 =============================
mkdir -p "$DEST_DIR/$THEME_NAME/gtk-3.0"
sassc -t expanded "$SRC_DIR/main/gtk-3.0/gtk$COLOR_VARIANT.scss" \
      "$DEST_DIR/$THEME_NAME/gtk-3.0/gtk.css"
sassc -t expanded "$SRC_DIR/main/gtk-3.0/gtk-Dark.scss" \
      "$DEST_DIR/$THEME_NAME/gtk-3.0/gtk-dark.css"

# ============================= GTK4 =============================
mkdir -p "$DEST_DIR/$THEME_NAME/gtk-4.0"
sassc -t expanded "$SRC_DIR/main/gtk-4.0/gtk$COLOR_VARIANT.scss" \
      "$DEST_DIR/$THEME_NAME/gtk-4.0/gtk.css"
sassc -t expanded "$SRC_DIR/main/gtk-4.0/gtk-Dark.scss" \
      "$DEST_DIR/$THEME_NAME/gtk-4.0/gtk-dark.css"

# ============================= Libadwaita =============================
LIBAWAYTA_DIR="$HOME/.config/gtk-4.0"
mkdir -p "$LIBAWAYTA_DIR/assets"
cp -r "$SRC_DIR/assets/gtk/assets/"* "$LIBAWAYTA_DIR/assets"
cp -r "$SRC_DIR/assets/gtk/symbolics/"* "$LIBAWAYTA_DIR/assets"

sassc -t expanded "$SRC_DIR/main/libadwaita/libadwaita$COLOR_VARIANT.scss" \
      "$LIBAWAYTA_DIR/gtk.css"

# ============================= Cleanup =============================
rm -rf "$TMP_DIR"
echo "Colloid GTK theme installed successfully to $DEST_DIR and libadwaita."
