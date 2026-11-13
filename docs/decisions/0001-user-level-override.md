# 0001 — Override via ~/.local/bin and PATH, not by editing Omarchy

**Status:** Accepted (initial commit)

## Context
Omarchy ships `omarchy-screensaver` in `/usr/share/omarchy/bin`; package updates overwrite
anything changed there.

## Decision
Install our script to `~/.local/bin/omarchy-screensaver` and make Hyprland's PATH put
`~/.local/bin` before the Omarchy bin directory (block appended to `~/.config/hypr/hyprland.lua`,
with a timestamped backup). Uninstall = remove our script; Omarchy's default takes over.

## Consequences
+ Survives Omarchy updates; trivially reversible.
− Modifies the user's hyprland.lua (cleanup on uninstall tracked in #1).
− Relies on Omarchy calling the screensaver through PATH (verified per #4).
