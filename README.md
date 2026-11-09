# Omarchy Matrix Screensaver

Endless **Matrix digital rain** screensaver override for [Omarchy](https://omarchy.org/) (Hyprland), powered by `ttfx` (with optional `cmatrix` mode) and a fullscreen terminal resize fix.

## Features

- **Endless Matrix Rain**: Runs continuous digital rain (`--rain-time 86400` at 120 FPS) with your Omarchy ASCII logo (`~/.config/omarchy/branding/screensaver.txt`).
- **Fullscreen Resize Fix**: Waits for the Wayland compositor to resize the terminal PTY out of `80x24` before initializing `ttfx`, ensuring the canvas spans the entire monitor.
- **Upgrade-Safe Override**: Installs to `~/.local/bin/omarchy-screensaver` and configures `~/.config/hypr/hyprland.lua` so Omarchy package updates never overwrite your screensaver.
- **Optional `cmatrix` Mode**: Set `OMARCHY_SCREENSAVER_CMATRIX=1` to use `cmatrix -s -b` instead of `ttfx`.

---

## One-Line Install (on any Omarchy machine)

```bash
curl -fsSL https://raw.githubusercontent.com/lbumbaca/omarchy-matrix-screensaver/master/install.sh | bash
```

## Or Clone & Install

```bash
git clone https://github.com/lbumbaca/omarchy-matrix-screensaver.git
cd omarchy-matrix-screensaver
./install.sh
```

---

## Test / Launch Screensaver

```bash
omarchy-launch-screensaver force
```

## Uninstall (Restore Default Omarchy Screensaver)

```bash
curl -fsSL https://raw.githubusercontent.com/lbumbaca/omarchy-matrix-screensaver/master/uninstall.sh | bash
```
or from a local clone:
```bash
./uninstall.sh
```
