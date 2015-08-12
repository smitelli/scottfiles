# ANSI Text Attributes
ANSI_RESET=0
ANSI_BOLD=1
ANSI_ITALIC=3
ANSI_UNDERLINE=4
ANSI_BLINK=5
ANSI_REVERSE=7
ANSI_CONCEAL=8
ANSI_STRIKETHROUGH=9

# ANSI Foreground/Background Bits
ANSI_FG=3
ANSI_BG=4

# ANSI Color Codes
ANSI_BLACK=0
ANSI_RED=1
ANSI_GREEN=2
ANSI_YELLOW=3
ANSI_BLUE=4
ANSI_MAGENTA=5
ANSI_CYAN=6
ANSI_WHITE=7

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
ansicolor() {
    local OPTIND OPTERR key fgcolor bgcolor style="${ANSI_RESET}"

    while getopts 'f:b:BIULRCS' opt
    do
        case "${opt}" in
            f)
                key="ANSI_${OPTARG}"
                [[ -n "${!key}" ]] && fgcolor="${ANSI_FG}${!key}"
                ;;
            b)
                key="ANSI_${OPTARG}"
                [[ -n "${!key}" ]] && bgcolor="${ANSI_BG}${!key}"
                ;;
            B)
                style="${ANSI_BOLD}"
                ;;
            I)
                style="${ANSI_ITALIC}"
                ;;
            U)
                style="${ANSI_UNDERLINE}"
                ;;
            L)
                style="${ANSI_BLINK}"
                ;;
            R)
                style="${ANSI_REVERSE}"
                ;;
            C)
                style="${ANSI_CONCEAL}"
                ;;
            S)
                style="${ANSI_STRIKETHROUGH}"
                ;;
        esac
    done

    printf "${style}${fgcolor:+;${fgcolor}}${bgcolor:+;${bgcolor}}"
}

# Wraps ansicolor() but outputs the necessary control characters to make the
# terminal actually change the color.
termcolor() {
    printf "\033[$(ansicolor ${@})m"
}

# Foreground colors on a default background.
COLOR_NC=$(termcolor)
COLOR_BLACK=$(termcolor -f BLACK)
COLOR_RED=$(termcolor -f RED)
COLOR_GREEN=$(termcolor -f GREEN)
COLOR_YELLOW=$(termcolor -f YELLOW)
COLOR_BLUE=$(termcolor -f BLUE)
COLOR_MAGENTA=$(termcolor -f MAGENTA)
COLOR_CYAN=$(termcolor -f CYAN)
COLOR_WHITE=$(termcolor -f WHITE)

# Bold foreground colors on a default background.
COLOR_BOLD_NC=$(termcolor -B)
COLOR_BOLD_BLACK=$(termcolor -B -f BLACK)
COLOR_BOLD_RED=$(termcolor -B -f RED)
COLOR_BOLD_GREEN=$(termcolor -B -f GREEN)
COLOR_BOLD_YELLOW=$(termcolor -B -f YELLOW)
COLOR_BOLD_BLUE=$(termcolor -B -f BLUE)
COLOR_BOLD_MAGENTA=$(termcolor -B -f MAGENTA)
COLOR_BOLD_CYAN=$(termcolor -B -f CYAN)
COLOR_BOLD_WHITE=$(termcolor -B -f WHITE)

# Test function that loops over every defined variable name that starts with a
# 'COLOR_' prefix and prints formatted sample text to the terminal.
colors() {
    local color

    for color in ${!COLOR_*}
    do
        echo -e "${!color}${color}${COLOR_NC}"
    done
}

export CLICOLOR=1

# Colors for ls
if $(ls --color >/dev/null 2>&1)
then
    # For non-OS X
    local dircolors_file="${HOME}/.dircolors/dircolors-solarized/dircolors.ansi-universal"

    if (has dircolors && [[ -f "${dircolors_file}" && -r "${dircolors_file}" ]])
    then
        eval $(dircolors "${dircolors_file}")
    fi

    alias ls='ls --color=auto'
else
    # For OS X -- A cheap approximation
    # https://github.com/seebi/dircolors-solarized/issues/10
    export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
fi

# Colors for grep
export GREP_COLOR=$(ansicolor -f GREEN)  # For OS X
export GREP_COLORS="fn=$(ansicolor -B -f CYAN):ln=$(ansicolor -f CYAN):mt=${GREP_COLOR}"  # For non-OS X
alias grep='grep --color=auto'

# Colors for less
export LESS_TERMCAP_mb=$(termcolor -L -f RED)  # Blink
export LESS_TERMCAP_md=$COLOR_BOLD_CYAN  # Bold
export LESS_TERMCAP_so=$(termcolor -B -f BLACK -b CYAN)  # Standout
export LESS_TERMCAP_us=$(termcolor -U -f GREEN)  # Underline
export LESS_TERMCAP_me=$COLOR_NC  # End appearance mode
export LESS_TERMCAP_se=$COLOR_NC  # End standout
export LESS_TERMCAP_ue=$COLOR_NC  # End underline
