if has brew; then
    export PATH="/usr/local/sbin:$PATH"
    trysource_all "$(brew --prefix)/etc/bash_completion.d"
fi
