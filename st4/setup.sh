#!/bin/bash -e

WINPATH="${APPDATA}/Sublime Text"
MACPATH="${HOME}/Library/Application Support/Sublime Text"

SELF_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -d "$WINPATH" ]; then
    SUBLIME_PATH="$WINPATH"
    PLATFORM=win
    LINK_CMD='ln -f'
elif [ -d "$MACPATH" ]; then
    SUBLIME_PATH="$MACPATH"
    PLATFORM=mac
    LINK_CMD='ln -sf'
else
    echo 'Could not find the Sublime Text data directory.'
    echo 'Make sure Sublime Text has been started at least once or fix this script.'
    exit 1
fi

# Install Package Control, which will then install everything else
curl -fL 'https://packagecontrol.io/Package%20Control.sublime-package' -o "${SUBLIME_PATH}/Installed Packages/Package Control.sublime-package"

# Install individual preference files into the User package
${LINK_CMD} "${SELF_DIR}/Markdown.sublime-settings" "${SUBLIME_PATH}/Packages/User/"
${LINK_CMD} "${SELF_DIR}/Package Control.sublime-settings" "${SUBLIME_PATH}/Packages/User/"
${LINK_CMD} "${SELF_DIR}/Preferences.${PLATFORM}.sublime-settings" "${SUBLIME_PATH}/Packages/User/Preferences.sublime-settings"
${LINK_CMD} "${SELF_DIR}/Pretty JSON.sublime-settings" "${SUBLIME_PATH}/Packages/User/"

echo 'All files have been installed. Startup may require a bit of a dance:'
echo '1. Start Sublime Text, ignore any visual glitches, and dismiss all errors.'
echo '2. Let it think about itself for a few minutes, then quit Sublime Text.'
echo '3. `git reset --hard HEAD` in this repository.'
echo '4. Restart Sublime Text, enter the license if necessary, and enjoy.'
