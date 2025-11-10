#
# CONFIG VARIABLES
#
# Shared between bash and zsh
#

# Uncomment the following line if there is any question about what's going on.
# export SCOTTFILES_DEBUG=1

# MANPAGER
#       If $MANPAGER or $PAGER is set ($MANPAGER is used in preference), its
#       value is used as the name of the program used to display the manual
#       page. By default, less is used, falling back to cat if less is not found
#       or is not executable.
#
#       The value may be a simple command name or a command with arguments, and
#       may use shell quoting (backslashes, single quotes, or double quotes). It
#       may not use pipes to connect multiple commands; if you need that, use a
#       wrapper script, which may take the file to display either as an argument
#       or on standard input.
export MANPAGER='less +Gg'

# k9s Configuration > Env variables (https://k9scli.io/topics/config/)
#       You can also globally override the context configuration by setting an
#       env variable that will override all clusters node shell gate using
#       K9S_FEATURE_GATE_NODE_SHELL=true|false
export K9S_FEATURE_GATE_NODE_SHELL=true
