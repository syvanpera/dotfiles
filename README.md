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
