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
