SCOTTFILES_PATH="${HOME}/.scottfiles"

# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return;;
esac

. "${SCOTTFILES_PATH}/_shell-shared/config.sh"
. "${SCOTTFILES_PATH}/_shell-shared/include.sh"
. "${SCOTTFILES_PATH}/_shell-shared/path.sh"

# If there is a system-wide zshrc file, source it first.
trysource /etc/zshrc

# Source everything that is cross-shell compatible (e.g. with bash)
trysource_all "${HOME}/.shrc.d"

# Source everything in the zshrc directory, then we're done!
trysource_all "${HOME}/.zshrc.d"
