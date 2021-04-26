# PATH
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/go/bin

# Set a basic prompt in case the fancy prompt doesn't work
PROMPT='%F{red}%n%f %F{yellow}%~%f [%?] $ '

# Turn on zsh history file
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY # Use the timestamp format
setopt INC_APPEND_HISTORY_TIME # Add new lines when they are run, but ensure the timing works
setopt HIST_IGNORE_SPACE # Ignore lines starting with a space

# Enable history-scrolling w/ up/down arrows
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Enable home/end keys
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line

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

  zplug "zsh-users/zsh-autosuggestions"
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  ZSH_AUTOSUGGEST_USE_ASYNC=true

  zplug "agkozak/zsh-z"

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

# FZF
if command -v rg >/dev/null; then
  # Use rg if available as it's generally faster
  export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden'
fi
[[ -r ~/.fzf.zsh ]] && source ~/.fzf.zsh

if command -v starship >/dev/null; then
  eval "$(starship init zsh)"
else
  echo "starship not found, falling back to simple prompt"
fi
