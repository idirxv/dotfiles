# Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="${HOME}/.oh-my-zsh"
DOTFILES_DIR="${HOME}/dotfiles"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git
  fzf
  dirhistory
  copybuffer
  copypath
  vscode
  diff-so-fancy
  docker-compose
  zsh-syntax-highlighting
)

source ${ZSH}/oh-my-zsh.sh

# User configuration
export PATH="${HOME}/.cargo/bin:${PATH}"
export PATH="${PATH}:/opt/nvim-linux64/bin"
export PATH="${PATH}:${HOME}/.local/bin"
export PATH="${PATH}:${HOME}/.npm-global/bin"

# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Custom aliases
[[ -f ${DOTFILES_DIR}/zshrc.aliases ]] && source ${DOTFILES_DIR}/zshrc.aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ${HOME}/.p10k.zsh ]] || source ${HOME}/.p10k.zsh

# fzf
[[ -f ${HOME}/.fzf.zsh ]] && source ${HOME}/.fzf.zsh

# zoxide
eval "$(zoxide init zsh)"

# pyenv
export PYENV_ROOT="${HOME}/.pyenv"
[[ -d ${PYENV_ROOT}/bin ]] && export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init - zsh)"

# tempit
eval "$(tempit -init zsh)"

# Autostart tmux
autostart_tmux_once() {
  # Do nothing if already in tmux, non-interactive shell, or no TTY
  [[ -n ${TMUX} || $- != *i* || ! -t 1 ]] && return

  # Replace shell by tmux
  exec tmux new-session -A -s default
}
precmd_functions+=autostart_tmux_once
