#
# PATH ADDITIONS
#
# Shared between bash and zsh
#

# Add ~/bin to the beginning of $PATH if it isn't already there.
newbin="${HOME}/bin"
if [ -d "${newbin}" ] && [[ ":${PATH}:" != *":${newbin}:"* ]]; then
    PATH="${newbin}${PATH:+":${PATH}"}"
fi
unset newbin
