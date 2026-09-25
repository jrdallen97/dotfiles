# Vim cheatsheet

NOTE: I'm not gonna list all the basics here, just the stuff that's useful for me

<!-- mtoc-start -->

- [[#Launch options]]
- [[#Help]]
- [[#Misc]]
- [[#Movement]]
    - [[#Motions]]
    - [[#Search]]
    - [[#Jumps]]
    - [[#Marks]]
    - [[#Scrolling]]
- [[#Editing]]
- [[#Spellcheck]]
- [[#Running/testing files]]
- [[#Cmdline]]
    - [[#Sort]]
    - [[#Search/replace]]
    - [[#Vimgrep]]
    - [[#Diff mode]]
    - [[#Arglist]]
    - [[#Running commands across files]]
    - [[#Command-line window]]
- [[#Git]]
    - [[#Fugitive]]
- [[#Oil]]
- [[#Built-in]]
    - [[#Editing]]
    - [[#Insert mode bindings]]
    - [[#Window commands]]
    - [[#Folds]]
    - [[#Quickfix]]
    - [[#Registers]]
- [[#Plugins]]
    - [[#LSP]]
    - [[#Formatting]]
    - [[#Diagnostics]]
    - [[#Autocompletion]]
    - [[#Comments]]
    - [[#Markdown]]
    - [[#Grug-far]]
    - [[#Snacks]]
        - [[#Snacks-picker]]
        - [[#Snacks explorer]]
    - [[#Mini]]
        - [[#Mini-comment]]
        - [[#Mini-diff]]
        - [[#Mini-surround]]
        - [[#Mini-splitjoin]]
        - [[#Mini-move]]
        - [[#Mini-operators]]
        - [[#Mini-bracketed]]
        - [[#Mini-sessions]]

<!-- mtoc-end -->

## Launch options

- `{file[s]}`: Open with file[s] in the arglist (see [[#Commands]])
- `+{number}`: Open file at line number
- `-d`: Open in diff-mode
- `-p`: Open a tab for each file passed
- `-O`: Open a vertical split for each file passed
- `-o`: Open a horizontal split for each file passed
- `-R`: Open in read-only mode
- `-M`: Open in very read-only mode (`nomodifiable nowrite`)

## Help

- `:h index`: A list of all commands for all modes
- `<C-]>`: Jump to definition (e.g. open help or follow help link)

## Misc

- `<leader>{n}`: Switch to tab number `{n}`
- Shortcuts to files set under the `<leader>e` prefix (edit). Examples:
    - `<leader>ev`: Open Vim settings in a new tab
    - `<leader>ec`: Open Vim cheatsheet in a new tab
    - `<leader>es`: Open Vim spellfile in a new tab
- Toggles sit under the `<leader>t` prefix.
- `<leader>?`: Show buffer-local keymaps (`which-key`)
- `ga`: Print the ASCII value of the character under the cursor

## Movement

### Motions

`:h cursor-motions`

Motions can be used after an operator to operate on the text that was moved over.

- `w`/`b`/`e`/`ge`: Move forwards/backwards to the start/end of words
    - Prefix with `,` to move by subwords, e.g. camelCase (`nvim-spider`)
- `(`/`)`:    Move backwards/forwards by sentence
- `{`/`}`:    Move backwards/forwards by paragraph
- `[\[`/`]]`: Move backwards/forwards by section
- `;`/`,`: Repeat last f/e/etc movement (forwards/backwards)
- `gi`: Continue insert mode from its last position
- `g;`: Move backwards in change list (e.g. insert, deletion, etc)
- `g,`: Move forwards in change list (e.g. insert, deletion, etc)
- `<C-6>`: Switch to the alternate file (usually the previously edited file)
- `gj`: Move cursor down by screen line (also `g<Down>`)
- `gk`: Move cursor up by screen line (also `g<Up>`)
- `g0`: Move to start of screen line (also `g<Home>`)
- `g$`: Move to end of screen line (also `g<End>`)
- `gv`: Restore previous visual selection

### Search

- `*`/`#`:   Search forwards/backwards for the word under the cursor (whole word matches only)
- `g*`/`g#`: Search forwards/backwards for the word under the cursor (including matches within words)
- `gn`: Jump to next search match and visually select it

### Jumps

`:h jump-motions`

Jumps tend to be cursor movements that move your cursor multiple lines. When you jump, your previous position is remembered.

Note: motions and scrolling are not jumps.

- `<C-i>`/`<C-o>`: Next/previous cursor position in jump list
- `<C-n>`/`<C-p>`: Next/previous file in jump list (`bufjump`)
- `<C-t>`: Previous position in tag stack (e.g. set when using `gd` to goto definition)
- `%`: Jump to matching bracket
- `H`: Jump the cursor to the top of the screen (Home)
- `M`: Jump the cursor to the middle of the screen (Middle)
- `L`: Jump the cursor to the bottom of the screen (Last)

### Marks

`:h mark-motions`

Marks let you save cursor positions and easily jump back to them.

- Types of mark:
    - `a-z`: Lowercase marks, valid within one file
    - `A-Z`: Uppercase marks/file marks, valid between files
    - `0-9`: Numbered marks, automatically set by the `shada` file (basically remember where you were when you closed vim)
- ``  m<mark>  ``: Set mark
- ``  '<mark>  ``: Jump to mark and position cursor at the start of the line
- ``  `<mark>  ``: Jump to mark and restore marked cursor position
- `:marks`: List marks
- `:delm[arks] {marks}`: Delete the given marks
- `:delm[arks]!`: Delete all marks for the current buffer

There are also some special marks:

- `.`: The position where the last change was made (e.g. text inserted or deleted)
- `^`: The position where where we last left insert mode
- `[`: The first character of previously yanked or changed text
- `]`: The last character of previously yanked or changed text

### Scrolling

- `<C-u>`: Scroll up half a page (note: not a jump)
- `<C-d>`: Scroll down half a page
- `<C-b>`: Page up (also `<PageUp>` & `<S-Up`>)
- `<C-f>`: Page down (also `<PageDown>` & `<S-Down`>)
- `<C-y>`: Scroll up 1 line
- `<C-e>`: Scroll down 1 line
- `zt`: Re-centre screen with the cursor at the top
- `zz`: Re-centre screen with the cursor in the middle
- `zb`: Re-centre screen with the cursor at the bottom

## Editing

- `[<Space>`/`]<Space>`: Insert newline above/below cursor
- `J`/`:join`: Join lines (also works with a visual range)

Operators can operate over a motion or visual selection, or the last character can typically be repeated to operate on the current line. Examples:

- `=`: Fix indentation
- `g~`: Swap case
- `gu`: Make lowercase
- `gU`: Make uppercase
- `gq`: Format text
    - Configured by `formatoptions`/`fo`; see `:h fo-table`
    - Target line length is configured with `textwidth`/`tw` (default 100)
- `gw`: The same as `gq`, but without moving the cursor
- `<`/`>`: Shift text left/right

Copy/paste:

- `p`: Paste after the cursor
- `P`: Paste before the cursor
- `p`: (VISUAL) Paste over selection and yank previous contents
- `P`: (VISUAL) Paste over selection without yanking previous contents
    - Especially useful when using something like `vi"` to select an entire string, for example.

Increment/decrement:

- `<C-a>`: Increment
- `<C-x>`: Decrement
- `g<C-a>`: (VISUAL) Increment each line an additional time (useful for making lists)

Undolist:

- `:undol[ist]`: List the leafs in the undo tree
- `g-`: Previous leaf in undo tree
- `g+`: Next leaf in undo tree

## Spellcheck

Spell:

- `z=`:  Spelling suggestions
- `zg`:  Mark word as good (add to good word list)
- `zw`:  Mark word as wrong (add to wrong word list)
- `zug`: Undo `zg`/`zw`, remove word from spellfile

## Running/testing files

Running files sits under `<leader>r` and is generic, but can be overridden on a per-language level. Examples:

- `<leader>rs`:  Save & run current file (using shebang)
- `<leader>rts`: Save & time running current file (using shebang)

Testing files sits under `<leader>R` and is entirely per-language. For example, `golang` has:

- `<leader>RR`: Save & test current file
- `<leader>RV`: Save & test current file (verbose)

## Cmdline

- Use `<C-v>` to type special characters literally
    - `<C-v><Esc>` outputs a literal escape character `` (useful for `:norm`)
- `:lua`: Run lua code
- `:lua=`/`:=`: Run lua code and print return value (equivalent to `:lua vim.print(...)`)

### Sort

- `:sort`: Sort the current file/range
- Options:
    - `!`: Reverse order
    - `i`: Case insensitive
    - `n`: Numeric sort (using the first decimal on each line)
    - `f`: Numeric sort (using the first float on each line)
    - `u`: Deduplicate identical lines (equivalent to `:%!sort | uniq`)
- Dedupe without sorting: `:%!awk '\!a[$0]++'`

Run command on matching lines:

- `:g[lobal]/{pattern}/{cmd}`: Run ex command `{cmd}` on all lines matching `{pattern}`
- If no pattern is provided (`:g//`), the most recent search term is used instead
- Use `:v[global]`/`g[lobal]!` to run all lines that _don't_ match
- Ex-commands:
    - `p[rint]`:  Print line (default)
    - `d[elete]`: Delete line

### Search/replace

- `:%s/pattern/replacement`: Replace `pattern` with `replacement` on all lines in file:
- `:s` would do this same for current line only
- add `/g` to replace all instances (i.e. if there are multiple on the same line)
- add `/c` to prompt for confirmation before replacing each match
- use `:bufdo %s/...` to run this in all open buffers (then `:wa` to save them all)

### Vimgrep

- `:vim[grep] /pattern/ {file(s)}`: Search for a pattern and put results in the quickfix list:
- use `%` for the current file
- a pattern of `//` will reuse the last search pattern
- if the slashes are omitted then the pattern will be whitespace separated instead
- `:lv[imgrep]` is the same but using the location list
- `:vimgrepa[dd]`/`:lvimgrepa[dd]` will append to the list rather than replacing it

### Diff mode

- `:difft[his]`: Mark the current window as part of the diff.
    - `:windo diffthis`: Applies the above for all windows in the current tab.
- `:diffo[ff]`:  Turn off diff mode for the current window.
- `:diffo[ff]!`: Turn off diff mode for all windows in the current tab.

### Arglist

- `:ar[gs]`:           Print the arglist
- `:ar[gs] {arglist}`: Set the arglist
- `:arga[dd]`:         Add current buffer to the arglist
- `:arga[dd] {files}`: Add files to the arglist
- `:argded[upe]`:      Dedupe arglist
- `:argd[elete] {pattern}`: Delete files matching pattern from the arglist
- TIP: Use `:ar **/*.lua` to open all lua files in a project, then `:argd *` to wipe the arglist but leave all the buffers open

### Running commands across files

- `:cdo {cmd}`:   Run `{cmd}` in for each entry in the quickfix list
- `:cfdo {cmd}`:  Run `{cmd}` in for every file in the quickfix list
- `:ldo {cmd}`:   Run `{cmd}` in for each entry in the location list
- `:lfdo {cmd}`:  Run `{cmd}` in for every file in the location list
- `:bufdo {cmd}`: Run `{cmd}` in all buffers
- `:windo {cmd}`: Run `{cmd}` in all windows in the current tab
- `:argdo {cmd}`: Run `{cmd}` in all files in argument list
- `:tabdo {cmd}`: Run `{cmd}` in all tabs

### Command-line window

The command-line window lets you find previous commands/searches to edit or rerun them:

- `q:`: Command history
- `q/`: Search history
- `q?`: Backwards search history (same list as `q/`)
- `<C-f>`: While already in the command line
- Within the window:
    - `<CR>`:  Rerun the selected command
    - `<C-c>`: Move the selected command to the command line and close the window

## Git

Most keybinds sit under a prefix:

- `<leader>g`: Git (status, blame, etc)
- `gh`: Git hunk (stage, restore)

### Fugitive

- `:Git`: Open fugitive
- `:Git {cmd}`: Run git command

Within fugitive:

- `]]`: Next section
- `[[`: Previous section
- `-`: Toggle staged for file/hunk
- `=`: Toggle inline diff for file/hunk
- `s`: Stage file/hunk
- `u`: Unstage file/hunk
- `U`: Unstage all
- `X`: Discard file/hunk

## Oil

A netrw replacement that lets you browse and edit the filesystem as if it was a regular buffer.

- `<M-d>`: Toggle file details (e.g. size, permissions, last modified)
- `<M-h>`: Toggle hidden files

---

## Built-in

### Editing

### Insert mode bindings

- `<C-u>`: Delete all characters before the cursor (e.g. undo auto-comment continuation)
- `<C-w>`: Delete word backwards
- `<C-t>`: Increase indentation of current line
- `<C-d>`: Decrease indentation of current line
- `<C-v>`: Insert a character literally

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
    - `zo`: Open one fold under the cursor. Accepts count (e.g. `3zo`)
    - `zO`: Open all folds under the cursor recursively. Folds that don't contain the cursor line are unchanged.
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

The location list also behaves similarly but only stores locations for the current window. The commands to use it are the same, replacing the first `c` with `l` (e.g. `:lopen`, `]l`).

Handy shortcuts:

- `<leader>co`: `:copen`
- `<leader>cc`: `:cclose`
- `<leader>cn`: `:cnext`
- `<leader>cp`: `:cprev`
- `<leader>cf`: `:cfirst`
- `<leader>cl`: `:clast`

### Registers

- `:reg[isters]`: Display the contents of all numbered/named registers
- `"n`: Use register `n` for the next delete, yank or put
- `"N`: Use register `N` for the next delete, yank or put, but append to the register rather than replacing it
- `<C-r>n`: (INSERT/COMMAND) Insert register `n`
- Certain registers have special meanings:
    - `_`: Black hole register
    - `"`: The unnamed register; holds the last thing you yanked _or_ deleted
    - `0`: Holds the last thing you yanked
    - `1`: Holds the last thing you deleted/changed
    - `%`: Holds the current filename
    - `#`: Holds the previous filename
    - `:`: Holds the most recent command
    - `.`: Holds the last inserted text

## Plugins

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

- `K`: Hover information
- `<C-k>`: (NORMAL/INSERT) Hover information
- `<C-s>`: (NORMAL/INSERT) Signature help
- `gd`: Goto definition
- `gr`: Goto references
- `gI`: Goto implementation
- `gD`: Goto type definition
- `gO`: Open document symbols (outline)
- `gW`: Open workspace symbols
- `<F2>`: Rename symbol under cursor
- `<F4>`: Code actions

### Formatting

Provided by `stevearc/conform.nvim`.

- `:Format`:   Format current file
- `<leader>F`: Format current file
- `<leader>tf`: Toggle autoformat (buffer)
- `<leader>tF`: Toggle autoformat (global)

### Diagnostics

Kinda built in, but also fed by LSP.

- `[d`: Previous diagnostic
- `]d`: Next diagnostic
- `[D`: First diagnostic
- `]D`: Last diagnostic
- `<leader>q`: Send diagnostics to quickfix (error only)
- `<leader>Q`: Send diagnostics to quickfix (all diagnostics)
- `<leader>l`: Send diagnostics to loclist (error only)
- `<leader>L`: Send diagnostics to loclist (all diagnostics)

### Autocompletion

Provided by `saghen/blink.cmp`.

- `<Down>`: Next suggestion
- `<Up>`:   Previous suggestion
- `<Tab>`: Accept completion
- `<C-e>`: Exit/cancel completion
- `<C-h>`: Previous position in snippet
- `<C-l>`: Next position in snippet
- `<C-b>`: Scroll documentation up
- `<C-f>`: Scroll documentation down
- `<C-k>`: Toggle showing signature help
- `<C-Space>`: Toggle showing documentation

### Comments

Provided by `folke/todo-comments.nvim`.

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

### Grug-far

Provided by `MagicDuck/grug-far.nvim`.

Find and replace plugin for neovim.

- `:GrugFar`:       Find and replace (uses any visual selection as the search string)
- `:GrugFarWithin`: Find and replace within the current visual selection

### Snacks

Provided by `folke/snacks.nvim`.

- `:GitBrowse`: Open current file in browser
- `:Notifications`: Notification history
- `<C-t>`: Toggle floating terminal

#### Snacks-picker

Shortcuts:

- `<leader><leader>`: Switch buffers
- Most commands sit under a prefix to group similar commands:
    - `<leader>h`: Help (reference, misc)
    - `<leader>f`: Find files/directories
    - `<leader>s`: String search
    - `<leader>d`: Search for diagnostics/errors

Picker shortcuts:

- Note: most of these work in NORMAL & INSERT mode unless specified
- `<C-/>`: Toggle help
- `<C-t>`: Open in new tab
- `<C-s>`: Open in new split
- `<C-v>`: Open in new vsplit
- `<C-c>`: Cancel/close picker
- `<C-b>`: Scroll preview up
- `<C-f>`: Scroll preview down
- `<Tab>`:   Select & move to next
- `<S-Tab>`: Select & move to previous
- `<C-a>`:   Select all (toggle)
- `<C-q>`:   Send selected to quickfix
- Toggles:
    - `<M-h>`: Toggle hidden
    - `<M-i>`: Toggle ignored
    - `<M-m>`: Toggle maximised
    - `<M-p>`: Toggle preview
- NORMAL mode only:
    - `?`: Toggle help
    - `a`/`i`: Refocus input
    - `<Esc>`/`q`: Cancel/close picker

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

### Mini

Provided by `nvim-mini/mini.nvim`.

- `:Start`: Re-open `mini.starter`
- `:TrimWhitespace`: Trim trailing whitespace

#### Mini-comment

Extends built-in `gc`/`gcc` with configurable mappings and hooks.

- `gcc`: Toggle comment
- `<C-/>`: (NORMAL/INSERT) Toggle comment
- `gc`: (VISUAL) Toggle comment on selected line(s)/region(s)
- `ic`: Comment text object

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

Move current line/selection with `<M-direction>` (NORMAL/INSERT/VISUAL).

#### Mini-operators

Adds various text editing operators.

- `g=`: Evaluate selected (e.g. `1+1` -> `2`)
- `gs`: Sort selected
- `gm`: Multiply (duplicate) selected
    - `gmm`: Multiply (duplicate) current line
- `<leader>x`: Exchange selected
    - First usage: mark motion to exchange
    - Second usage: select motion to exchange & swap them

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
        - In diff buffers, this jumps between changes instead (built-in)
    - `d`: Diagnostic (now built-in)
    - `f`: File on disk
    - `i`: Indentation change
    - `j`: Jump in jumplist (current buffer)
    - `l`: Location list (now built-in)
    - `o`: Old files
    - `q`: Quickfix list (now built-in)
    - `w`: Window (current tab)
    - `x`: Conflict
    - `y`: Yank
        - After pasting, lets you replace pasted text to older/newer yank entries
- I've disabled a few suffixes that weren't useful or conflicted with other keybinds:
    - `t`: Treesitter node or parent
    - `u`: Linear undo

#### Mini-sessions

Session management.

- `mini.starter` will show a list of available sessions on startup.
- Once a session is active (e.g. after load or save), it will be autosaved on exit.
- Commands:
    - `:Save <name>`: Create session `<name>`, or manually save the current if called with no arguments
    - `:SaveLocal`:   Create local session; equivalent to `:Save Session.vim`
    - `:Sessions`:    Fuzzy-find sessions (`<C-x>` to delete)
