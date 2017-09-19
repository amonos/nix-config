#
# ~/.bashrc
#

# If not running interactively, don't do anything

export EDITOR=nvim

[[ $- != *i* ]] && return

alias ls='ls --color=auto'

source /usr/share/git/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1

CL_DEFAULT="\[\033[0m\]"
CL_LIGHT_BLUE="\[\033[1;94m\]"
CL_LIGHT_MAGENTA="\[\033[1;95m\]"
CL_LIGHTER_BLUE="\[\033[38;5;116m\]"
CL_YELLOW="\[\033[1;33m\]"
CL_LIGHT_GREEN="\[\033[38;5;79m\]"
CL_ORANGE="\[\033[38;5;210m\]"
RETVAL="if [[ \$? == 0 ]]; then echo \"${CL_LIGHT_GREEN}\"; else echo \"${CL_ORANGE}\"; fi"

export PS1="${CL_LIGHT_BLUE}\u${CL_DEFAULT}@${CL_YELLOW}\h${CL_DEFAULT}:${CL_LIGHT_MAGENTA}\W${CL_LIGHTER_BLUE}\$(__git_ps1)${CL_DEFAULT} \$($RETVAL)\$${CL_DEFAULT} "

function whichprovides() {
    sudo pacman -Qo `which $1`
}

alias sudo="sudo -E "
alias ll="ls -la"
alias mvnc="sh ~/work/mvnc.sh"
alias glog='git log --graph --abbrev-commit --decorate --oneline'

export JAVA_HOME=/usr/lib/jvm/default
export M2_HOME=/home/amonos/apache-maven-3.5.0
export PATH=$PATH:$M2_HOME/bin

#unset SSH_ASKPASS
