autoload -Uz compinit && compinit
autoload -Uz vcs_info

alias ls='ls --color=auto'

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
RPROMPT='${vcs_info_msg_0_}'
# PROMPT='${vcs_info_msg_0_}%# '
zstyle ':vcs_info:git:*' formats '%b'

COLOR_DEF='%f'
COLOR_USR='%F{243}'
COLOR_DIR='%F{197}'
COLOR_GIT='%F{39}'

setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n@%M ${COLOR_DIR}%d ${COLOR_GIT}${vcs_info_msg_0_} ${COLOR_DEF}%% '
export RPROMPT=''

alias sudo="sudo -E "
alias ll="ls -la"
alias mvnc="sh ~/work/nix-config/mvnc.sh"
alias glog="git log --graph --abbrev-commit --decorate --oneline"
alias rgit="python ~/work/nix-config/rgit.py"

