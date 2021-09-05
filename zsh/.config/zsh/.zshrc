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

# Env-specific
if [ $(hostname) = "fennec" ]; then

    # Start genie (systemd bottle for WSL) if login shell
    if [[ -o login ]]; then
        genie -i
    fi

else

    # Autostart X at login
    if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
        exec startx
    fi

fi

# vim:ft=zsh
