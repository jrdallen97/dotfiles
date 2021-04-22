# PATH
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/go/bin

# Prompt
PROMPT='%F{208}%n%f %F{226}%~%f $ '

# Preferred editor
if command -v nvim >/dev/null; then
  export EDITOR='nvim'
  export VISUAL='nvim'
else
  export EDITOR='vim'
  export VISUAL='vim'
fi

# My aliases
if test -f "$HOME/aliases.zsh"; then
  source "$HOME/aliases.zsh"
else
  echo 'Failed loading aliases'
fi

# Load optional configs
test -f "$HOME/.zshrc.sparx" && source "$HOME/.zshrc.sparx"
# Load local config (useful for storing secrets)
test -f "$HOME/.zshrc.local" && source "$HOME/.zshrc.local"

# FZF
if command -v rg >/dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden'
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
