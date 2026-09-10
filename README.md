# Dotfiles

These are my personal dotfiles managed with [mise-en-place](https://mise.jdx.dev).

## herdr plugins

herdr installs plugins into `.config/herdr/plugins`, which lands inside this
repo because `~/.config/herdr` is a symlink into it. They are upstream git
checkouts with their own `.git` — and, for sesh, a compiled Go binary — so
they are ignored rather than tracked. Reinstall them on a new machine with:

    herdr plugin install lmilojevicc/herdr-splits.nvim --ref v0.5.3 --yes
    herdr plugin install fullerzz/herdr-plugin-sesh --ref v0.11.0 --yes

Installed as of 2026-09-10: herdr-splits 0.5.3 (`94f30cf`, exactly the v0.5.3
tag) and sesh 0.11.0 (`a734482`, a commit on main past the v0.11.0 tag — pass
that commit to `--ref` instead if the difference ever matters).

## omarchy plugins

`crmne.hyprmoncfg` and `chyld.easy-capture` are their own git checkouts that
omarchy updates in place, so they are ignored too. The plugins under
`.config/omarchy/plugins` written here — `tuomo.*` — are tracked as normal.

    omarchy plugin add https://github.com/crmne/omarchy-hyprmoncfg.git --enable
    omarchy plugin add https://github.com/chyld/omarchy-easy-capture.git --enable

`omarchy plugin add` takes no ref, so those install the current main. Last used
with hyprmoncfg v2.3.3 (`c419135`, an exact tag) and easy-capture 0.4.0
(`59fc509` — that repo publishes no tags, so the version is the manifest's).
Both are bar widgets enabled in the tracked `.config/omarchy/shell.json`, and
hyprmoncfg also writes the tracked `.config/hypr/hyprmoncfg-monitors.lua`.
Update them with `omarchy plugin update`.
