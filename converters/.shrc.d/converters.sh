# Percent-encodes the first argument according to RFC 3986. All characters
# except 0-9, A-Z, a-z, and -._~ are encoded.
rawurlencode() {
    local c LANG=C arg="$1" i=0
    while [ "$i" -lt "${#arg}" ]; do
        c=${arg:$i:1}
        if echo "$c" | grep -q '[0-9A-Za-z\-\._~]'; then
            printf '%s' "$c"
        else
            printf "%%%X" "'$c'"
        fi
        i=$((i+1))
    done
    echo
}

# Wraps a call to rawurlencode(), but additionally percent-escapes tilde (~) to
# the percent-encoded equivalent. More significantly, uses the application/
# x-www-form-urlencoded convention of plus signs (+) to represent spaces.
urlencode() {
    local arg="$1"

    arg=$(rawurlencode "${arg}")
    arg=$(echo "${arg}" | sed "s/~/%7E/g")
    arg=$(echo "${arg}" | sed "s/%20/+/g")

    echo "${arg}"
}

# Decodes any percent-encoded characters in the first argument. Can fully decode
# an RFC 3986 string, plus any additional characters that may have been
# erroneously encoded.
rawurldecode() {
    local b c LANG=C arg="$1" i=0

    if [[ -n "${ZSH_VERSION}" ]]; then
        b=1
    else
        b=0
    fi

    while [ "$i" -lt "${#arg}" ]; do
        c[b+0]=${arg:$i:1}
        if [ "_${c[b+0]}_" = "_%_" ]; then
            c[b+1]=${arg:$((i+1)):1}
            c[b+2]=${arg:$((i+2)):1}
            # shellcheck disable=SC2059
            printf "\x${c[b+1]}${c[b+2]}"
            i=$((i+3))
        else
            printf '%s' "${c[b+0]}"
            i=$((i+1))
        fi
    done
    echo
}

# Wraps a call to rawurldecode(), but additionally decodes plus signs (+) to
# space characters. This reverses application/x-www-form-urlencoded messages.
urldecode() {
    local arg="$1"

    arg=$(echo "${arg}" | tr "+" " ")

    rawurldecode "${arg}"
}

# Converts the first argument from an 'rgb(11, 22, 33)' color format into a
# '#0B1621' color format. No sanity checking is performed, so ensure that the
# input values are 0 <= channel <= 255. Quote the argument!
rgb2hex() {
    perl -e '
        (shift @ARGV) =~
            /rgb\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)/ &&
                printf "#%02X%02X%02X\n", $1, $2, $3
    ' "${@}"
}

# Converts the first argument from a '#63584D' or '63584D' color format into an
# 'rgb(99, 88, 77)' color format. The leading number sign is optional.
hex2rgb() {
    perl -e '
        (shift @ARGV) =~
            /#?([[:xdigit:]]{2})([[:xdigit:]]{2})([[:xdigit:]]{2})/ &&
                printf "rgb(%d, %d, %d)\n", hex($1), hex($2), hex($3)
    ' "${@}"
}
