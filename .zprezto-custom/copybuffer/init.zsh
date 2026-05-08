#
# Copy the current command-line buffer to the system clipboard with Ctrl+O.
# Mirrors the oh-my-zsh copybuffer plugin behaviour.
#

pmodload 'editor'

_copybuffer_clip() {
  printf '%s' "$BUFFER" | c
}
zle -N _copybuffer_clip

if [[ -n "$key_info" ]]; then
  for keymap in emacs viins vicmd; do
    bindkey -M "$keymap" '^O' _copybuffer_clip
  done
  unset keymap
fi
