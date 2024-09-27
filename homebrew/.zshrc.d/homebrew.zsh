if has brew; then
    # https://docs.brew.sh/Shell-Completion
    FPATH="${HOMEBREW_PREFIX}/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
fi
