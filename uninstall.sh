#!/usr/bin/env bash
set -euo pipefail

BIN_FILE="$HOME/.local/bin/omarchy-screensaver"

echo "==> Uninstalling Omarchy Matrix Screensaver override..."

if [[ -f "$BIN_FILE" ]]; then
  rm -f "$BIN_FILE"
  echo "  [-] Removed $BIN_FILE (default /usr/share/omarchy/bin/omarchy-screensaver is now active)"
else
  echo "  [=] $BIN_FILE was not installed"
fi

if command -v hyprctl >/dev/null 2>&1 && hyprctl instances >/dev/null 2>&1; then
  hyprctl reload >/dev/null 2>&1 || true
fi

echo "==> Uninstall complete."
