# GROFF_NO_SGR
#       If set, the old drawing scheme for bold and underline (using the
#       backspace character) is active.  Colors are disabled.
#
# This is only being set because, without it, the colors in `man` don't work.
export GROFF_NO_SGR=1

# Work around a TTY detection bug in Vagrant
export VAGRANT_DETECTED_OS="$(uname)"

# Work around an AWS SDK bug in Packer
export AWS_SHARED_CREDENTIALS_FILE="$(cygpath -w $HOME/.aws/credentials)"
