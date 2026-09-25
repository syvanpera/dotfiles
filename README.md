# Dotfiles

My personal dotfiles, linked into `$HOME` with [GNU Stow](https://www.gnu.org/software/stow/).
The repo mirrors the home directory, so the whole repo is one stow package:

    cd ~/work/personal/dotfiles
    stow -t ~ .        # link everything
    stow -t ~ -R .     # relink after adding or removing configs
    stow -t ~ -D .     # remove all links

Create `~/.config` before the first run on a new machine. If it is missing,
stow links `~/.config` itself into the repo, and every app then writes its
files here. With `~/.config` present, stow links each config directory as a
whole, so apps can still add files inside their own directory.

Stow skips `README.md`, `.gitignore` and `.git` by default.

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
