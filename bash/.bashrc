# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

has() {
    hash "$@" &>/dev/null
}

trysource() {
    local fname="$1"

    [[ -f "$fname" && -r "$fname" ]] && . "$fname"
}

trysource_all() {
    local dname="$1"

    if [[ -d "$dname" && -r "$dname" && -x "$dname" ]]
    then
        for fname in "$dname"/*
        do
            trysource "$fname"
        done
    fi
}

if [ -f /etc/bashrc ]
then
    . /etc/bashrc
fi

trysource_all "${HOME}/.bashrc.d"
