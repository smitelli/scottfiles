if has brew; then
    eval "$(brew shellenv)"

    # https://docs.brew.sh/Analytics
    export HOMEBREW_NO_ANALYTICS=1

    # https://docs.brew.sh/Shell-Completion
    if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
        source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    else
        for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
            [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
        done
    fi
fi
