SCOTTFILES_PATH="${HOME}/.scottfiles"

# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return;;
esac

. "${SCOTTFILES_PATH}/_shell-shared/config.sh"
. "${SCOTTFILES_PATH}/_shell-shared/include.sh"
. "${SCOTTFILES_PATH}/_shell-shared/path.sh"

# If there is a system-wide bashrc file and/or completions, source these first.
trysource /etc/bashrc
trysource /etc/bash_completion

# Source everything that is cross-shell compatible (e.g. with zsh)
trysource_all "${HOME}/.shrc.d"

# Source everything in the bashrc directory, then we're done!
trysource_all "${HOME}/.bashrc.d"
