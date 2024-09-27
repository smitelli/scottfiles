if [[ "$CLICOLOR" -eq 1 ]]; then
    export PS1="[\
\\[\$(_ps1_user_color)\\]\\u\\[${COLOR_NC}\\]@\
\\[\$(_ps1_host_color)\\]\\h\\[${COLOR_NC}\\]:\
\\[${COLOR_CYAN}\\]\\W\\[${COLOR_NC}\\]]\\$ "
else
    export PS1='[\u@\h:\W]\$ '
fi
