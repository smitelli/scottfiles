if has brew; then
    eval "$(brew shellenv)"

    # https://docs.brew.sh/Analytics
    export HOMEBREW_NO_ANALYTICS=1
fi
