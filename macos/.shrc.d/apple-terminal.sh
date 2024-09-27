# Zoom (maximize) each Terminal window to its current screen when opened.
(osascript -e 'tell application "Terminal" to tell first window to set zoomed to true' &)

# Enable TouchID for sudo if not already set up.
#
# macOS upgrades tend to clobber this change, so we take the (admittedly heavy-
# handed) approach of checking every time the shell starts.
#
# https://github.com/MikeMcQuaid/strap/blob/192b70290c2dcd1f08de15f704cfe95592246c99/bin/strap.sh#L187-L203
if ls /usr/lib/pam/pam_tid.so* > /dev/null 2>&1; then
    PAM_FILE='/etc/pam.d/sudo'
    MARKER_LINE='# sudo: auth account password session'
    APPEND_LINE='auth       sufficient     pam_tid.so'

    if grep -q pam_tid.so "${PAM_FILE}"; then
        # TouchID is already enabled, no need to do anything here
        [[ -n "${SCOTTFILES_DEBUG}" ]] && echo 'TouchID is already set up in PAM'
    elif ! head -n1 "${PAM_FILE}" | grep -q "${MARKER_LINE}"; then
        echo "ERROR: Can't add TouchID to ${PAM_FILE}; marker line not found."
    else
        echo "TouchID is not enabled in ${PAM_FILE}."
        echo 'Enter your macOS login password to enable it.'

        sudo sed -i '' -e "s/${MARKER_LINE}/${MARKER_LINE}\n${APPEND_LINE}/" "${PAM_FILE}"
    fi
fi
