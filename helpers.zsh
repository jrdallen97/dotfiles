CONFIG_DIR=${XDG_CONFIG_HOME:=$HOME/.config}

link_file () {
  dotfile="$1"
  target="$2"

  if [[ ! -e $target || $FORCE -eq 1 ]]; then
    ln -sfnv "$dotfile" "$target"
  else
    echo "$target already exists, skipping..."
  fi
}

link_to_home() {
  link_file "${DOTFILES}/${1}" "${HOME}/${2}"
}

link_to_config() {
  link_file "${DOTFILES}/${1}" "${CONFIG_DIR}/${2}"
}

pull_repo() {
  REPO="$1"
  DIR="$2"

  if [[ $FORCE == 1 && -e "$DIR" ]]; then
    echo "$DIR found, removing..."
    rm -rf "$DIR"
  fi

  if [[ ! -e "$DIR" ]]; then
    echo "$DIR not found, installing..."
    git clone --depth 1 "$REPO" "$DIR"
  elif [[ -d "$DIR" ]]; then
    echo "$DIR found, updating..."
    (cd "$DIR" && git pull)
  fi
}

