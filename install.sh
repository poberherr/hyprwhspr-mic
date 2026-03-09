#!/bin/bash
# Install hyprwhspr-mic scripts and config.
#
# Creates symlinks in ~/.local/bin/ and copies example config if needed.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN_DIR="${HOME}/.local/bin"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/hyprwhspr-mic"
WAYBAR_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/waybar"

echo "Installing hyprwhspr-mic..."

# Ensure bin dir exists
mkdir -p "$BIN_DIR"

# Symlink scripts
for script in hyprwhspr-mic hyprwhspr-mic-common hyprwhspr-mic-waybar; do
  ln -sf "$SCRIPT_DIR/$script" "$BIN_DIR/$script"
  echo "  Linked $BIN_DIR/$script"
done

# Copy example config if no config exists yet
mkdir -p "$CONFIG_DIR"
if [[ ! -f "$CONFIG_DIR/config.json" ]]; then
  cp "$SCRIPT_DIR/config.example.json" "$CONFIG_DIR/config.json"
  echo "  Created $CONFIG_DIR/config.json (from example)"
else
  echo "  Config already exists at $CONFIG_DIR/config.json (skipped)"
fi

# Offer to install Waybar module
if [[ -d "$WAYBAR_DIR" ]]; then
  target="$WAYBAR_DIR/hyprwhspr-module.jsonc"
  ln -sf "$SCRIPT_DIR/waybar/hyprwhspr-module.jsonc" "$target"
  echo "  Linked $target"
  echo ""
  echo "Add this to your Waybar config to enable the module:"
  echo '  "include": ["~/.config/waybar/hyprwhspr-module.jsonc"]'
  echo '  "modules-right": [..., "custom/hyprwhspr", ...]'
fi

echo ""
echo "Done! Make sure ~/.local/bin is in your PATH."
