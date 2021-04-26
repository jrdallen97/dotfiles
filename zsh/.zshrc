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

# Preferred editor
if command -v nvim >/dev/null; then
  export EDITOR='nvim'
  export VISUAL='nvim'
else
  export EDITOR='vim'
  export VISUAL='vim'
fi

# So I don't have to type this crap every damn time
safesource() { [[ -r "$1" ]] && source "$1" }

# Load my aliases (and some functions)
safesource "$HOME/.zsh_aliases"

# Load optional configs
safesource "$HOME/.zshrc.sparx"
# Load local config (useful for storing secrets)
safesource "$HOME/.zshrc.local"

# FZF
if command -v rg >/dev/null; then
  # Use rg if available as it's generally faster
  export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden'
fi
safesource "$HOME/.fzf.zsh"

safesource "$HOME/.zsh/zsh-z/zsh-z.plugin.zsh"

safesource "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

autoload -U compinit && compinit

safesource "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

if command -v starship >/dev/null; then
  eval "$(starship init zsh)"
else
  echo "starship not found, falling back to simple prompt"
fi
