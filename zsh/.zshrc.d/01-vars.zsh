# HIST_IGNORE_DUPS
#     Do not enter command lines into the history list if they are duplicates of
#     the previous event.
setopt HIST_IGNORE_DUPS

# HIST_IGNORE_SPACE
#     Remove command lines from the history list when the first character on the
#     line is a space, or when one of the expanded aliases contains a leading
#     space. Only normal aliases (not global or suffix aliases) have this
#     behaviour. Note that the command lingers in the internal history until the
#     next command is entered before it vanishes, allowing you to briefly reuse
#     or edit the line. If you want to make it vanish right away without
#     entering another command, type a space and press return.
setopt HIST_IGNORE_SPACE

# HISTSIZE
#     The maximum number of events stored in the internal history list. If you
#     use the HIST_EXPIRE_DUPS_FIRST option, setting this value larger than the
#     SAVEHIST size will give you the difference as a cushion for saving
#     duplicated history events.
HISTSIZE=10000000

# SAVEHIST
#     The maximum number of history events to save in the history file.
SAVEHIST=10000000
