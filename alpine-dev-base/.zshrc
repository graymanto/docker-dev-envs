export ZSH=~/.oh-my-zsh

ZSH_THEME="dev"

DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git)

# User configuration

source $ZSH/oh-my-zsh.sh

if [ -f ~/.zsh/ms-settings.zsh  ]; then
	source ~/.zsh/ms-settings.zsh
fi
source ~/.zsh/aliases.zsh
source ~/.zsh/bindkeys.zsh
source ~/.zsh/options.zsh
source ~/.zsh/fzfconfig.zsh
source ~/.zsh/boost.zsh

DISABLE_AUTO_UPDATE="true"

cd ~/
