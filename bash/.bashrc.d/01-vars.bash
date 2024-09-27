# HISTCONTROL
#       A  colon-separated  list  of values controlling how commands are
#       saved on the history list.   If  the  list  of  values  includes
#       ignorespace,  lines  which  begin with a space character are not
#       saved in the history list.  A value of ignoredups  causes  lines
#       matching the previous history entry to not be saved.  A value of
#       ignoreboth is shorthand for ignorespace and ignoredups.  A value
#       of erasedups causes all previous lines matching the current line
#       to be removed from the history list before that line  is  saved.
#       Any  value  not in the above list is ignored.  If HISTCONTROL is
#       unset, or does not include a valid value, all lines read by  the
#       shell parser are saved on the history list, subject to the value
#       of HISTIGNORE.  The second and subsequent lines of a  multi-line
#       compound  command  are  not tested, and are added to the history
#       regardless of the value of HISTCONTROL.
HISTCONTROL=ignoreboth

# HISTSIZE
#       The number of commands to remember in the command  history  (see
#       HISTORY below).  The default value is 500.
HISTSIZE=10000000

# checkwinsize
#       If  set,  bash checks the window size after each command
#       and, if necessary, updates the values of LINES and  COL-
#       UMNS.
shopt -s checkwinsize

# cmdhist
#       If  set,  bash attempts to save all lines of a multiple-
#       line command in the same  history  entry.   This  allows
#       easy re-editing of multi-line commands.
shopt -s cmdhist

# histappend
#       If  set,  the history list is appended to the file named
#       by the value of the HISTFILE  variable  when  the  shell
#       exits, rather than overwriting the file.
shopt -s histappend

# lithist
#       If  set,  and  the cmdhist option is enabled, multi-line
#       commands are saved to the history with embedded newlines
#       rather than using semicolon separators where possible.
shopt -u lithist

# Silence macOS Bash shell deprecation noise.
# https://support.apple.com/en-us/HT208050
# > If you invoke the bash shell while macOS Catalina is configured to use a
# > different shell, you'll see a message that the default interactive shell is
# > now zsh. To silence this warning, you can add this command to
# > ~/.bash_profile or ~/.profile:
export BASH_SILENCE_DEPRECATION_WARNING=1
