# Open items — start here to pick up work

**Last updated:** 2026-11-12 · **Current phase:** Working release; hardening
**GitHub issues are the live tracker** (https://github.com/lbumbaca/omarchy-matrix-screensaver/issues).
This file mirrors them so the state is visible offline and to any AI reading the repo.
When you finish or change an item: update the issue AND this file in the same commit.

## How to pick up (for an AI model)

1. Read `AGENTS.md` (rules), then this file, then `ROADMAP.md`.
2. Check the scripts: `bash -n` on each (and `shellcheck` if installed).
3. Take the **lowest-numbered unblocked item in "Next for development"**.
4. Do not work on `needs-human` items except to record answers the owner gives you.
5. **Before you stop, record every open item you leave behind** — new issue + a row here.
   Follow the "Before you end a session" checklist in `AGENTS.md`. This is required, not optional.

## ⛔ Waiting on the owner (`needs-human`)

| # | Item | Blocks |
|---|---|---|
| [#4](https://github.com/lbumbaca/omarchy-matrix-screensaver/issues/4) | Confirm it still works after the next Omarchy update | Confidence in the override |

## ▶ Next for development (in order)

| # | Item |
|---|---|
| [#1](https://github.com/lbumbaca/omarchy-matrix-screensaver/issues/1) | Uninstall leaves the PATH block in hyprland.lua and `.bak` files behind |
| [#2](https://github.com/lbumbaca/omarchy-matrix-screensaver/issues/2) | Installer doesn't check dependencies (ttfx, jq, hyprctl) |
| [#3](https://github.com/lbumbaca/omarchy-matrix-screensaver/issues/3) | Add shellcheck + basic CI |

## Known limitations

- Depends on Omarchy internals (window class `org.omarchy.screensaver`, PATH lookup of `omarchy-screensaver`).
- The resize wait gives up after 2 seconds and starts anyway.
