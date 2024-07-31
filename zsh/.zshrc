
zstyle ':completion:*' menu select
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select
setopt  autocd autopushd pushdignoredups
autoload -U compinit
compinit
[ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
alias e="emacsclient -c"
HISTSIZE=5000               
HISTFILE=~/.zsh_history     
SAVEHIST=5000
PATH=$PATH:$HOME/.local/bin
PROMPT="%B%F{23}%n%f%b@%F{9}%M%f %~ > "
alias ls="ls -lahF --color=auto"
bindkey "\e[3~" delete-char
RPROMPT=$'%(?..[ %B%?%b ])'

redate() {
    mv -i "$1" "$(exiftool -CreateDate "$1" | cut -d':' -f2- | sed -e 's/:/-/g' -e 's/ /_/g' )-$1"   
}
