# Vim cheatsheet

<!-- mtoc-start -->

- [Misc](CHEATSHEET#Misc)
    - [Launch options](CHEATSHEET#Launch options)
    - [Help](CHEATSHEET#Help)
- [Built-in](CHEATSHEET#Built-in)
    - [Random (mostly movement)](CHEATSHEET#Random (mostly movement))
    - [Window commands](CHEATSHEET#Window commands)
    - [Jumps](CHEATSHEET#Jumps)
    - [Folds](CHEATSHEET#Folds)
    - [Quickfix list](CHEATSHEET#Quickfix list)
    - [netrw](CHEATSHEET#netrw)
- [Plugins](CHEATSHEET#Plugins)
    - [LSP](CHEATSHEET#LSP)
    - [Diagnostics](CHEATSHEET#Diagnostics)
    - [Autocompletion](CHEATSHEET#Autocompletion)
    - [Telescope](CHEATSHEET#Telescope)
    - [Comments](CHEATSHEET#Comments)
    - [Git](CHEATSHEET#Git)
        - [Fugitive](CHEATSHEET#Fugitive)
    - [Mini](CHEATSHEET#Mini)

<!-- mtoc-end -->

## Misc

### Launch options

- `-d`: Open in diff-mode
- `-p`: Open a tab for each file passed
- `-O`: Open a vertical split for each file passed
- `-o`: Open a horizontal split for each file passed

### Help

- `<C-]>`: Jump to definition (e.g. open help)

## Built-in

### Random (mostly movement)

- `*`:     Search for the word under the cursor
- `#`:     Search for the word under the cursor (reverse)
- `;`:     Repeat last f/e/etc movement
- `,`:     Repeat last f/e/etc movement (reverse)
- `ge`:    Move to the end of the previous word
- `<C-u>`: Scroll up half a page (note: not a jump)
- `<C-d>`: Scroll down half a page
- `<C-b>`: Page up (also `<PageUp>` & `<S-Up`>)
- `<C-f>`: Page down (also `<PageDown>` & `<S-Down`>)
- `zt`:    Re-centre screen with the cursor at the top
- `zz`:    Re-centre screen with the cursor in the middle
- `zb`:    Re-centre screen with the cursor at the bottom
- `p`:     Paste after the cursor
- `P`:     Paste before the cursor

Visual mode:

- `p`: Paste over selection and yank previous contents
- `P`: Paste over selection without yanking previous contents
    - This is especially useful when using something like `vi"` to select an entire string, for example.

### Window commands

Note: most of these work even if you continue holding `Ctrl` for the 2nd key, e.g. `<C-w><C-o>`.

- `<C-w>s`: `:sp[lit]`
- `<C-w>v`: `:vsp[lit]`
- `<C-w><direction>`: Move to the window in `<direction>` (`<Up>`, `k`, etc)
- `<C-w><DIRECTION>`: Move the current window all the way to `<DIRECTION>` (only `HJKL`)
- `<C-w>o`: `:q[uit]` all but the current window (also: `:only`)
- `<C-w>w`: Move to the previous window (move left/up), loop to last window if already at first
- `<C-w>t`: Move to the top-left/first window
- `<C-w>b`: Move to the bottom-right/last window
- `<C-w>p`: Move to the most recently accessed window
- `<C-w>=`: Equalise splits/make all windows the same size

Also, for tabs:

- `gt`: Next tab
- `gT`: Prev tab
- `[n]gt`: Goto nth tab
- `:tabe[dit]`:  Open a file in a new tab
- `:tabc[lose]`: Close current tab

### Jumps

`:h jump-motions`

Jumps tend to be cursor movements that move your cursor multiple lines. When you jump, your previous position is remembered.

Note: scrolling (e.g. `<C-d>`) is not a jump.

- `:ju[mps]`: List jumps in current window
- `<C-o>`: Previous cursor position in jump list (i.e. not a motion)
- `<C-i>`: Next cursor position in jump list
- `%`:     Jump to matching bracket
- `H`:     Jump the cursor to the top of the screen (**h**igh)
- `M`:     Jump the cursor to the middle of the screen (**m**iddle)
- `L`:     Jump the cursor to the bottom of the screen (**l**ow)

### Folds

`:h folds`

- `za`: Toggle fold under the cursor
- `zA`: Toggle all folds under the cursor (i.e. close everything up to foldlevel 1)
- `zv`: View cursor line: Open just enough folds to make the line in which the cursor is located not folded.
- `zM`: Close all folds: set `foldlevel` to 0
- `zR`: Open all folds: set `foldlevel` to highest fold level in file
- `zm`: Fold more: Subtract 1 (or count) from `foldlevel`
- `zr`: Reduce folding: Add 1 (or count) to `foldlevel`
- `zi`: Toggle `foldenable`, i.e. enable/disable all folding in buffer
- Less useful?
    - `zo`: Close one fold under the cursor. Accepts count (e.g. `3zo`)
    - `zO`: Close all folds under the cursor recursively. Folds that don't contain the cursor line are unchanged.
    - `zc`: Close one fold under the cursor. Accepts count (e.g. `3zc`)
    - `zC`: Close all folds under the cursor recursively. Folds that don't contain the cursor line are unchanged.

- `:set foldlevel/fdl`: Get/set the foldlevel of the current buffer
    - e.g. `:set fdl=5`: Fold entire file at depth 5. Now you can use `zm`/`zr` to increase/decrease folding.

### Quickfix list

A special buffer for showing a list of locations/files e.g as the results of a search.

- `:cope[n]`:  Open the quickfix list window.
- `:ccl[ose]`: Close the quickfix list window.
- `:cn[ext]`:  Go to the next item on the list.
- `:cp[rev]`:  Go to the previous item on the list.
- `:cfir[st]`: Go to the first item on the list.
- `:cla[st]`:  Go to the last item on the list.
- `:cc <n>`:   Go to the nth item.

The location list also behaves similarly but only stores locations for the current buffer.
The commands to use it are the same, replacing the first `c` with `l` (e.g. `:lopen`, `]l`).

`tpope/vim-unimpaired` provides `q` for `:cn`/`:cp` and `Q` for `:cfir`/`:cla`, or `l`/`L` for the location list.

Handy shortcuts:

TODO: not yet ported over

- `<leader>co`: `:copen`
- `<leader>cc`: `:cclose`
- `<leader>cn`: `:cnext`
- `<leader>cp`: `:cprev`
- `<leader>cf`: `:cfirst`
- `<leader>cl`: `:clast`

### netrw

- `I`: Toggle help
- `o`: Open in horizontal split
- `v`: Open in vertical split
- `t`: Open in new tab
- `s`: Cycle through sorting methods
- `r`: Reverse sort
- `x`: Open with `xdg-open` (or equivalent)
- `%`: New file
- `d`: Make directory
- `D`: Delete selected file(s)/directory(ies)
- `cd`: Make browsing directory the current directory
- `gd`: Toggle hiding dotfiles

Enhancements provided by `tpope/vim-vinegar`:

- `-`: Go to parent directory (from file or directory)
- `~`: Go to `~`
- `y.`: Yank absolute path to file under cursor

Getting into netrw:

- `Ex[plore]`:  Open netrw in current file's directory
- `Sex[plore]`: `:Ex` in a new horizontal split
- `Vex[plore]`: `:Ex` in a new vertical split
- `Tex[plore]`: `:Ex` in a new tab

## Plugins

### LSP

Provided by `neovim/nvim-lspconfig` (amongst others.)

- `K`:     Show hover information about symbol under cursor
- `<C-k>`: Show hover information about symbol under cursor (also works in insert)
- `<C-s>`: Show signature information (also works in insert)
- `gd`: Goto definition
- `gr`: Goto references (telescope)
- `gI`: Goto implementation (telescope)
- `gD`: Goto type definition
- `<leader>D`:  Goto type definition
- `<leader>ca`: Code actions
- `<F4>`:       Code actions
- `<leader>rn`: Rename symbol under cursor
- `<F2>`:       Rename symbol under cursor
- `<leader>ds`: Document symbols, fuzzy find all the symbols in your current document (telescope)
- `<leader>ws`: Workspace symbols, fuzzy find all the symbols in your current workspace (telescope)
- `<leader>q`:  Send all diagnostics to the quickfix list (project-wide)
- `<leader>l`:  Send all diagnostics to the location list (current file only)

Currently disabled:

- `gD`: Goto declaration (some LSPs don't implement this)

### Diagnostics

Kinda built in, but also fed by LSP.

- `[d`: Previous diagnostic
- `]d`: Next diagnostic
- `<leader>E`: Open floating diagnostics window
- `<leader>q`: Send diagnostics to quickfix

### Autocompletion

Provided by `hrsh7th/nvim-cmp`.

- `<C-Space>`: Manually trigger completion (doesn't work?)
- `<C-y>`:  Accept completion
- `<Tab>`:  Accept completion
- `<Down>`: Next item in list
- `<C-n>`:  Next item in list
- `<Up>`:   Previous item in list
- `<C-p>`:  Previous item in list
- `<C-u>`:  Scroll documentation window up
- `<C-d>`:  Scroll documentation window down
- `<C-l>`:  (after accepting snippet) Next location in snippet
- `<C-h>`:  (after accepting snippet) Previous location in snippet

### Telescope

Provided by `nvim-telescope/telescope.nvim`.

Supports many standard mappings (e.g. `H/M/L`, `gg/G`, normal/insert mode).

- `?`:     Show telescope bindings (normal mode)
- `<C-/>`: Show telescope bindings (insert mode)
- `<C-c>`: Close telescope
- `<C-x>`: Open file in a new horizontal split
- `<C-v>`: Open file in a new vertical split
- `<C-t>`: Open file in a new tab
- `<C-u>`: Scroll up in preview window
- `<C-d>`: Scroll down in preview window
- `<C-d>`: Delete buffer (in *buffer switcher only**)

### Comments

Provided by `terrortylor/nvim-comment`.

Provides some handy shortcuts for commenting/uncommenting blocks of code.

- `gcc`:            Toggle comment on line
- `gc` (visual):    Toggle comment on selected line(s)
- `:CommentToggle`: Toggle comment on line(s), e.g.:
    - `:%g/Foobar/CommentToggle`: Comment lines matching regex

### Git

Provided by `lewis6991/gitsigns.nvim`.

- `]c`: Next change
- `[c`: Prev change
- Staging:
    - `<leader>hs`: Stage hunk
    - `<leader>hS`: Stage all hunks in file
    - `<leader>hu`: Undo stage hunk
    - `<leader>hr`: Reset hunk
    - `<leader>hR`: Reset all hunks in file
    - `<leader>hp`: Preview current hunk
    - `<leader>hi`: Preview current hunk (inline)
    - `<leader>hq`: Send hunks to quickfix (buffer)
    - `<leader>hQ`: Send hunks to quickfix (all files)
- Blame
    - `<leader>hb`: Blame current line
- Diff
    - `<leader>hd`: Diff current file
    - `<leader>hD`: Diff current file vs previous commit (`~`)
- Toggles
    - `<leader>tb`: Toggle inline blame
    - `<leader>td`: Toggle showing deleted lines

Text object:
- `ih`: inner hunk, e.g.
    - `vih`: Select all changes in a hunk
    - `dih`: Delete all changes in a hunk

#### Fugitive

Provided by `tpope/vim-fugitive`.

- `:G`: Open fugitive in a split
- `:tab G`:     Open fugitive in a new tab
- `<leader>gg`: Open fugitive in a new tab
- `<leader>gs`: Git status (telescope)
- `<leader>gb`: Git blame
- `<leader>gc`: Git commit
- `<leader>gp`: Git push
- `<leader>gl`: Git pull

From within fugitive:

- `s`: Stage file/hunk
- `u`: Unstage file/hunk
- `U`: Unstage all
- `-`: Toggle staged for file/hunk
- `=`: Toggle inline diff for file/hunk
- `]]`: Next section
- `[[`: Previous section

### Mini

- `mini.splitjoin`:
    - `gS`: Split if arguments are on single line, join otherwise (also works on visual selection to disambiguate)
- `mini.move`:
    - `<M-direction>`: Move current line/selection in direction (works in normal, visual & visual line modes)
