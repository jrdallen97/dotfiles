alias vim='nvim'
alias v='nvim .'
alias :q='exit'

# Common command shortcuts
alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias ls='ls -G'
alias lsa='ls -lah'
alias md='mkdir -p'
mcd() { mkdir -p $1 && cd $1 }

# Git
git_current_branch() {
  git rev-parse --abbrev-ref HEAD
}
git_default_branch() {
  git symbolic-ref refs/remotes/origin/HEAD | sed 's|^refs/remotes/origin/||'
}
alias ga='git add'
alias gaa='git add --all'
alias gap='git add --patch'
alias gb='git branch'
alias gbD='git branch -D'
alias gbd='git branch -d'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcb='git checkout -b'
alias gcd='git checkout $(git_default_branch)'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gdca='git diff --cached'
alias gf='git fetch'
alias gignore='git update-index --assume-unchanged'
alias gl='git pull'
alias glg='git log --stat'
alias glgo='git log --oneline --decorate'
alias gm='git merge'
alias gm='git merge'
alias gp='git push'
alias gpsup='git push -u origin $(git_current_branch)'
alias gst='git status'
alias gunignore='git update-index --no-assume-unchanged'

# Silly helpers
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
