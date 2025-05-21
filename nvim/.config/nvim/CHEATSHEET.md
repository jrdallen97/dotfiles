# Vim cheatsheet

<!-- mtoc-start -->

- [Misc](CHEATSHEET#Misc)
    - [Launch options](CHEATSHEET#Launch options)
    - [Help](CHEATSHEET#Help)
- [Built-in](CHEATSHEET#Built-in)
    - [Editing](CHEATSHEET#Editing)
    - [Misc](CHEATSHEET#Misc)
    - [Window commands](CHEATSHEET#Window commands)
    - [Jumps](CHEATSHEET#Jumps)
    - [Folds](CHEATSHEET#Folds)
    - [Quickfix list](CHEATSHEET#Quickfix list)
    - [netrw](CHEATSHEET#netrw)
- [Plugins](CHEATSHEET#Plugins)
    - [LSP](CHEATSHEET#LSP)
    - [Diagnostics](CHEATSHEET#Diagnostics)
    - [Autocompletion](CHEATSHEET#Autocompletion)
    - [Fzf](CHEATSHEET#Fzf)
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

### Editing

Not gonna list all the basics here...

- `[<Space>`: Insert newline above cursor
- `]<Space>`: Insert newline below cursor

### Misc

Movement:

- `*`:  Search for the word under the cursor
- `#`:  Search for the word under the cursor (reverse)
- `;`:  Repeat last f/e/etc movement
- `,`:  Repeat last f/e/etc movement (reverse)
- `ge`: Move to the end of the previous word

Scrolling:

- `<C-u>`: Scroll up half a page (note: not a jump)
- `<C-d>`: Scroll down half a page
- `<C-b>`: Page up (also `<PageUp>` & `<S-Up`>)
- `<C-f>`: Page down (also `<PageDown>` & `<S-Down`>)
- `zt`:    Re-centre screen with the cursor at the top
- `zz`:    Re-centre screen with the cursor in the middle
- `zb`:    Re-centre screen with the cursor at the bottom

Copy/paste:

- `p`: Paste after the cursor
- `P`: Paste before the cursor
- Visual mode:
    - `p`: Paste over selection and yank previous contents
    - `P`: Paste over selection without yanking previous contents
        - This is especially useful when using something like `vi"` to select an entire string, for example.

Spell:

- `z=`:  Spelling suggestions
- `zg`:  Mark word as good (add to good word list)
- `zw`:  Mark word as wrong (add to wrong word list)
- `zug`: Undo `zg`/`zw`, remove word from spellfile

### Window commands

Note: most of these work even if you continue holding `Ctrl` for the 2nd key, e.g. `<C-w><C-o>`.

- `<C-w>s`: `:sp[lit]`
- `<C-w>v`: `:vsp[lit]`
- `<C-w><direction>`: Move to the window in `<direction>` (`<Up>`, `k`, etc)
- `<C-w><DIRECTION>`: Move the current window all the way to `<DIRECTION>` (only `HJKL`)
- `<C-w>q`: Close the current window (also: `:quit`)
- `<C-w>o`: Close all but the current window (also: `:only`)
- `<C-w>u`: Undo closing a window (provided by `AndrewRadev/undoquit.vim`)
- `<C-w>f`: Alias for `:tab split` (open current window in new tab) (custom)
- `<C-w>w`: Move to the previous window (move left/up), loop to last window if already at first
- `<C-w>t`: Move to the top-left/first window
- `<C-w>b`: Move to the bottom-right/last window
- `<C-w>p`: Move to the most recently accessed window
- `<C-w>=`: Equalise splits/make all windows the same size
- `<C-w>_`: Maximise height of current window
- `<C-w>|`: Maximise width of current window

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

Keybinds:

- `gO`: File outline (if supported, e.g. markdown, help).
- `]q`: Jump to next in quickfix list.
- `[q`: Jump to prev in quickfix list.
- `]Q`: Jump to first in quickfix list.
- `[Q`: Jump to last in quickfix list.

The location list also behaves similarly but only stores locations for the current buffer.
The commands to use it are the same, replacing the first `c` with `l` (e.g. `:lopen`, `]l`).

`mini.bracketed` provides `q` for `:cn`/`:cp` and `Q` for `:cfir`/`:cla`, or `l`/`L` for the location list.

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

Built-in keybinds:

- `K`:     Hover information
- `<C-s>`: (Insert) Signature help
- `grr`: Goto references
- `gri`: Goto implementation
- `grn`: Rename symbol
- `gra`: Code actions
- `gO`:  Document symbols

Extended by `neovim/nvim-lspconfig` (amongst others.)

Extended keybinds:

- `K`:     Hover information
- `<C-k>`: (Insert) Hover information
- `<C-s>`: (Normal/Insert) Signature help
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
- `[D`: First diagnostic
- `]D`: Last diagnostic
- `<leader>q`: Send diagnostics to quickfix (error only)
- `<leader>Q`: Send diagnostics to quickfix (all diagnostics)
- `<leader>l`: Send diagnostics to quickfix (error only)
- `<leader>L`: Send diagnostics to quickfix (all diagnostics)

### Autocompletion

Provided by `hrsh7th/nvim-cmp`.

- `<C-Space>`: Manually trigger completion
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

### Fzf

Provided by `ibhagwan/fzf-lua`

Shortcuts:

- Misc
    - `<leader><leader>`: Switch buffers
    - `<leader>/`:  Search in current buffer
    - `<leader>sr`: Resume previous search
    - `<leader>ss`: Search built-in search commands
    - `<leader>gs`: Git status
    - `<leader>sv`: Search within vim config
- Vim stuff
    - `<leader>se`: Search error diagnostics
    - `<leader>sh`: Search vim help
    - `<leader>sk`: Search keymaps
- Basic search
    - `<leader>sf`: Search files
    - `<leader>sg`: Search by grep
    - `<leader>so`: Search oldfiles (recently opened files)
    - `<leader>sd`: Search directories
- Search for current word/visual selection:
    - `<leader>sw`: Search for word under cursor
    - `<leader>sW`: Search for WORD under cursor
    - `<leader>s`:  Search for current visual selection

Inside fzf:

- `<F1>`: Toggle help
- `<F2>`: Toggle fullscreen
- `<F3>`: Toggle line wrap (only in `builtin` previewer)
- `<F4>`: Toggle preview (only in `builtin` previewer)
- `<M-g>`: Jump to first result
- `<M-G>`: Jump to last result
- Opening files/selections:
    - `<Enter>`: Open OR send selected to quickfix
    - `<C-v>`: Open in vertical split(s)
    - `<C-s>`: Open in horizontal split(s)
    - `<C-t>`: Open in new tab
    - `<Tab>`: Toggle selected
    - `<M-a>`: Toggle select-all
    - `<M-q>`: Send selection to quickfix
    - `<M-Q>`: Send selection to loclist
- Scroll preview:
    - `<S-Up>`:     Scroll preview up (page)
    - `<M-S-Up>`  : Scroll preview up (line)
    - `<S-Down>`:   Scroll preview down (page)
    - `<M-S-Down>`: Scroll preview down (page)
    - `<S-Left>`:   Reset preview
- Toggle settings:
    - `<M-i>`: Toggle ignore
    - `<M-h>`: Toggle hidden
    - `<M-f>`: Toggle follow (?)

### Comments

Provided by `numToStr/Comment.nvim`.

Provides some handy shortcuts for commenting/uncommenting blocks of code. Some of this functionality is now built-in, but this plugin extends and improves it.

- `gcc`: Toggle comment on line
- `gc` (visual): Toggle comment on selected line(s)

### Git

Provided by `lewis6991/gitsigns.nvim`.

- `]h`: Next hunk
- `[h`: Prev hunk
- `]H`: Last hunk
- `[H`: First hunk
- Staging:
    - `<leader>hs`: Stage hunk (toggle) (also works in visual mode)
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

- `]]`: Next section
- `[[`: Previous section
- `-`: Toggle staged for file/hunk
- `=`: Toggle inline diff for file/hunk
- `s`: Stage file/hunk
- `u`: Unstage file/hunk
- `U`: Unstage all
- `X`: Discard file/hunk

### Mini

- `mini.surround`:
    - Add/delete/replace surroundings (brackets, quotes, etc.)
    - `sa`: Add surrounding
    - `sr`: Replace surrounding
    - `sd`: Delete surrounding
- `mini.splitjoin`:
    - `gS`: Split if arguments are on single line, join otherwise (also works on visual selection to disambiguate)
- `mini.move`:
    - `<M-direction>`: Move current line/selection in direction (works in normal, visual & visual line modes)
- `mini.operators`:
    - `g=`: Evaluate selected (e.g. `1+1` -> `2`)
    - `gs`: Sort selected
    - `gm`: Multiply (duplicate) selected
        - `gmm`: Multiply (duplicate) current line
    - More?
- `mini.bracketed`:
    - Go forward/backward with square brackets (similar to `tpope/vim-unimpaired`)
    - All bindings have the same format:
        - `[x`: prev x
        - `]x`: next x
        - `[X`: first x
        - `]X`: last x
    - `b`: Buffer (now built-in)
    - `c`: Comment block
    - `d`: Diagnostic (now built-in)
    - `f`: File on disk
    - `i`: Indentation change
    - `j`: Jump in jumplist (current buffer)
    - `l`: Location list (now built-in)
    - `o`: Old files
    - `q`: Quickfix list (now built-in)
    - `w`: Window (current tab)
    - `x`: Conflict
    - I've disabled a few:
        - `t`: Treesitter node or parent
        - `u`: Undo state (???)
        - `y`: Yank (???)
- `mini.trailspace`:
    - Highlights trailing whitespace
    - `:TrimWhitespace`: Trim trailing whitespace
- `mini.indentscope`:
    - Visualize and work with indent scope
    - Adds `i` textobject for indents (e.g. `]i`, `cii`, `vai`)
- `mini.sessions`:
    - Session management
    - Once a session is active (e.g. after load or save), it will be autosaved
    - `:Save <name>`: Save the current session as `<name>`
    - `:Resume`: Result the most recent session
    - `:Load`: Fuzzy-select a session to load
    - `:RmSession`: Fuzzy-select a session to load
