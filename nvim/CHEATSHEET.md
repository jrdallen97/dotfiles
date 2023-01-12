# Vim cheatsheet

## Random (mostly movement)

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

## Window commands

Note: most of these work even if you continue holding `Ctrl` for the 2nd key, e.g. `<C-w><C-o>`.

- `<C-w><direction>`: Move to the window in `<direction>` (`<Up>`, `k`, etc)
- `<C-w>o`: Make the current window the only one on the screen (all others are `:q[uit]`)
- `<C-w>w`: Move to the previous window (move left/up), loop to last window if already at first
- `<C-w>t`: Move to the top-left/first window
- `<C-w>b`: Move to the bottom-right/last window
- `<C-w>p`: Move to the most recently accessed window

## Jumps

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

## Quickfix list

A special buffer for showing a list of locations/files e.g as the results of a search.

- `:cope[n]`:  Open the quickfix list window.
- `:ccl[ose]`: Close the quickfix list window.
- `:cn[ext]`:  Go to the next item on the list.
- `:cp[rev]`:  Go to the previous item on the list.
- `:cfir[st]`: Go to the first item on the list.
- `:cla[st]`:  Go to the last item on the list.
- `:cc <n>`:   Go to the nth item.

Handy shortcuts:

- `[q`: `:cprev` (from `tpope/vim-unimpaired`)
- `]q`: `:cnext` (from `tpope/vim-unimpaired`)
- `<leader>co`: `:copen`
- `<leader>cc`: `:cclose`
- `<leader>cn`: `:cnext`
- `<leader>cp`: `:cprev`
- `<leader>cf`: `:cfirst`
- `<leader>cl`: `:clast`

## LSP

Provided by `VonHeikemen/lsp-zero.nvim`.

- `K`:    Show hover information about symbol under cursor
- `C-k`:  Show signature information
- `gl`:   Show diagnostics in floating window
- `[d`:   Previous diagnostic
- `]d`:   Next diagnostic
- `gd`:   Goto definition
- `gD`:   Goto declaration (some LSPs don't implement this)
- `go`:   Goto type definition
- `gi`:   List implementations (quickfix)
- `gr`:   List references (quickfix)
- `<F2>`: Rename symbol
- `<F4>`: Select code action

## Autocompletion

Provided by `VonHeikemen/lsp-zero.nvim`.

- `<C-e>`:   Toggle completion popup
- `<Tab>`:   Show completion (if in word)
- `<S-Tab>`: Literal tab character (if in word)
- `<Enter>`: Confirm selection
- `<C-y>`:   Confirm selection
- `<Down>`:  Next item in list
- `<Tab>`:   Next item in list
- `<C-n>`:   Next item in list
- `<Up>`:    Previous item in list
- `<S-Tab>`: Previous item in list
- `<C-p>`:   Previous item in list
- `<C-d>`:   Next placeholder in snippet
- `<C-b>`:   Previous placeholder in snippet

## Telescope

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

## netrw

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
