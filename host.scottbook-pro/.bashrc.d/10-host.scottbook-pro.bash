OLDIFS=$IFS
IFS=','
for dbacct in ssmitelli,vs ssmitelli,dc
do
    set $dbacct
    pwfile="${HOME}/.secrets/${1}@${2}.db.devorch.com"

    if [[ -f "$pwfile" && -r "$pwfile" ]]
    then
        alias "${2}db"="mysql -h${2}.db.devorch.com -u${1} -p`cat $pwfile`"
    else
        echo "Secret file $pwfile does not exist"
    fi
done
IFS=$OLDIFS

for hname in sc mov02
do
    alias "${hname}"="ssh ssmitelli@${hname}.devorch.com"
    alias "${hname}fs"="mkdir -p /Volumes/${hname}; sshfs ssmitelli@${hname}.devorch.com:/var/www/html_ssmitelli /Volumes/${hname}"
done
