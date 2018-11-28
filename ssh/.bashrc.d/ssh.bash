SSH_AGENT_ENV="$HOME/.ssh/agent_env"

function start_agent {
    [[ -v SCOTTFILES_DEBUG ]] && (echo; echo -n 'Starting new ssh-agent...')

    (umask 077; ssh-agent -s -t 28800 | sed 's/^echo/#echo/' > "$SSH_AGENT_ENV")
    . "$SSH_AGENT_ENV" > /dev/null

    [[ -v SCOTTFILES_DEBUG ]] && echo ' done.'
}

if [ -f "$SSH_AGENT_ENV" ]; then
    [[ -v SCOTTFILES_DEBUG ]] && echo -n "File $SSH_AGENT_ENV exists..."

    . "${SSH_AGENT_ENV}" > /dev/null
    ps -ef | grep $SSH_AGENT_PID | grep 'ssh-agent$' > /dev/null || {
        [[ -v SCOTTFILES_DEBUG ]] && echo -n ' but ssh-agent is dead.'

        start_agent
    }
else
    start_agent
fi
