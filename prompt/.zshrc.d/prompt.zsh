if [[ "$CLICOLOR" -eq 1 ]]; then
    setopt PROMPT_SUBST
    export PS1="[\
%{\$(_ps1_user_color)%}%n%{${COLOR_NC}%}@\
%{\$(_ps1_host_color)%}%m%{${COLOR_NC}%}:\
%{${COLOR_CYAN}%1~${COLOR_NC}%}]%# "
else
    export PS1='[%n@%m:%1~]%# '
fi
