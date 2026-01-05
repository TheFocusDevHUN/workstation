#!/usr/bin/env bash
set -euo pipefail

TMP_DIR="$(mktemp -d)"

# Clone full repo
git clone https://github.com/vinceliuice/Colloid-icon-theme "$TMP_DIR"

# Make sure the script is executable
chmod +x "$TMP_DIR/install.sh"

# Destination directory
DEST_DIR="/usr/share/icons"
mkdir -p "$DEST_DIR"

# Options: theme variants, bold, notint, schemes
THEME_NAME="Colloid"
THEME_VARIANT=""
SCHEME_VARIANT=""
BOLD="--bold"
NOTINT="--notint"

# Run installer safely
"$TMP_DIR/install.sh" \
    --dest "$DEST_DIR" \
    --theme blue \
    $BOLD \
    $NOTINT

# Clean up
rm -rf "$TMP_DIR"

echo "Colloid icon theme installed successfully to $DEST_DIR."
