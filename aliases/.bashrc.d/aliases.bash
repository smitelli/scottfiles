# One-word update of the scottfiles.
if has git; then
    alias scottpull="pushd ${HOME}/.scottfiles; git pull; popd; exec bash"
fi

# Aliases for ls, distilled from a whole slew of Linux distros.
alias ll='ls -al'
alias la='ls -A'
alias l='ls -C'

# Wrapper for my preferred invocation of youtube-dl/yt-dlp.
if has youtube-dl; then
    alias ytdl='youtube-dl -o "%(uploader)s - %(title)s.%(ext)s"'
    alias ytdl2='youtube-dl -o "%(uploader)s - %(title)s [%(id)s].%(ext)s"'
elif has yt-dlp; then
    alias ytdl='yt-dlp -o "%(uploader)s - %(title).150s.%(ext)s"'
    alias ytdl2='yt-dlp -o "%(uploader)s - %(title).150s [%(id)s].%(ext)s"'
fi

if has kubectl; then
    # Why this isn't the default (or at least made quicker to type) is beyond me
    alias kevents="kubectl get events --sort-by='.lastTimestamp'"
    alias kdrain="kubectl drain --delete-emptydir-data --ignore-daemonsets"
fi

# Lossless in-place rotation of all image/video files supported by exiftool.
# Usage: rotate_[c]cw <filename>
# CCW = counterclockwise in 90 degree steps, CW = clockwise.
if has exiftool; then
    rotate_ccw() {
        case $(exiftool -Rotation "$1" | grep -Eo '[0-9]+') in
            0)   rot=90  ;;
            90)  rot=180 ;;
            180) rot=270 ;;
            270) rot=0   ;;
            *)
                echo "$FUNCNAME: Could not parse EXIF Rotation tag from \"$1\"" >&2
                return 1
                ;;
        esac

        exiftool -ignoreMinorErrors -overwrite_original -preserve -Rotation=$rot "$1"
    }

    rotate_cw() {
        case $(exiftool -Rotation "$1" | grep -Eo '[0-9]+') in
            0)   rot=270 ;;
            90)  rot=0   ;;
            180) rot=90  ;;
            270) rot=180 ;;
            *)
                echo "$FUNCNAME: Could not parse EXIF Rotation tag from \"$1\"" >&2
                return 1
                ;;
        esac

        exiftool -ignoreMinorErrors -overwrite_original -preserve -Rotation=$rot "$1"
    }
fi


# Handy JSON-formatting tool for when HTTPie is not available. Passes all args
# directly into a "silent" curl and prints human-formatted JSON to stdout.
jcurl() {
    curl -s "$@" | python -m json.tool
}

# Start a web server whose document root is the current working directory. Use
# `serve 3333` to serve on port 3333 instead of the built-in default. ^C quits.
serve() {
    if has python3; then
        python3 -m http.server --bind 0.0.0.0 "$@"
    else
        python -m SimpleHTTPServer "$@"
    fi
}

# Forcibly stop and remove every container, volume, image, network, and cached
# item it holds. This is a terribly destructive "burn down the world" function
# that should only be used when it is actually desired to burn down the world.
has docker && docker-zap () {
    containers=$(docker ps --all --quiet)
    if [ -n "$containers" ]; then
        docker stop "$containers"
    fi

    docker system prune --all --volumes
}

# Find all files in the directory named by the first argument, or the cwd if
# there are no arguments, and play each file in an mplayer playlist.
has mplayer && mplayall() {
    local dname

    if [[ "$1" != "" ]]; then
        dname=$(cd "$1"; pwd)
    else
        dname=$(pwd)
    fi

    mplayer -playlist <(find "$dname" -type f)
}
