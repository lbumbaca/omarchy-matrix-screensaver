# AGENTS.md — instructions for AI models (and humans) working on this repo

Read this file completely before changing anything.

## What this project is

An upgrade-safe override of the Omarchy (Hyprland) screensaver that runs endless Matrix
digital rain (`ttfx`, optional `cmatrix`) with the user's Omarchy ASCII logo, plus a fix
that waits for the terminal to resize out of 80x24 before drawing. Installed via a
one-line `curl | bash` from the `master` branch, so **whatever is on `master` runs on
users' machines** — keep it working.

Read in this order:
1. **`OPEN_ITEMS.md` – where to pick up.** Mirrors the GitHub issues; update both when you finish work.
2. `README.md` – features, install/uninstall
3. `ROADMAP.md` – plan. **Update it when you finish work.**
4. `docs/decisions/` – why things are the way they are. Don't reverse a decision without writing a new ADR.

## Files

| File | Installs to | Purpose |
|---|---|---|
| `bin/omarchy-screensaver` | `~/.local/bin/omarchy-screensaver` | The screensaver loop (shadows Omarchy's copy via PATH) |
| `branding/screensaver.txt` | `~/.config/omarchy/branding/screensaver.txt` (only if missing) | Logo shown in the rain |
| `install.sh` / `uninstall.sh` | — | Work both from a clone and via `curl \| bash` |

## Golden rules

1. **Never edit files under `/usr/share/omarchy`** — overrides live in `~/.local/bin` / `~/.config` only (ADR 0001).
2. **Never overwrite user config without a backup**, and never overwrite an existing `screensaver.txt`.
3. **install.sh must keep working via `curl | bash`** (no reliance on the script's directory existing).
4. Test on a real Omarchy session before pushing to `master`: `./install.sh && omarchy-launch-screensaver force`.
5. **Document every open item you create or discover — no exceptions.** Anything
   unfinished, deferred, unverified, blocked, or needing a human decision must be
   recorded in BOTH places before you end your session:
   - a **GitHub issue** (with labels, and "done when…" criteria), and
   - a row in **`OPEN_ITEMS.md`** linking to that issue.
   A `TODO` comment in code is not enough on its own — it must also have an issue.
   The next AI or person must be able to pick up from `OPEN_ITEMS.md` alone,
   without reading your conversation.

## Before you end a session (required checklist)

- [ ] `bash -n` (and `shellcheck` if installed) passes on all three scripts; manual test done
- [ ] Every item you **finished**: issue closed (with commit reference) and removed from `OPEN_ITEMS.md`
- [ ] Every item you **started but didn't finish**: issue comment saying exactly where you stopped and what's next
- [ ] Every **new** open item (gap, bug, question, unverified fact, follow-up): new issue + row in `OPEN_ITEMS.md`
- [ ] Anything that needs the owner: labeled `needs-human` and listed under "Waiting on the owner"
- [ ] `OPEN_ITEMS.md` "Last updated" date refreshed; `ROADMAP.md` checkboxes updated
- [ ] Committed and pushed, so GitHub and the repo agree

If you can't create GitHub issues (no access), still add the item to `OPEN_ITEMS.md`
marked `(issue not yet created)` so the next session can create it.

## Dev loop

```bash
for f in install.sh uninstall.sh bin/omarchy-screensaver; do bash -n "$f"; done
shellcheck install.sh uninstall.sh bin/omarchy-screensaver   # if installed
./install.sh && omarchy-launch-screensaver force               # manual test
```

## Style

Bash with `set -euo pipefail` in installers; 2-space indent; status lines as `[+]` / `[=]` / `[-]`.
