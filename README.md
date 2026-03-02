# Dotfiles

These are my personal dotfiles managed with **GNU Stow**.

## Structure

The repository is organized into "packages" (subdirectories):

- **`common/`**: Contains files that should be symlinked directly to your home directory (`$HOME`).
  - Example: `.bashrc`, `.tmux.conf`, `.zshrc`.
- **`config/`**: Contains application-specific configuration directories that should be symlinked to `~/.config/`.
  - Example: `nvim/`, `fish/`.
- **`install.sh`**: A wrapper script that uses `stow` to link all packages to their correct locations.

## Installation

### Prerequisites

You need to have `stow` installed on your system.

- **Debian/Ubuntu**: `sudo apt install stow`
- **Fedora**: `sudo dnf install stow`
- **Arch Linux**: `sudo pacman -S stow`

### Running the Installer

To install or update your symlinks, simply run the `install.sh` script:

```bash
chmod +x install.sh
./install.sh
```

## Adding New Configurations

### For Home Directory (`$HOME`)
Place the file (including the leading dot if necessary) into the `common/` directory.

### For Config Directory (`~/.config/`)
1. Create a new directory inside `config/` (e.g., `config/kitty/`).
2. Place your configuration files inside that directory (e.g., `config/kitty/kitty.conf`).
3. Running `./install.sh` will automatically link it to `~/.config/kitty/kitty.conf`.

## Why GNU Stow?

GNU Stow makes it easy to manage symlinks by using the directory structure of the "package"
to determine where the symlink should be created. This allows you to keep your dotfiles
organized in one repository while they appear in their expected locations in your home directory.
