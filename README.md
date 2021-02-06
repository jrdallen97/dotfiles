# dotfiles

My config files for Linux. Installation should be as easy as cloning the repo and running one of the included install scripts, e.g. `./install_zsh`.

## Notes

### Nvim

**coc.nvim**
- Check status & recent logs with `:CocInfo`
- Requires languages to be installed manually with `:CocInstall`. I use:
  - `coc-go`
- Requires node & npm to be installed, e.g.:
  - `sudo apt install nodejs npm`
  - `sudo pacman -S nodejs npm`

## Install packages

### Ubuntu

```bash
sudo apt install zsh neovim curl git mpv streamlink youtube-dl htop ripgrep
```

### Differences on Windows

Install WSL using an Ubuntu base image, then install [WSLtty](https://github.com/mintty/wsltty) for a nicer terminal.

Install neovim in both linux **and** in Windows (using chocolatey). This will make win32yank (included in the Windows install) available to neovim in WSL, enabling clipboard support.

### Other edge cases

Get a newer neovim version on older Ubuntu versions:

```bash
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim
```
