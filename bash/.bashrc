# Uncomment the following line if there is any question about what's going on.
# SCOTTFILES_DEBUG=1

# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return;;
esac

# Tests to see if the shell recognizes the provided name(s) as an executable
# binary, script, builtin, etc. Returns 0 if the name(s) exist, 1 otherwise.
has() {
    hash "$@" &>/dev/null
}

# Checks if the provided filename exists, and if so, sources it. If the filename
# does not exist or is unreadable, it returns non-zero and does nothing. The
# sourced script may return any value it wants.
trysource() {
    [[ -n "$SCOTTFILES_DEBUG" ]] && echo -n "trysource $1..."
    local fname="$1"

    [[ -f "$fname" && -r "$fname" ]] && . "$fname"
    [[ -n "$SCOTTFILES_DEBUG" ]] && echo ' done.'
}

# Checks if the provided directory exists, and if so, sources every file
# contained in that directory. If the directory does not exist or is unreadable,
# it returns non-zero and does nothing. The sourced script(s) may return any
# values they want.
trysource_all() {
    local dname="$1" fname

    if [[ -d "$dname" && -r "$dname" && -x "$dname" ]]; then
        for fname in "$dname"/*; do
            trysource "$fname"
        done
    else
        return 1
    fi
}

# If there is a system-wide bashrc file, source it first.
trysource /etc/bashrc

# Source everything in the bashrc directory, then we're done!
trysource_all "${HOME}/.bashrc.d"
