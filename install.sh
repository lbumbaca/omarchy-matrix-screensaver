#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${OMARCHY_MATRIX_REPO_URL:-https://raw.githubusercontent.com/lbumbaca/omarchy-matrix-screensaver/master}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-.}")" 2>/dev/null && pwd || pwd)"

BIN_DIR="$HOME/.local/bin"
BRANDING_DIR="$HOME/.config/omarchy/branding"
HYPR_CONFIG="$HOME/.config/hypr/hyprland.lua"

echo "==> Installing Omarchy Matrix Screensaver..."

mkdir -p "$BIN_DIR" "$BRANDING_DIR"

# 1. Install omarchy-screensaver binary
if [[ -f "$SCRIPT_DIR/bin/omarchy-screensaver" ]]; then
  cp "$SCRIPT_DIR/bin/omarchy-screensaver" "$BIN_DIR/omarchy-screensaver"
else
  curl -fsSL "$REPO_URL/bin/omarchy-screensaver" -o "$BIN_DIR/omarchy-screensaver"
fi
chmod +x "$BIN_DIR/omarchy-screensaver"
echo "  [+] Installed $BIN_DIR/omarchy-screensaver"

# 2. Install branding screensaver.txt if missing
if [[ ! -f "$BRANDING_DIR/screensaver.txt" ]]; then
  if [[ -f "$SCRIPT_DIR/branding/screensaver.txt" ]]; then
    cp "$SCRIPT_DIR/branding/screensaver.txt" "$BRANDING_DIR/screensaver.txt"
  else
    curl -fsSL "$REPO_URL/branding/screensaver.txt" -o "$BRANDING_DIR/screensaver.txt"
  fi
  echo "  [+] Installed $BRANDING_DIR/screensaver.txt"
else
  echo "  [=] Kept existing $BRANDING_DIR/screensaver.txt"
fi

# 3. Ensure ~/.local/bin takes precedence in ~/.config/hypr/hyprland.lua
if [[ -f "$HYPR_CONFIG" ]]; then
  if ! grep -q "omarchy-screensaver" "$HYPR_CONFIG" && ! grep -q 'local_bin = os.getenv("HOME") .. "/.local/bin"' "$HYPR_CONFIG"; then
    cp "$HYPR_CONFIG" "${HYPR_CONFIG}.bak.$(date +%s)"
    cat << 'EOF' >> "$HYPR_CONFIG"

-- Prepend ~/.local/bin to PATH so user overrides (like omarchy-screensaver) take precedence.
local local_bin = os.getenv("HOME") .. "/.local/bin"
local omarchy_bin = (os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/bin"
local path_entries = { local_bin, omarchy_bin }
for entry in (os.getenv("PATH") or "/usr/local/bin:/usr/bin"):gmatch("[^:]+") do
  if entry ~= local_bin and entry ~= omarchy_bin then
    table.insert(path_entries, entry)
  end
end
hl.env("PATH", table.concat(path_entries, ":"))
EOF
    echo "  [+] Updated $HYPR_CONFIG to prioritize ~/.local/bin in PATH"
  else
    echo "  [=] $HYPR_CONFIG already prioritizes ~/.local/bin"
  fi
fi

# 4. Reload Hyprland configuration if running
if command -v hyprctl >/dev/null 2>&1 && hyprctl instances >/dev/null 2>&1; then
  hyprctl reload >/dev/null 2>&1 || true
  echo "  [+] Reloaded Hyprland configuration"
fi

echo "==> Done! Launch anytime with: omarchy-launch-screensaver force"
