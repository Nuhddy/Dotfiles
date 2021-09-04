setopt appendhistory

# man zshoptions for more info
setopt extendedglob nomatch menucomplete interactive_comments
stty stop undef # Disable ctrl+s to freeze terminal
zle_highlight=("paste:none")

# No beeping, please
unsetopt BEEP

# Completions
autoload -Uz compinit
zstyle ":completion:*" menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Source other zshrc files
source "$ZDOTDIR/exports"
source "$ZDOTDIR/aliases"
source "$ZDOTDIR/vim-mode"
source "$ZDOTDIR/plugins"

# vim:ft=zsh
