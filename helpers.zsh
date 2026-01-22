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
