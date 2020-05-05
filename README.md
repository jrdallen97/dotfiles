# dotfiles

My config files for Linux. Installation should be as easy as cloning the repo and running one of the included install scripts, e.g. `./install_zsh`.

## Install packages

### Ubuntu

```bash
sudo apt install zsh neovim curl git mpv streamlink youtube-dl htop
```

### Differences on Windows

Install WSL using an Ubuntu base image, then install [WSLtty](https://github.com/mintty/wsltty) for a nicer terminal.

For neovim, install it on both WSL and Windows itself (using chocolatey) to get it to use the included win32yank binary for clipboard support.

### Other edge cases

Get a newer neovim version on older Ubuntu versions:

```bash
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim
```
