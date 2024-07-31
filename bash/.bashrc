# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !
include () {
    [[ -f "$1" ]] && source "$1"
}

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.
export PATH="${HOME}"/.local/bin:"${PATH}"
PROMPT_COMMAND='history -a'
export HISTSIZE=
export HISTCONTROL=ignorespace:ignoredups
include /usr/share/doc/fzf/examples/key-bindings.bash
include /usr/share/bash-completion/completions/fzf
include /usr/share/fzf/key-bindings.bash

#bind 'TAB:menu-complete'	    
#bind 'set show-all-if-ambiguous on'
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

function nonzero_return() {
    RETVAL=$?
    [ $RETVAL -ne 0 ] && echo "$RETVAL"
}

# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
	STAT=`parse_git_dirty`
	echo "[${BRANCH}${STAT}]"
    else
	echo ""
    fi
}

# get current status of git repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
	bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
	bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
	bits="+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
	bits="?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
	bits="x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
	bits="!${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
	echo " ${bits}"
    else
	echo ""
    fi
}
if [ $(whoami) = root ]; then
   export PS1="\u@\H \[\e[37m\]\w\[\e[m\]\[\e[35m\]\`parse_git_branch\`\[\e[m\]\[\e[31m\]\`nonzero_return\`\[\e[m\] \[\033[1;31m\]Λ\[\e[m\] "
else
   export PS1="\u@\H \[\e[37m\]\w\[\e[m\]\[\e[35m\]\`parse_git_branch\`\[\e[m\]\[\e[31m\]\`nonzero_return\`\[\e[m\] \[\e[32m\]λ\[\e[m\] "
fi

alias sudo="doas"
alias es='emacsclient  -a ""'
alias ec='emacsclient  -c'
alias et='emacsclient -t'
alias eck='pkill emacs'
alias upd='doas eix-sync; doas emerge -uUD @world'
MANPAGER="less -R --use-color -Dd+r -Du+b"
complete -F _command doas
export LESS="NIFRSX"

if command -v source-highlight &> /dev/null; then
    # `source-highlight` ist installiert, Konfiguration aktivieren
    export LESSOPEN="| source-highlight-esc.sh %s"
fi
export PROMPT_DIRTRIM=1
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"                  # $EDITOR opens in terminal
export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI mode
