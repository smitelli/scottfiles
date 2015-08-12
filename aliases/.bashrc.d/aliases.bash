# One-word update of the scottfiles
alias scottpull="pushd ${HOME}/.scottfiles; git pull; popd"

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
