# PATH
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/go/bin

# Turn on zsh history file
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY # Use the timestamp format
setopt INC_APPEND_HISTORY_TIME # Add new lines when they are run, but ensure the timing works
setopt HIST_IGNORE_SPACE # Ignore lines starting with a space
setopt HIST_IGNORE_DUPS # Don't log subsequent identical lines

# cd settings (e.g. history)
setopt AUTO_CD # Lets you cd by typing the name of a directory
setopt AUTO_PUSHD # Make cd push the old directory onto the directory stack
setopt PUSHD_IGNORE_DUPS # Don't add dupe directories to the stack
setopt PUSHD_MINUS # Swap the meaning of `+` & `-` for `cd` (so that e.g. `cd -2` will go back 2 dirs in the stack)
DIRSTACKSIZE=20 # I don't really need a long history

# Preferred editor
if command -v nvim >/dev/null; then
  export EDITOR='nvim'
  export VISUAL='nvim'
else
  export EDITOR='vim'
  export VISUAL='vim'
fi

# Make less a little nicer
export LESS='-RiF --mouse --wheel-lines=3'

# Load my aliases (and some functions)
[[ -r "$HOME/.zsh_aliases" ]] && source "$HOME/.zsh_aliases"
# Load optional configs
[[ -r "$HOME/.zshrc.sparx" ]] && source "$HOME/.zshrc.sparx"
# Load local config (useful for storing secrets)
[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# Install zcomet
ZCOMET_PATH="$HOME/.zcomet/bin/zcomet.zsh"
if [[ ! -f $ZCOMET_PATH ]]; then
  git clone --depth=1 https://github.com/agkozak/zcomet.git $HOME/.zcomet/bin
  # Don't trigger an auto-update during initial installation
  touch $HOME/.zcomet/update
fi

# Load plugins
if [[ -r $ZCOMET_PATH ]]; then
  source $ZCOMET_PATH

  # Automatically update if we haven't run one for a while
  # The `(Nm-7)` is a glob:
  # - `N` makes a missing match expand to nothing instead of the literal pattern
  # - `mw-2` only matches the file if its modification time is within 2 weeks
  ZCOMET_LAST_UPDATE=($HOME/.zcomet/update(Nmw-2))
  if [[ -z $ZCOMET_LAST_UPDATE ]]; then
    zcomet self-update
    zcomet update
    touch $HOME/.zcomet/update
  fi

  zcomet load "agkozak/zsh-z"

  # Make zvm load like other plugins - this avoids issues with pressing up/down to see history
  ZVM_INIT_MODE=sourcing
  zcomet load "jeffreytse/zsh-vi-mode"

  # Must run after compinit but before things like zsh-syntax-highlighting
  # Note: idk what will happen if fzf is not installed
  zcomet load "Aloxaf/fzf-tab"

  # It's important to load this almost-last
  zcomet load "zsh-users/zsh-syntax-highlighting"

  # It's important to load this last
  zcomet load "zsh-users/zsh-autosuggestions"
  ZSH_AUTOSUGGEST_STRATEGY=(completion)
  ZSH_AUTOSUGGEST_USE_ASYNC=true

  # Run compinit and compile its cache
  zcomet compinit
fi

# Enable history-scrolling w/ up/down arrows
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
# It seems there's 2 different chars that up/down keys could send, but binding both seems to work
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search # Up
bindkey "$terminfo[kcud1]" down-line-or-beginning-search # Down

# Enable home/end keys
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line

# Vim-mode settings
KEYTIMEOUT=3
# ZVM settings
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT # Always start in insert mode
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_VI_HIGHLIGHT_BACKGROUND=cyan

# FZF
if command -v rg >/dev/null; then
  # Use rg if available as it's generally faster
  export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
[[ -r $HOME/.fzf.zsh ]] && source $HOME/.fzf.zsh



##############################
# Prompt configuration stuff #
##############################

# Helper to return the current directory or a shorter alternative if possible
# E.g. truncate to start from `~` or the root of the current git repo
short-pwd() {
  local dir=$PWD # Get current dir
  local PROMPT_GIT_DIR=$(git rev-parse --show-toplevel 2>/dev/null) # Get git repo root
  if [[ $PROMPT_GIT_DIR != '' ]]; then
    PROMPT_GIT_DIR="$(dirname $PROMPT_GIT_DIR)/" # Get everything before the git repo root...
    dir=${dir#$PROMPT_GIT_DIR} # ... and trim it off the current dir
  fi
  print -rD "$dir" # print -D converts home dir -> ~
}

# Helper to easily set the tab/window title
# Takes current dir & (optionally) current command
# Inspired by https://github.com/trystan2k/zsh-tab-title
local set-title() {
  if [[ $2 != "" ]]; then
    2=": $2"
  fi
  print -Pn "\e]1;$1$2\a" # Tab title
  print -Pn "\e]2;$1$2\a" # Window title
}

# Will be run before every prompt draw
local prompt_precmd() {
  PROMPT_CMD_STATUS=$? # Save exit code as it may be wiped by the logic below

  set-title "$(short-pwd): zsh"

  if (( ${+PROMPT_CMD_START} )); then
    ((PROMPT_CMD_DURATION = $(date +%s) - PROMPT_CMD_START))
    unset PROMPT_CMD_START
  fi
}
# Will be run before every command is executed
local prompt_preexec() {
  setopt extended_glob

  PROMPT_CMD_START=$(date +%s)

  local cmd=${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}
  set-title "$(short-pwd)" "$cmd"
}
# Create the precmd/preexec arrays if not already set (required for hook-check to work)
(( ! ${+precmd_functions} )) && precmd_functions=()
(( ! ${+preexec_functions} )) && preexec_functions=()
# Hook precmd/preexec functions if not already hooked
[[ -z ${precmd_functions[(re)prompt_precmd]} ]] && precmd_functions+=(prompt_precmd)
[[ -z ${preexec_function[(re)prompt_preexec]} ]] && preexec_functions+=(prompt_preexec)

local set-prompt() {
  local newline=$'\n'
  local character='%F{46}%(!.#.❯)%f '

  # Only render timestamp on subsequent renders
  local timestamp

  # Cache most of the prompt so we don't have to re-calculate it when adding the timestamp
  if [[ -v PROMPT_CACHE ]]; then
    # If the cache already exists, just add the timestamp
    timestamp='%F{245}[%D{%H:%M:%S}]%f '
  else
    local dir="%B%F{51}$(short-pwd)%f%b "

    # TODO: consider changing this to use vcs_info?
    local branch
    local PROMPT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [[ $PROMPT_BRANCH != "" ]]; then
      branch="%B%F{226}$PROMPT_BRANCH%f%b "
    fi

    local venv
    if [[ $VIRTUAL_ENV != "" ]]; then
      venv="%B%F{033}$(basename $VIRTUAL_ENV)%f%b "
    fi

    local exitcode
    if [[ $PROMPT_CMD_STATUS -gt 0 ]]; then
      exitcode="%(?..exit %B%F{160}$PROMPT_CMD_STATUS%f%b )"
    fi

    local duration
    if [[ $PROMPT_CMD_DURATION -ge 2 ]]; then
      # Work out seconds first
      local formatted="$((PROMPT_CMD_DURATION%60))s"
      # Then add the minutes if there are any
      local m=$((PROMPT_CMD_DURATION/60%60))
      [[ $m > 0 ]] && formatted="${m}m $formatted"
      # Then add the hours if there are any
      local h=$((PROMPT_CMD_DURATION/60/60))
      [[ $h > 0 ]] && formatted="${h}h $formatted"
      # Finally, format it nicely
      duration="took %B%F{226}${formatted}%f%b "
    fi

    local jobstring
    local jobcount=$#jobstates
    if [[ $jobcount -gt 0 ]]; then
      jobstring="[%B%F{135}$jobcount%f%b] "
    fi

    PROMPT_CACHE="$dir$branch$venv$exitcode$duration$jobstring"
  fi

  PROMPT="$PROMPT_CACHE$timestamp$newline$character"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd set-prompt

# Redraw the prompt before running a command
local reset-prompt-and-accept-line() {
  # Redraw the prompt to add timestamp
  set-prompt
  zle reset-prompt
  # Clear the cache so the next one draws normally
  unset PROMPT_CACHE

  # Note the . meaning the built-in accept-line
  zle .accept-line
}
# Override the built-in accept-line with our version
zle -N accept-line reset-prompt-and-accept-line
