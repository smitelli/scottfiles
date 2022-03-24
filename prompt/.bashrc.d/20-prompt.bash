_prompt_color() {
    local color="${1}"; shift

    echo "\[${!color}\]${@}\[${COLOR_NC}\]"
}

color_prompt() {
    local usercolor hostcolor user host path symbol

    if [[ $EUID -eq 0 ]]; then
        usercolor=$COLOR_RED
        symbol='#'
    else
        usercolor=$COLOR_GREEN
        symbol='$'
    fi

    hostcolor=${HOSTNAME_COLOR:-$COLOR_GREEN}

    user=$(_prompt_color usercolor '\u')
    host=$(_prompt_color hostcolor '\h')
    path=$(_prompt_color COLOR_CYAN '\W')

    echo "[${user}@${host}:${path}]${symbol}"
}

plain_prompt() {
    local symbol

    if [[ $EUID -eq 0 ]]; then
        symbol='#'
    else
        symbol='$'
    fi

    echo "[\u@\h:\W]${symbol}"
}

if [[ "$CLICOLOR" -eq 1 ]]; then
    export PS1="$(color_prompt) "
else
    export PS1="$(plain_prompt) "
fi
