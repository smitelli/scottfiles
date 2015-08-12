# Percent-encodes the first argument according to RFC 3986. All characters
# except 0-9, A-Z, a-z, and -._~ are encoded.
urlencode() {
    local c LANG=C arg="$1" i=0
    while [ "$i" -lt "${#arg}" ]; do
        c=${arg:$i:1}
        if echo "$c" | grep -q '[0-9A-Za-z\-\._~]'; then
            printf "$c"
        else
            printf "%%%X" "'$c'"
        fi
        i=$((i+1))
    done
}

# Decodes any percent-encoded characters in the first argument. Can fully decode
# an RFC 3986 string, plus any additional characters that may have been
# erroneously encoded.
urldecode() {
    local c LANG=C arg="$1" i=0
    while [ "$i" -lt "${#arg}" ]; do
        c[0]=${arg:$i:1}
        if [ "_${c[0]}_" = "_%_" ]; then
            c[1]=${arg:$((i+1)):1}
            c[2]=${arg:$((i+2)):1}
            printf "\x${c[1]}${c[2]}"
            i=$((i+3))
        else
            printf "${c[0]}"
            i=$((i+1))
        fi
    done
}

# Converts the first argument from an 'rgb(11, 22, 33)' color format into a
# '#0B1621' color format. No sanity checking is performed, so ensure that the
# input values are 0 <= channel <= 255.
rgb2hex() {
    perl -e '
        (shift @ARGV) =~
            /rgb\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)/ &&
                printf "#%02X%02X%02X\n", $1, $2, $3
    ' "${@}"
}

# Converts the first argument from a '#63584D' or '63584D' color format into an
# 'rgb(99, 88, 77)' color format. The number sign is optional.
hex2rgb() {
    perl -e '
        (shift @ARGV) =~
            /#?([[:xdigit:]]{2})([[:xdigit:]]{2})([[:xdigit:]]{2})/ &&
                printf "rgb(%d, %d, %d)\n", hex($1), hex($2), hex($3)
    ' "${@}"
}
