# Vim cheatsheet

## LSP

Provided by `VonHeikemen/lsp-zero.nvim`.

- `K`:      Show hover information about symbol under cursor
- `C-k`: Show signature information
- `gl`:     Show diagnostics in floating window
- `[d`:     Previous diagnostic
- `]d`:     Next diagnostic
- `gd`:     Goto definition
- `gD`:     Goto declaration (some LSPs don't implement this)
- `go`:     Goto type definition
- `gi`:     List implementations
- `gr`:     List references
- `<F2>`:   Rename symbol
- `<F4>`:   Select code action

## Autocompletion

Provided by `VonHeikemen/lsp-zero.nvim`.

- `<C-e>`: Toggle completion popup
- `<Tab>`:    Show completion (if in word)
- `<S-Tab>`:  Literal tab character (if in word)
- `<Enter>`:  Confirm selection
- `<C-y>`: Confirm selection
- `<Down>`:   Next item in list
- `<Tab>`:    Next item in list
- `<C-n>`: Next item in list
- `<Up>`:     Previous item in list
- `<S-Tab>`:  Previous item in list
- `<C-p>`: Previous item in list
- `<C-d>`: Next placeholder in snippet
- `<C-b>`: Previous placeholder in snippet

## Telescope

Provided by `nvim-telescope/telescope.nvim`.

Supports many standard mappings (e.g. `H/M/L`, `gg/G`, normal/insert mode).

- `<C-/>`: Show telescope bindings (insert mode)
- `?`:     Show telescope bindings (normal mode)
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

## Useful movement

- `<C-o>`: Undo cursor movement
- `*`:  Search for the word under the cursor
- `#`:  Search for the word under the cursor (reverse)
- `;`:  Repeat last f/e/etc movement
- `,`:  Repeat last f/e/etc movement (reverse)
- `%`:  Jump to matching bracket
- `ge`: Move to the end of the previous word
- `<C-u>`: Scroll up half a page
- `<C-d>`: Scroll down half a page
- `H`:  Jump the cursor to the top of the screen (**h**igh)
- `M`:  Jump the cursor to the middle of the screen (**m**iddle)
- `L`:  Jump the cursor to the bottom of the screen (**l**ow)
- `zt`: Re-centre screen with the cursor at the top
- `zz`: Re-centre screen with the cursor in the middle
- `zb`: Re-centre screen with the cursor at the bottom

## Buffers

- `:bd`: close current buffer
