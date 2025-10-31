_ps1_host_color() {
    local color

    case "$(hostname -f)" in
        alala*)
            color="${COLOR_RED}";;
        blunderbuss*|pepperbox*|triton*)
            color="${COLOR_GREEN}";;
        scotts-mbp*)
            color="${COLOR_MAGENTA}";;
        *)
            color="${COLOR_YELLOW}";;
    esac

    printf '%s' "${color}"
}

_ps1_user_color() {
    local color

    case "${USER}" in
        ssmitelli)
            color="${COLOR_GREEN}";;
        scotts)
            color="${COLOR_MAGENTA}";;
        *)
            color="${COLOR_YELLOW}";;
    esac

    if [[ $EUID -eq 0 ]]; then
        color="${COLOR_RED}"
    fi

    printf '%s' "${color}"
}
