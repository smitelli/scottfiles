if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"

    export HOMEBREW_NO_ANALYTICS=1

    trysource_all "$(brew --prefix)/etc/bash_completion.d"
fi
