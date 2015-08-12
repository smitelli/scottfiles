local pwfile="${HOME}/.secrets/ssmitelli@vs.db.devorch.com"
if [[ -f "$pwfile" && -r "$pwfile" ]]; then
    alias "vsdb"="mysql -hvs.db.devorch.com -ussmitelli -p`cat $pwfile`"
else
    echo "Secret file $pwfile does not exist"
fi

HOSTNAME_COLOR=$COLOR_YELLOW
