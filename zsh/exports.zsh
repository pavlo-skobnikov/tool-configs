#!/bin/sh
HISTSIZE=1000000
SAVEHIST=1000000
export PATH="$HOME/.local/bin":$PATH
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export PATH=$HOME/.cargo/bin:$PATH
export PATH="$HOME/.local/share/neovim/bin":$PATH
export PATH="$HOME/.emacs.d/bin":$PATH
export PATH="$HOME/.local/share/nvim/mason/bin":$PATH # Mason's path for installing LSPs
