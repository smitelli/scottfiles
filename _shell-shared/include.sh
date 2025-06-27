#
# FILE INCLUSION FUCTIONS
#
# Shared between bash and zsh
#

# Tests to see if the shell recognizes the provided name(s) as an executable
# binary, script, builtin, etc. Returns 0 if the name(s) exist, 1 otherwise.
has() {
    hash "$@" >/dev/null 2>&1
}

# Tests to see if the shell recognizes the provided name(s) as an alias. Returns
# 0 if the name(s) exist, 1 otherwise.
has_alias() {
    alias "$@" > /dev/null 2>&1
}

# Checks if the provided filename exists, and if so, sources it. If the filename
# does not exist or is unreadable, it returns non-zero and does nothing. The
# sourced script may return any value it wants.
trysource() {
    [[ -n "${SCOTTFILES_DEBUG}" ]] && printf 'trysource %s...' "$1"
    local fname="$1"

    [[ -f "${fname}" && -r "${fname}" ]] && . "${fname}"
    [[ -n "${SCOTTFILES_DEBUG}" ]] && printf ' done.\n'
}

# Checks if the provided directory exists, and if so, sources every file
# contained in that directory. If the directory does not exist or is unreadable,
# it returns non-zero and does nothing. The sourced script(s) may return any
# values they want.
trysource_all() {
    local dname="$1" fname

    if [[ -d "${dname}" && -r "${dname}" && -x "${dname}" ]]; then
        for fname in "${dname}"/*; do
            trysource "${fname}"
        done
    else
        return 1
    fi
}
