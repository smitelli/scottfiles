# One-word update of the scottfiles.
alias scottpull="pushd ${HOME}/.scottfiles; git pull; popd; exec bash"

# Aliases for ls, distilled from a whole slew of Linux distros.
alias ll='ls -al'
alias la='ls -A'
alias l='ls -C'

# Handy JSON-formatting tool for when HTTPie is not available. Passes all args
# directly into a "silent" curl and prints human-formatted JSON to stdout.
jcurl() {
    curl -s "$@" | python -m json.tool
}

# Start a web server whose document root is the current working directory. Use
# `serve 3333` to serve on port 3333 instead of the built-in default. ^C quits.
serve() {
    python -m SimpleHTTPServer "$@"
}

# Find all files in the directory named by the first argument, or the cwd if
# there are no arguments, and play each file in an mplayer playlist.
mplayall() {
    local dname

    if [[ "$1" != "" ]]; then
        dname=$(cd "$1"; pwd)
    else
        dname=$(pwd)
    fi

    mplayer -playlist <(find "$dname" -type f)
}
