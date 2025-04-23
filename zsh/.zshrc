# PATH
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/go/bin

# Turn on zsh history file
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY # Use the timestamp format
setopt INC_APPEND_HISTORY_TIME # Add new lines when they are run, but ensure the timing works
setopt HIST_IGNORE_SPACE # Ignore lines starting with a space
setopt HIST_IGNORE_DUPS # Don't log subsequent identical lines

# cd settings (e.g. history)
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

# Install zplug if it's not installed by default
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

# zplug plugin setup
if [[ -r ~/.zplug/init.zsh ]]; then
  source ~/.zplug/init.zsh

  zplug "agkozak/zsh-z"

  zplug "zsh-users/zsh-autosuggestions"
  ZSH_AUTOSUGGEST_STRATEGY=(completion)
  ZSH_AUTOSUGGEST_USE_ASYNC=true

  ZVM_INIT_MODE=sourcing # Make zvm load like other plugins
  zplug "jeffreytse/zsh-vi-mode", defer:2

  # Must run after compinit but before things like zsh-syntax-highlighting
  # Note: idk what will happen if fzf is not installed
  zplug "Aloxaf/fzf-tab", defer:2

  # zsh-syntax-highlighting must be loaded after executing compinit command and sourcing other plugins
  # a defer tag >= 2 will run after compinit command
  zplug "zsh-users/zsh-syntax-highlighting", defer:3

  # Install plugins if there are plugins that have not been installed
  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi

  zplug load
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
[[ -r ~/.fzf.zsh ]] && source ~/.fzf.zsh



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
prompt_precmd() {
  PROMPT_CMD_STATUS=$? # Save exit code as it may be wiped by the logic below

  set-title "$(short-pwd): zsh"

  if (( ${+PROMPT_CMD_START} )); then
    ((PROMPT_CMD_DURATION = $(date +%s) - PROMPT_CMD_START))
    unset PROMPT_CMD_START
  fi
}
# Will be run before every command is executed
prompt_preexec() {
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

set-prompt() {
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

  local newline=$'\n'
  local character='%F{46}%(!.#.❯)%f '

  PROMPT="$dir$branch$venv$exitcode$duration$jobstring$newline$character"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd set-prompt
