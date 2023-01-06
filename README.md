# dotfiles

My config files for Linux. Installation should be as easy as cloning the repo and running one of the included install scripts, e.g. `./install_zsh`.

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
sudo apt install zsh neovim curl git mpv streamlink youtube-dl htop ripgrep
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

## Nvim (old)

**nvim** (old)
- When first opening, run `:PlugInstall` to install plugins
- Plugins are installed using `vim-plug`. See [junegunn/vim-plug](https://github.com/junegunn/vim-plug) for more info, but tl;dr:
  - Plugins are managed in `init.vim`
  - Run `:PlugInstall` to install any plugins in `init.vim`
  - Run `:PlugClean` to remove old plugins
  - Run `:PlugUpdate` to update installed plugins
- Check health with `:checkhealth`
  - You may need to configure a clipboard provider to get system clipboard working:
    - On linux, install `xclip`
    - On Windows, see the Windows section below

**coc.nvim** (old)
- Check status & recent logs with `:CocInfo`
- Requires languages to be installed manually with `:CocInstall`. I use:
  - `coc-go`
- Requires node & npm to be installed, e.g.:
  - `sudo apt install nodejs npm`
  - `sudo pacman -S nodejs npm`

