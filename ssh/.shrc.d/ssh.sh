SSH_AGENT_ENV="${HOME}/.ssh/agent_env"

_start_agent() {
    [[ -n "${SCOTTFILES_DEBUG}" ]] && (printf '\nStarting new ssh-agent...')

    (umask 077; ssh-agent -s -t 8h | sed 's/^echo/#echo/' > "${SSH_AGENT_ENV}")
    . "${SSH_AGENT_ENV}" > /dev/null

    [[ -n "${SCOTTFILES_DEBUG}" ]] && printf ' done.\n'
}

if [ -f "${SSH_AGENT_ENV}" ]; then
    [[ -n "${SCOTTFILES_DEBUG}" ]] && printf 'File %s exists...' "${SSH_AGENT_ENV}"

    . "${SSH_AGENT_ENV}" > /dev/null
    ps -ef | grep "${SSH_AGENT_PID}" | grep -E 'ssh-agent( |$)' > /dev/null || {
        [[ -n "${SCOTTFILES_DEBUG}" ]] && printf ' but ssh-agent is dead.'

        _start_agent
    }
else
    _start_agent
fi
