if has vim; then
    EDITOR=$(which vim)
else
    EDITOR=$(which vi)
fi

export EDITOR
export GIT_EDITOR=$EDITOR
