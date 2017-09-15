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

alias sudo="sudo "
alias ll="ls -la"
alias mvnc="sh ~/work/mvnc.sh"
alias deploy-paa-local='sh ~/work/cib/deploy-paa.sh --build ~/IdeaProjects/mortgage/portal-mortgage-lending --host wasdev --path /home/wasdev --was-password admin --portal-password admin --paa-app-name portal-mortgage-lending --dependencies ~/IdeaProjects/mortgage/soa-mortgage-lending-client --mvn ~/work/mvnc.sh --deploy-user wasdev'
alias deploy-paa-remote='sh ~/work/cib/deploy-paa.sh --build ~/IdeaProjects/mortgage/portal-mortgage-lending --host aikportal4 --path /home/nfs/awf --was-password wpsbind --portal-password portaladmin --paa-app-name portal-mortgage-lending --dependencies ~/IdeaProjects/mortgage/soa-mortgage-lending-client --mvn ~/work/mvnc.sh --deploy-user was'
alias deploy-soa-local='sh ~/work/cib/deploy-localsoa.sh --host 192.168.4.35 --project-dir /home/amonos/IdeaProjects/mortgage/soa-mortgage-lending --assembly-dir /home/amonos/IdeaProjects/mortgage/soa-mortgage-lending/soa-mortgage-lending-ear --dependencies /home/amonos/IdeaProjects/mortgage/soa-mortgage-lending-client --mvn /home/amonos/work/mvnc.sh --soa soa3'

alias glog='git log --graph --abbrev-commit --decorate --oneline'

export JAVA_HOME=/usr/lib/jvm/default
export M2_HOME=/home/amonos/apache-maven-3.3.9
export ANDROID_HOME=/home/amonos/android
export PATH=$PATH:$M2_HOME/bin

#unset SSH_ASKPASS

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/amonos/google-cloud-sdk/path.bash.inc' ]; then source '/home/amonos/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/amonos/google-cloud-sdk/completion.bash.inc' ]; then source '/home/amonos/google-cloud-sdk/completion.bash.inc'; fi
