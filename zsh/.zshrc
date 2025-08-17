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
  dirhistory
  copybuffer
  copypath
  vscode
  diff-so-fancy
  tempit
  zsh-syntax-highlighting
)

source ${ZSH}/oh-my-zsh.sh

# User configuration
path+=(
  $HOME/.cargo/bin
  /opt/nvim-linux64/bin
  $HOME/.local/bin
  $HOME/.npm-global/bin
)

# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Custom aliases
[[ -f "${DOTFILES_DIR}/zsh/.zshrc.aliases" ]] && source "${DOTFILES_DIR}/zsh/.zshrc.aliases"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ${HOME}/.p10k.zsh ]] || source ${HOME}/.p10k.zsh

# fzf
[[ -f ${HOME}/.fzf.zsh ]] && source ${HOME}/.fzf.zsh

# zoxide
eval "$(zoxide init zsh)"

# pyenv
export PYENV_ROOT="${HOME}/.pyenv"
if command -v pyenv >/dev/null 2>&1; then
  path=($PYENV_ROOT/bin $path)
  eval "$(pyenv init - zsh)"
fi

# Autostart tmux
autostart_tmux_once() {
  # Do nothing if already in tmux, non-interactive shell, or no TTY
  [[ -n ${TMUX} || $- != *i* || ! -t 1 ]] && return

  # Replace shell by tmux
  exec tmux new-session -A -s default
}
precmd_functions+=autostart_tmux_once
