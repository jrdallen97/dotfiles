# PATH
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/go/bin

# Turn on zsh history file
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY # Use the timestamp format
setopt INC_APPEND_HISTORY_TIME # Add new lines when they are run, but ensure the timing works
setopt HIST_IGNORE_SPACE # Ignore lines starting with a space
setopt HIST_IGNORE_DUPS # Don't log subsequent identical lines

# Preferred editor
if command -v nvim >/dev/null; then
  export EDITOR='nvim'
  export VISUAL='nvim'
else
  export EDITOR='vim'
  export VISUAL='vim'
fi

# Load my aliases (and some functions)
[[ -r "$HOME/.zsh_aliases" ]] && source "$HOME/.zsh_aliases"
# Load optional configs
[[ -r "$HOME/.zshrc.sparx" ]] && source "$HOME/.zshrc.sparx"
# Load local config (useful for storing secrets)
[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# zplug plugin setup
if [[ -r ~/.zplug/init.zsh ]]; then
  source ~/.zplug/init.zsh

  zplug "agkozak/zsh-z"
  zplug "zsh-users/zsh-autosuggestions"
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  ZSH_AUTOSUGGEST_USE_ASYNC=true

  zplug "softmoth/zsh-vim-mode"

  # zsh-syntax-highlighting must be loaded after executing compinit command and sourcing other plugins
  # a defer tag >= 2 will run after compinit command
  zplug "zsh-users/zsh-syntax-highlighting", defer:2

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
MODE_CURSOR_VIINS="#00ff00 blinking bar"
MODE_CURSOR_REPLACE="$MODE_CURSOR_VIINS #ff0000"
MODE_CURSOR_VICMD="green block"
MODE_CURSOR_SEARCH="#ff00ff steady underline"
MODE_CURSOR_VISUAL="$MODE_CURSOR_VICMD steady bar"
MODE_CURSOR_VLINE="$MODE_CURSOR_VISUAL #00ffff"

# FZF
if command -v rg >/dev/null; then
  # Use rg if available as it's generally faster
  export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden'
fi
[[ -r ~/.fzf.zsh ]] && source ~/.fzf.zsh

# Will be run before every prompt draw
prompt_precmd() {
  PROMPT_CMD_STATUS=$? # Save exit code as it may be wiped by the logic below

  if (( ${+PROMPT_CMD_START} )); then
    ((PROMPT_CMD_DURATION = $(date +%s) - PROMPT_CMD_START))
    unset PROMPT_CMD_START
  fi
}
prompt_preexec() { PROMPT_CMD_START=$(date +%s); }
# Create the precmd/preexec arrays if not already set (required for hook-check to work)
(( ! ${+precmd_functions} )) && precmd_functions=()
(( ! ${+preexec_functions} )) && preexec_functions=()
# Hook prompt precmd/preexec functions if not already hooked
[[ -z ${precmd_functions[(re)prompt_precmd]} ]] && precmd_functions+=(prompt_precmd)
[[ -z ${preexec_function[(re)prompt_preexec]} ]] && preexec_functions+=(prompt_preexec)

function set-prompt() {
  local dir="%B%F{51}%~%f%b "

  # TODO: consider changing this to use vcs_info?
  local branch
  local PROMPT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ $PROMPT_BRANCH != "" ]]; then
    branch="%B%F{226}$PROMPT_BRANCH%f%b "
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
    local m=$((PROMPT_CMD_DURATION/60))
    [[ $m > 0 ]] && formatted="${m}m $formatted"
    # Then add the hours if there are any
    local h=$((PROMPT_CMD_DURATION/60/60))
    [[ $h > 0 ]] && formatted="${h}h $formatted"
    # Finally, format it nicely
    duration="took %B%F{226}${formatted}%f%b "
  fi

  local newline=$'\n'
  local character='%F{46}%(!.#.❯)%f '

  PROMPT="$dir$branch$exitcode$duration$newline$character"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd set-prompt
