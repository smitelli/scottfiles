pwfile="${HOME}/.secrets/ssmitelli@$dc.db.devorch.com"
if [[ -f "$pwfile" && -r "$pwfile" ]]
then
    alias "dcdb"="mysql -hdc.db.devorch.com -ussmitelli -p`cat $pwfile`"
else
    echo "Secret file $pwfile does not exist"
fi

HOSTNAME_COLOR=$COLOR_YELLOW
