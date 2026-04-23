#
# Executes commands at the start of an interactive session.
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# User configuration
export PATH="${HOME}/.cargo/bin:${PATH}"
export PATH="${PATH}:${HOME}/.local/bin"
export PATH="${PATH}:${HOME}/.npm-global/bin"

# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Custom aliases
[[ ! -f ${HOME}/.zshrc.aliases ]] || source ${HOME}/.zshrc.aliases
[[ ! -f ${HOME}/.omz-git.plugin.zsh ]] || source ${HOME}/.omz-git.plugin.zsh
[[ ! -f ${HOME}/.omz-vscode.plugin.zsh ]] || source ${HOME}/.omz-vscode.plugin.zsh

# fzf
[[ -f ${HOME}/.fzf.zsh ]] && source ${HOME}/.fzf.zsh

# starship
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"

# fzf
eval "$(fzf --zsh)"

# pyenv
export PYENV_ROOT="${HOME}/.pyenv"
[[ -d ${PYENV_ROOT}/bin ]] && export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init - zsh)"

# tempit
eval "$(tempit init zsh)"
