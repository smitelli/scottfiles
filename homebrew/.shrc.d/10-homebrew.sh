if [ -f /opt/homebrew/bin/brew ]; then
    # Apple Silicon
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif  [ -f /usr/local/bin/brew ]; then
    # Intel
    eval "$(/usr/local/bin/brew shellenv)"
fi

if has brew; then
    # https://docs.brew.sh/Analytics
    export HOMEBREW_NO_ANALYTICS=1
fi
