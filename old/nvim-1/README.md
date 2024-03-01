# nvim

My original nvim config, written using vimscript & vim-plug.

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
