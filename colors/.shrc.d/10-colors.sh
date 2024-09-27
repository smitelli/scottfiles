# shellcheck disable=SC2155

# ANSI Text Attributes
export ANSI_RESET=0
export ANSI_BOLD=1
export ANSI_ITALIC=3
export ANSI_UNDERLINE=4
export ANSI_BLINK=5
export ANSI_REVERSE=7
export ANSI_CONCEAL=8
export ANSI_STRIKETHROUGH=9

# ANSI Foreground/Background Bits
export ANSI_FG=3
export ANSI_BG=4

# ANSI Color Codes
export ANSI_BLACK=0
export ANSI_RED=1
export ANSI_GREEN=2
export ANSI_YELLOW=3
export ANSI_BLUE=4
export ANSI_MAGENTA=5
export ANSI_CYAN=6
export ANSI_WHITE=7

# Converts a series of options to an ANSI color code.
#   -f <color>
#         Set the foreground color. <color> should be one of BLACK, RED, GREEN,
#         YELLOW, BLUE, MAGENTA, CYAN, or WHITE.
#   -b <color>
#         Set the background color. Takes the same values as -f.
#   -B    Use a bold font.
#   -I    Use an italic font.
#   -U    Use an underlined font.
#   -L    Blink the text.
#   -R    Reverse the foreground and background colors.
#   -C    Conceal the text. It will occupy space, but not be visible.
#   -S    Add a strikethrough line to the text.
# NOTE: Combining more than one text attribute is not yet supported. Only the
# last one will apply.
ansicolor() {
    local color fgcolor bgcolor style="${ANSI_RESET}"

    while getopts 'f:b:BIULRCS' opt; do
        case "${opt}" in
            f)
                eval color="\$ANSI_${OPTARG}"
                [[ -n "${color}" ]] && fgcolor="${ANSI_FG}${color}"
                ;;
            b)
                eval color="\$ANSI_${OPTARG}"
                [[ -n "${color}" ]] && bgcolor="${ANSI_BG}${color}"
                ;;
            B) style="${ANSI_BOLD}";;
            I) style="${ANSI_ITALIC}";;
            U) style="${ANSI_UNDERLINE}";;
            L) style="${ANSI_BLINK}";;
            R) style="${ANSI_REVERSE}";;
            C) style="${ANSI_CONCEAL}";;
            S) style="${ANSI_STRIKETHROUGH}";;
            *) ;;
        esac
    done

    printf '%s%s%s' "${style}" "${fgcolor:+;${fgcolor}}" "${bgcolor:+;${bgcolor}}"
}

# Wraps ansicolor() but outputs the necessary control characters to make the
# terminal actually change the color.
termcolor() {
    printf '\033[%sm' "$(ansicolor "${@}")"
}

# Foreground colors on a default background.
export COLOR_NC="$(termcolor || true)"
export COLOR_BLACK="$(termcolor -f BLACK)"
export COLOR_RED="$(termcolor -f RED)"
export COLOR_GREEN="$(termcolor -f GREEN)"
export COLOR_YELLOW="$(termcolor -f YELLOW)"
export COLOR_BLUE="$(termcolor -f BLUE)"
export COLOR_MAGENTA="$(termcolor -f MAGENTA)"
export COLOR_CYAN="$(termcolor -f CYAN)"
export COLOR_WHITE="$(termcolor -f WHITE)"

# Bold foreground colors on a default background.
export COLOR_BOLD_NC="$(termcolor -B)"
export COLOR_BOLD_BLACK="$(termcolor -B -f BLACK)"
export COLOR_BOLD_RED="$(termcolor -B -f RED)"
export COLOR_BOLD_GREEN="$(termcolor -B -f GREEN)"
export COLOR_BOLD_YELLOW="$(termcolor -B -f YELLOW)"
export COLOR_BOLD_BLUE="$(termcolor -B -f BLUE)"
export COLOR_BOLD_MAGENTA="$(termcolor -B -f MAGENTA)"
export COLOR_BOLD_CYAN="$(termcolor -B -f CYAN)"
export COLOR_BOLD_WHITE="$(termcolor -B -f WHITE)"

# Test function that loops over every defined variable name that starts with a
# 'COLOR_' prefix and prints formatted sample text to the terminal.
colors() {
    local color

    if [[ -n "${BASH_VERSION}" ]]; then
        for color in ${!COLOR_*}; do
            printf '%s%s%s\n' "${!color}" "${color}" "${COLOR_NC}"
        done
    elif [[ -n "${ZSH_VERSION}" ]]; then
        for name in $(typeset +m 'COLOR_*'); do
            eval color="\$${name}"
            printf '%s%s%s\n' "${color}" "${name}" "${COLOR_NC}"
        done
    else
        echo 'This function is not implemented for the current shell.'
        exit 1
    fi
}

export CLICOLOR=1

# Colors for grep
export GREP_COLOR="$(ansicolor -f GREEN)"  # For OS X
export GREP_COLORS="fn=$(ansicolor -B -f CYAN):ln=$(ansicolor -f CYAN):mt=${GREP_COLOR}"  # For non-OS X
alias grep='grep --color=auto'

# Colors for less
export LESS_TERMCAP_mb="$(termcolor -L -f RED)"  # Blink
export LESS_TERMCAP_md="${COLOR_BOLD_CYAN}"  # Bold
export LESS_TERMCAP_so="$(termcolor -B -f BLACK -b CYAN)"  # Standout
export LESS_TERMCAP_us="$(termcolor -U -f GREEN)"  # Underline
export LESS_TERMCAP_me="${COLOR_NC}"  # End appearance mode
export LESS_TERMCAP_se="${COLOR_NC}"  # End standout
export LESS_TERMCAP_ue="${COLOR_NC}"  # End underline

# Colors for ls
if ls --color > /dev/null 2>&1; then
    # For all systems except old OS X
    # For current macOS, install GNU coreutils to get gdircolors command
    local dircolors_file="${HOME}/.dircolors/dircolors-solarized/dircolors.ansi-universal"

    if [[ -f "${dircolors_file}" && -r "${dircolors_file}" ]]; then
        if has dircolors; then
            eval "$(dircolors "${dircolors_file}")"
        elif has gdircolors; then
            eval "$(gdircolors "${dircolors_file}")"
        else
            [[ -n "${SCOTTFILES_DEBUG}" ]] && echo 'No dircolors on $PATH; not setting LS_COLORS'
        fi
    fi

    alias ls='ls --color=auto'
else
    # For old OS X -- A cheap approximation
    # https://github.com/seebi/dircolors-solarized/issues/10
    export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
fi
