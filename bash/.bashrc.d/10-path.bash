# Add ~/bin to the beginning of $PATH if it isn't already there.
local newbin="${HOME}/bin"
if [ -d "$newbin" ] && [[ ":$PATH:" != *":${newbin}:"* ]]; then
    PATH="${newbin}${PATH:+":$PATH"}"
fi
