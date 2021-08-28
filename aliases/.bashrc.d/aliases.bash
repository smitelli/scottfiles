# One-word update of the scottfiles.
if has git; then
    alias scottpull="pushd ${HOME}/.scottfiles; git pull; popd; exec bash"
fi

# Aliases for ls, distilled from a whole slew of Linux distros.
alias ll='ls -al'
alias la='ls -A'
alias l='ls -C'

# Wrapper for my preferred invocation of youtube-dl/yt-dlp
if has youtube-dl; then
    alias ytdl='youtube-dl -o "%(uploader)s - %(title)s.%(ext)s"'
    alias ytdl2='youtube-dl -o "%(uploader)s - %(title)s [%(id)s].%(ext)s"'
elif has yt-dlp; then
    alias ytdl='yt-dlp -o "%(uploader)s - %(title)s.%(ext)s"'
    alias ytdl2='yt-dlp -o "%(uploader)s - %(title)s [%(id)s].%(ext)s"'
fi

# Handy JSON-formatting tool for when HTTPie is not available. Passes all args
# directly into a "silent" curl and prints human-formatted JSON to stdout.
jcurl() {
    curl -s "$@" | python -m json.tool
}

# Start a web server whose document root is the current working directory. Use
# `serve 3333` to serve on port 3333 instead of the built-in default. ^C quits.
serve() {
    if $(has python3); then
        python3 -m http.server --bind 0.0.0.0 "$@"
    else
        python -m SimpleHTTPServer "$@"
    fi
}

# Find all files in the directory named by the first argument, or the cwd if
# there are no arguments, and play each file in an mplayer playlist.
$(has mplayer) && mplayall() {
    local dname

    if [[ "$1" != "" ]]; then
        dname=$(cd "$1"; pwd)
    else
        dname=$(pwd)
    fi

    mplayer -playlist <(find "$dname" -type f)
}
