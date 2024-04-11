# dotfiles

My config files for Linux. Installation should be as easy as cloning the repo and running one of the included install scripts, e.g. `./install_zsh`. Going forward I'll be mainly using GNU stow for managing dotfiles, rather than writing custom symlinking scripts for everything.

## Installation

### nvim

Uninstall existing nvim config & install with GNU stow:

```shell
rm -rf ~/.config/nvim ~/.local/share/nvim
stow -t ~ nvim
```

## Rendering markdown to HTML

Some of my dotfiles have their own markdown files (e.g. nvim). You can render these nicely with, for example:

```shell
pandoc nvim/CHEATSHEET.md -s --to=html --toc --css=../styles.css -o nvim/CHEATSHEET.html
```

...and view it at `file:///path/to/dotfiles/nvim/CHEATSHEET.html`.

You can use `--embed-resources` to embed the styles (change the path to the CSS to be relative to you instead of to the file).

## Install packages

### Ubuntu

```bash
sudo apt install zsh neovim curl git mpv streamlink youtube-dl htop ripgrep stow
```

### Differences on Windows

Ideally use WSL 2 - WSL 1 caused me a bunch of issues (e.g. with `nodejs`). The new windows terminal app (from MS store) is quite nice, as is [WSLtty](https://github.com/mintty/wsltty).

Install neovim in both linux **and** in Windows (e.g. using chocolatey). This will make win32yank (included in the Windows install) available to neovim in WSL, enabling clipboard support.

### Other edge cases

Get a newer neovim version on older Ubuntu versions:

```bash
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim
```
