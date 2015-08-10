alias ll='ls -al'
alias la='ls -A'
alias l='ls -C'

jcurl() {
    curl "$@" | python -m json.tool
}

serve() {
    python -m SimpleHTTPServer "$@"
}
