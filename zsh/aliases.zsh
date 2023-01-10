#!/bin/sh

# Zsh-specific
alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

# Configurations
alias cfgs='nvim ~/.config/'

# Git
alias lg='lazygit'

# Fuzzy Searching
alias cda='cd $(find ~/ -type d -print | fzf)'	# Search all directories for user
alias cdh='cd $(find . -type d -print | fzf)'	# Search all directories from terminal's position

# Colorize GREP Output (Good For Log Files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Confirm Before Overwriting Something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# Easier to Read Disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# Get Top Process Eating Memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# Get Top Process Eating CPU ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'
