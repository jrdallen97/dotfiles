# Vim cheatsheet

NOTE: I'm not gonna list all the basics here, just the stuff that's useful for me

<!-- mtoc-start -->

- [Personal](CHEATSHEET#Personal)
- [Built-in](CHEATSHEET#Built-in)
    - [Launch options](CHEATSHEET#Launch options)
    - [Help](CHEATSHEET#Help)
    - [Editing](CHEATSHEET#Editing)
    - [Insert mode bindings](CHEATSHEET#Insert mode bindings)
    - [Misc](CHEATSHEET#Misc)
    - [Jumps](CHEATSHEET#Jumps)
    - [Marks](CHEATSHEET#Marks)
    - [Commands](CHEATSHEET#Commands)
    - [Settings](CHEATSHEET#Settings)
    - [Window commands](CHEATSHEET#Window commands)
    - [Folds](CHEATSHEET#Folds)
    - [Quickfix](CHEATSHEET#Quickfix)
    - [netrw](CHEATSHEET#netrw)
- [Plugins](CHEATSHEET#Plugins)
    - [Lazy](CHEATSHEET#Lazy)
    - [LSP](CHEATSHEET#LSP)
    - [Formatting](CHEATSHEET#Formatting)
    - [Diagnostics](CHEATSHEET#Diagnostics)
    - [Autocompletion](CHEATSHEET#Autocompletion)
    - [Oil](CHEATSHEET#Oil)
    - [Comments](CHEATSHEET#Comments)
    - [Markdown](CHEATSHEET#Markdown)
    - [Git](CHEATSHEET#Git)
    - [Grug-far](CHEATSHEET#Grug-far)
    - [Snacks](CHEATSHEET#Snacks)
        - [Snacks-picker](CHEATSHEET#Snacks-picker)
        - [Snacks explorer](CHEATSHEET#Snacks explorer)
        - [Snacks gitbrowse](CHEATSHEET#Snacks gitbrowse)
        - [Snacks notifier](CHEATSHEET#Snacks notifier)
    - [Mini](CHEATSHEET#Mini)
        - [Mini-diff](CHEATSHEET#Mini-diff)
        - [Mini-surround](CHEATSHEET#Mini-surround)
        - [Mini-splitjoin](CHEATSHEET#Mini-splitjoin)
        - [Mini-move](CHEATSHEET#Mini-move)
        - [Mini-operators](CHEATSHEET#Mini-operators)
        - [Mini-bracketed](CHEATSHEET#Mini-bracketed)
        - [Mini-trailspace](CHEATSHEET#Mini-trailspace)
        - [Mini-indentscope](CHEATSHEET#Mini-indentscope)
        - [Mini-sessions](CHEATSHEET#Mini-sessions)

<!-- mtoc-end -->

## Personal

My own stuff...

- `<leader>{n}`: Switch to tab number `{n}`
- `<leader>rs`:  Save & run current file (using shebang)
- `<leader>rts`: Save & time running current file (using shebang)

Toggles:

- `<leader>tw`: Toggle wrap
- `<leader>ts`: Toggle spellcheck
- `<leader>td`: Toggle diagnostics
- `<leader>tr`: Toggle ruler (default to col 100, use `:set cc=<n>` otherwise)
- `<leader>tl`: Toggle light mode

Shortcuts:

- `<leader>ev`: Open Vim settings in a new tab
- `<leader>ec`: Open Vim cheatsheet in a new tab
- `<leader>es`: Open Vim spellfile in a new tab

## Built-in

### Launch options

- `{file[s]}`: Open with file[s] in the arglist (see [[#Commands]])
- `+{number}`: Open file at line number
- `-d`: Open in diff-mode
- `-p`: Open a tab for each file passed
- `-O`: Open a vertical split for each file passed
- `-o`: Open a horizontal split for each file passed
- `-R`: Open in read-only mode
- `-M`: Open in very read-only mode (`nomodifiable nowrite`)

### Help

- `:h index`: A list of all commands for all modes
- `<C-]>`: Jump to definition (e.g. open help or follow help link)

### Editing

- `[<Space>`: Insert newline above cursor
- `]<Space>`: Insert newline below cursor
- `J`/`:join`: Join lines (also works with a visual range)
- `gu{motion}`: Make `{motion}` lowercase
- `gU{motion}`: Make `{motion}` uppercase
- `g~{motion}`: Invert case over `{motion}`
- Repeated letters make it apply to the current line, e.g.:
    - `guu`
    - `gUU`
    - `g~~`

Increment/decrement:

- `<C-a>`: Increment
- `<C-x>`: Decrement
- Extended by `monaqa/dial.nvim` to support dates, booleans, etc (user-extensible).
- Also works in VISUAL mode
- Using `g<C-a>`/`g<C-x>` in VISUAL mode will increment each line an additional time (useful for making lists) (accepts a count)

### Insert mode bindings

- `<C-u>`: Delete all characters before the cursor (e.g. undo auto-comment continuation)
- `<C-w>`: Delete word backwards
- `<C-t>`: Increase indentation of current line
- `<C-d>`: Decrease indentation of current line
- `<C-v>`: Insert a character literally

### Misc

Movement:

- `(` / `)`:    Move backwards/forwards by sentence
- `{` / `}`:    Move backwards/forwards by paragraph
- `[\[` / `]]`: Move backwards/forwards by section
- `*`:  Search for the word under the cursor
- `g*`: Search for the word under the cursor (including results within other words)
- `#`:  Search for the word under the cursor (reverse)
- `;`:  Repeat last f/e/etc movement
- `,`:  Repeat last f/e/etc movement (reverse)
- `ge`: Move to the end of the previous word
- `gi`: Continue insert mode from its last position
- `g;`: Move backwards in change list (e.g. insert, deletion, etc)
- `g,`: Move forwards in change list (e.g. insert, deletion, etc)
- `<C-6>`: Switch to the alternate file (usually the previously edited file)
- `gj`: Move cursor down by screen line (also `g<Down>`)
- `gk`: Move cursor up by screen line (also `g<Up>`)
- `g0`: Jump to start of screen line (also `g<Home>`)
- `g$`: Jump to end of screen line (also `g<End>`)
- `gv`: Restore previous visual selection
- `gn`: Jump to next search match and visually select it

Scrolling:

- `<C-u>`: Scroll up half a page (note: not a jump)
- `<C-d>`: Scroll down half a page
- `<C-b>`: Page up (also `<PageUp>` & `<S-Up`>)
- `<C-f>`: Page down (also `<PageDown>` & `<S-Down`>)
- `<C-y>`: Scroll up 1 line
- `<C-e>`: Scroll down 1 line
- `zt`:    Re-centre screen with the cursor at the top
- `zz`:    Re-centre screen with the cursor in the middle
- `zb`:    Re-centre screen with the cursor at the bottom

Copy/paste:

- `p`: Paste after the cursor
- `P`: Paste before the cursor
- VISUAL mode:
    - `p`: Paste over selection and yank previous contents
    - `P`: Paste over selection without yanking previous contents
        - This is especially useful when using something like `vi"` to select an entire string, for example.

Spell:

- `z=`:  Spelling suggestions
- `zg`:  Mark word as good (add to good word list)
- `zw`:  Mark word as wrong (add to wrong word list)
- `zug`: Undo `zg`/`zw`, remove word from spellfile

Modes (as used in mappings):

- `n`: Normal mode
- `i`: Insert mode
- `x`: Visual mode only
- `s`: Select mode only (like visual mode but typing replaces the selection)
- `v`: Visual and select mode
- `t`: Terminal mode
- `c`: Command-line mode
- `o`: Operator-pending mode

Undolist:

- `:undol[ist]`: List the leafs in the undo tree
- `g-`: Previous leaf in undo tree
- `g+`: Next leaf in undo tree

Random:

- `ga`: Print the ascii value of the character under the cursor

### Jumps

`:h jump-motions`

Jumps tend to be cursor movements that move your cursor multiple lines. When you jump, your previous position is remembered.

Note: scrolling (e.g. `<C-d>`) is not a jump.

- `:ju[mps]`: List jumps in current window
- `<C-o>`: Previous cursor position in jump list (i.e. not a motion)
- `<C-i>`: Next cursor position in jump list
- `<C-t>`: Previous position in tag stack (e.g. set when using `gd` to goto definition)
- `%`:     Jump to matching bracket
- `H`:     Jump the cursor to the top of the screen (Home)
- `M`:     Jump the cursor to the middle of the screen (Middle)
- `L`:     Jump the cursor to the bottom of the screen (Last)

### Marks

`:h mark-motions`

Marks let you save cursor positions and easily jump back to them.

- Lowercase marks are specific to the current buffer
- Uppercase marks are global and can be used to jump between files.
- `` m<mark> ``: Set mark
- `` '<mark> ``: Jump to mark, with cursor at the start of the line
- `` `<mark> ``: Jump to mark and restore marked cursor position

There are also some special marks:

- `.`: The position where the last change was made (e.g. text inserted or deleted)
- `^`: The position where where we last left insert mode
- `[`: The first character of previously yanked or changed text
- `]`: The last character of previously yanked or changed text

### Commands

- `:g[lobal]/{pattern}/{cmd}`: Run ex command `{cmd}` on all lines matching `{pattern}`
    - The default `{cmd}` is `p` (print)
    - If no pattern is provided, the most recent search term is used instead
    - Use `:v[global]`/`g[lobal]!` to run all lines that _don't_ match
- Argument list:
    - `:ar[gs]`:           Print the arglist
    - `:ar[gs] {arglist}`: Set the arglist
    - `:arga[dd]`:         Add current buffer to the arglist
    - `:arga[dd] {files}`: Add files to the arglist
    - `:argded[upe]`:      Dedupe arglist
    - `:argd[elete] {pattern}`: Delete files matching pattern from the arglist
    - TIP: Use `:ar **/*.lua` to open all lua files in a project, then `:argd *` to wipe the arglist but leave all the buffers open
- Cool little helpers to run a command across lots of files:
    - `:cdo {cmd}`:   Run `{cmd}` in for each entry in the quickfix list
    - `:cfdo {cmd}`:  Run `{cmd}` in for every file in the quickfix list
    - `:ldo {cmd}`:   Run `{cmd}` in for each entry in the location list
    - `:lfdo {cmd}`:  Run `{cmd}` in for every file in the location list
    - `:bufdo {cmd}`: Run `{cmd}` in all buffers
    - `:windo {cmd}`: Run `{cmd}` in all windows in the current tab
    - `:argdo {cmd}`: Run `{cmd}` in all files in argument list
    - `:tabdo {cmd}`: Run `{cmd}` in all tabs
- `:%s/pattern/replacement`: Replace `pattern` with `replacement` on all lines in file
    - `:s` would do this same for current line only
    - add `/g` to replace all instances (i.e. if there are multiple on the same line)
    - add `/c` to prompt for confirmation before replacing each match
    - use `:bufdo %s/...` to run this in all open buffers (then `:wa` to save them all)
- `:vim[grep] /pattern/ {file(s)}`: Search for a pattern and put results in the quickfix list
    - use `%` for the current file
    - a pattern of `//` will reuse the last search pattern
    - if the slashes are omitted then the pattern will be whitespace separated instead
    - `:lv[imgrep]` is the same but using the location list
    - `:vimgrepa[dd]`/`:lvimgrepa[dd]` will append to the list rather than replacing it
- Diff mode
    - `:difft[his]`: Mark the current window as part of the diff.
        - `:windo diffthis`: Applies the above for all windows in the current tab.
    - `:diffo[ff]`:  Turn off diff mode for the current window.
    - `:diffo[ff]!`: Turn off diff mode for all windows in the current tab.
- Use `<C-v>` to type literal escape characters
    - `<C-v><Esc>` outputs a literal escape character ``, which can be used with commands e.g. `:norm`
- Command-line window
    - The command-line window lets you find previous commands/searches to edit or rerun them
    - Opening the window:
        - `q:`: Command history
        - `q/`: Search history
        - `q?`: Backwards search history (same list as `q/`)
        - `<C-f>`: While already in the command line
    - Within the window:
        - `<CR>`:  Rerun the selected command
        - `<C-c>`: Move the selected command to the command line and close the window

### Settings

- `:set cc=100`: Show an indent guide on column 100

### Window commands

Note: most of these work even if you continue holding `Ctrl` for the 2nd key, e.g. `<C-w><C-o>`.

- `<C-w>s`: `:sp[lit]`
- `<C-w>v`: `:vsp[lit]`
- `<C-direction>`:    Move to the window in `<direction>` (only `hjkl`) (_custom_)
- `<C-w><direction>`: Move to the window in `<direction>` (`<Up>`, `k`, etc)
- `<C-w><DIRECTION>`: Move the current window all the way to `<DIRECTION>` (only `HJKL` by default but I added maps for shift + arrow keys)
- `<C-w>x`: Swap current window with the next window
- `<C-w>c`: Close the current window (also: `:clo[se]`). Fails on the last window.
- `<C-w>q`: Close the current window (also: `:q[uit]`). On the last window, quit vim.
- `<C-w>o`: Close all but the current window (also: `:only`)
- `<C-w>u`: Undo closing a window (provided by `AndrewRadev/undoquit.vim`)
- `<C-w>t`: Open current window in new tab (alias for `:tab split`) (_custom_)
- `<C-w>T`: Move current window to new tab
- `<C-w>w`: Move to the previous window (move left/up), loop to last window if already at first
- `<C-w>p`: Move to the most recently accessed window
- `<C-w>=`: Equalise splits/make all windows the same size
- `<C-w>f`: Focus current window (maximise height & width) (_custom_)
- `<C-w>_`: Maximise height of current window
- `<C-w>|`: Maximise width of current window

Also, for tabs:

- `gt`: Next tab
- `gT`: Prev tab
- `[n]gt`: Goto nth tab
- `:tabe[dit]`:  Open a file in a new tab
- `:tabc[lose]`: Close current tab

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

### Quickfix

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

[[#Mini-bracketed]] provides `q` & `l` bindings for easy quickfix/location list navigation.

Handy shortcuts:

TODO: not yet ported over

- `<leader>co`: `:copen`
- `<leader>cc`: `:cclose`
- `<leader>cn`: `:cnext`
- `<leader>cp`: `:cprev`
- `<leader>cf`: `:cfirst`
- `<leader>cl`: `:clast`

### netrw

NOTE: I've replaced this with Oil

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

### Lazy

Provided by `folke/lazy.nvim`.

- `<CR>`: Plugin details
- `]]`: Next plugin
- `[[`: Prev plugin
- `d`:  Show diff for commit
- `K`:  Open links/git commits in browser

### LSP

Built-in keybinds:

- `K`:     Hover information
- `<C-s>`: (INSERT) Signature help
- `grr`: Goto references
- `gri`: Goto implementation
- `grn`: Rename symbol
- `gra`: Code actions
- `gO`:  Document symbols

Extended by `neovim/nvim-lspconfig` (among others).

Extended keybinds:

- `K`:     Hover information
- `<C-k>`: (INSERT) Hover information
- `<C-s>`: (NORMAL/INSERT) Signature help
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

### Formatting

Provided by `stevearc/conform.nvim`.

- `<leader>F`:  `:Format` current file
- `<leader>tf`: `:ToggleFormat` (current buffer)
- `<leader>tF`: `:ToggleFormatGlobal`

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

Provided by `saghen/blink.cmp`.

- `<Tab>`:  Accept completion
- `<Down>`: Next suggestion
- `<Up>`:   Previous suggestion
- `<C-e>`:  Exit/cancel completion
- `<C-n>`:  Next position in snippet
- `<C-p>`:  Previous position in snippet
- `<C-m>`:  Cycle snippet choices
- `<C-b>`:  Scroll documentation up
- `<C-f>`:  Scroll documentation down
- `<C-k>`:  Toggle showing signature help
- `<C-Space>`: Toggle showing documentation

### Oil

Provided by `stevearc/oil.nvim`.

A netrw replacement that lets you browse and edit the filesystem as if it was a regular buffer.

- `<M-d>`: Toggle file details (e.g. size, permissions, last modified)
- `<M-h>`: Toggle hidden files

### Comments

Provided by `numToStr/Comment.nvim`.

Provides some handy shortcuts for commenting/uncommenting blocks of code. Some of this functionality is now built-in, but this plugin extends and improves it.

- `gcc`: Toggle comment on line
- `gc` (VISUAL): Toggle comment on selected line(s)/region(s)

Also: `folke/todo-comments.nvim`.

- Provides colouring & keybinds for working with various types of comment, including:
    - TODO
    - NOTE (also INFO)
    - WARN (also WARNING)
    - FIX (also BUG, FIXME, ISSUE)
    - And more!
- `[t`: Previous TODO/other comment
- `]t`: Next TODO/other comment

### Markdown

Provided by `hedyhli/markdown-toc.nvim`:

- `:Mtoc`: Update existing table of contents, or generate one at the cursor position

Provided by `roodolv/markdown-toggle.nvim`:

- Lists automatically continue when using `o`/`O` in NORMAL mode or `<CR>` in INSERT mode
    - Use `<C-u>` to undo (see [[CHEATSHEET#Insert mode bindings]])
- `<M-x>`: Toggle checkbox (NORMAL/VISUAL)
- `<M-u>`: Toggle unordered list (NORMAL/VISUAL)
- `<M-o>`: Toggle ordered list (NORMAL/VISUAL)
- `<M-q>`: Toggle quote (NORMAL/VISUAL)
- `<M-h>`: Toggle heading (NORMAL/VISUAL)

Provided by `gaoDean/autolist.nvim`:

- `<CR>`:  Toggle checkbox & move to next line (NORMAL)
- `<M-r>`: Recalculate ordered list numbering
- Deleting list items automatically recalculates numbering

### Git

Provided by `tpope/vim-fugitive`.

- `:Git`: Open fugitive
- `:Git {cmd}`: Run git command
- `<leader>gg`: Open fugitive in a new tab
- `<leader>gs`: Git status - [[#Snacks-picker]]
- `<leader>go`: Git diff overlay - [[#Mini-diff]]
- `<leader>gd`: Git diff vs. head
- `<leader>gD`: Git diff vs. previous commit
- `<leader>gb`: Git blame
- `<leader>gc`: Git commit
- `<leader>gp`: Git push
- `<leader>gl`: Git pull
- `ghs`: Stage hunk/selection (NORMAL/VISUAL) - [[#Mini-diff]]
- `ghr`: Restore hunk/selection (NORMAL/VISUAL) - [[#Mini-diff]]
- `ghS`: Stage entire buffer
- `ghR`: Restore entire buffer

Within fugitive:

- `]]`: Next section
- `[[`: Previous section
- `-`: Toggle staged for file/hunk
- `=`: Toggle inline diff for file/hunk
- `s`: Stage file/hunk
- `u`: Unstage file/hunk
- `U`: Unstage all
- `X`: Discard file/hunk

### Grug-far

Provided by `MagicDuck/grug-far.nvim`.

Find and replace plugin for neovim.

- `:GrugFar`:       Find and replace (uses any visual selection as the search string)
- `:GrugFarWithin`: Find and replace within the current visual selection

### Snacks

Provided by `folke/snacks.nvim`.

#### Snacks-picker

Shortcuts:

- Misc:
    - `<leader><leader>`: Switch buffers
    - `<leader>/`:  Smart finder
    - `<leader>gs`: Git status
    - `<leader>fr`: Resume previous search
    - `<leader>sr`: Resume previous search
- Search help:
    - `<leader>hh`: Help: Help
    - `<leader>hc`: Help: Commands
    - `<leader>hk`: Help: Keybinds
    - `<leader>hp`: Help: Pickers
- Find files (or directories!):
    - `<leader>ff`: Find: Files
    - `<leader>fo`: Find: Oldfiles (recently opened files)
    - `<leader>fd`: Find: Directories
    - `<leader>fl`: Find: Local (current directory - only from within Oil)
- Search for strings (lines, contents, etc):
    - `<leader>ss`: Search: for String/by Grep
    - `<leader>sg`: Search: for String/by Grep
    - `<leader>sb`: Search: within open Buffers
    - `<leader>sl`: Search: Local (current directory - only from within Oil)
- Search for diagnostics/errors:
    - `<leader>sd`: Search: for Diagnostics (current file)
    - `<leader>sD`: Search: for Diagnostics (global)
    - `<leader>se`: Search: for Errors (current file)
    - `<leader>sE`: Search: for Errors (global)
- Search for current word/visual selection:
    - `<leader>sw`: Search for word under cursor/visual selection
- Personal shortcuts:
    - `<leader>fv`: Find vim config
    - `<leader>sv`: Search vim config
    - `<leader>fn`: Find note
    - `<leader>sn`: Search notes

Picker shortcuts:

- Note: most of these work in NORMAL & INSERT mode unless specified
- `<C-/>`: Toggle help
- `<CR>`:  Confirm
- `<C-t>`: Open in new tab
- `<C-s>`: Open in new split
- `<C-v>`: Open in new vsplit
- `<C-c>`: Cancel/close picker
- `<C-b>`: Scroll preview down
- `<C-f>`: Scroll preview up
- `<Tab>`:   Select & move to next
- `<S-Tab>`: Select & move to previous
- `<C-a>`:   Select all (toggle)
- `<C-q>`:   Send selected to quickfix
- NORMAL mode bindings:
    - `?`:     Toggle help
    - `a`:     Refocus input
    - `i`:     Refocus input
    - `q`:     Cancel/close picker
    - `<Esc>`: Cancel/close picker
- Toggles:
    - `<M-h>`: Toggle hidden
    - `<M-i>`: Toggle ignored
    - `<M-m>`: Toggle maximised
    - `<M-p>`: Toggle preview

#### Snacks explorer

Shortcuts:

- `\`: Toggle file explorer

Picker shortcuts:

- `r`: Rename
- `c`: Copy
- `p`: Paste
- `o`: Open (system)
- `m`: Move selected to dir under cursor
- `<Tab>`: Toggle selected
- `<C-c>`: Change directory here (`cd`)
- `<BS>` : Show parent directory (does not `cd`)
- `H`: Toggle hidden
- `I`: Toggle ignored
- `Z`: Collapse all
- `]g`/`[g`: Next/prev file with git changes (new/modified)
- `]d`/`[d`: Next/prev file with diagnostics (any)
- `]w`/`[w`: Next/prev file with diagnostics (warn)
- `]e`/`[e`: Next/prev file with diagnostics (error)
- `<C-t>`: Open terminal here

#### Snacks gitbrowse

Commands:

- `:GitBrowse`: Open current file in browser

#### Snacks notifier

Commands:

- `:Notifications`: Notification history

### Mini

Provided by `nvim-mini/mini.nvim`.

A collection of various small independent plugins/modules.

#### Mini-diff

Work with diff hunks.

- `<leader>go`: Toggle diff overlay
- `ghs`: Apply/stage hunk (either current hunk or visual selection) (NORMAL/VISUAL)
- `ghr`: Reset hunk (either current hunk or visual selection) (NORMAL/VISUAL)
- Text operators:
    - `ih`: In hunk
- Examples:
    - `yih`: Yank entire hunk

#### Mini-surround

Add/delete/replace surroundings (brackets, quotes, etc.)

- `ss`: Add surrounding
    - Special characters for surround:
        - `B`: Markdown bold (_custom_)
        - `h`: Markdown hyperlink (_custom_)
        - `s`: Generic string (_custom_)
        - `m`: Mirrored string (e.g. `{[` would be mirrored to `]}`) (_custom_)
        - `t`: HTML tag
        - `f`: Function call; wraps the motion as a call to the give function
        - `?`: Interactive; prompts separately for the opening/closing string
    - Accepts a count to surround with repeated characters
    - `cstt`: Replace surrounding HTML tag with a different one
- `cs`: Change surrounding
- `ds`: Delete surrounding

#### Mini-splitjoin

Split if arguments are on single line, join otherwise (also works on visual selection to disambiguate).

- `gS`: Split/join

#### Mini-move

Move current line/selection in direction (NORMAL/INSERT/VISUAL).

- `<M-direction>`: Move

#### Mini-operators

Adds various text editing operators.

- `g=`: Evaluate selected (e.g. `1+1` -> `2`)
- `gs`: Sort selected
- `gm`: Multiply (duplicate) selected
    - `gmm`: Multiply (duplicate) current line
- More?

#### Mini-bracketed

Go forward/backward with square brackets (similar to `tpope/vim-unimpaired`).

- All bindings have the same format:
    - `[x`: prev x
    - `]x`: next x
    - `[X`: first x
    - `]X`: last x
- Suffixes:
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
- I've disabled a few suffixes that weren't useful or conflicted with other keybinds:
    - `t`: Treesitter node or parent
    - `u`: Undo state (???)
    - `y`: Yank (???)

#### Mini-trailspace

Highlights trailing whitespace.

- `:TrimWhitespace`: Trim trailing whitespace

#### Mini-indentscope

Visualize and work with indent scope.

- Adds `i` textobject for indents (e.g. `]i`, `cii`, `vai`)

#### Mini-sessions

Session management.

- `mini.starter` will show a list of available sessions on startup.
- Once a session is active (e.g. after load or save), it will be autosaved.
- Commands:
    - `:Save <name>`: Create session `<name>`, or manually save the current if called with no arguments
    - `:SaveLocal`:   Create local session; the same as `:Save Session.nvim`
    - `:Resume`:      Resume the local session, or the most recent global session if none exists
    - `:Sessions`:    Fuzzy-find sessions (`<C-x>` to delete)
