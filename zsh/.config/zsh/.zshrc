setopt appendhistory

# man zshoptions for more info
setopt extendedglob nomatch menucomplete interactive_comments
stty stop undef # Disable ctrl+s to freeze terminal
zle_highlight=("paste:none")

# No beeping, please
unsetopt BEEP

# Completion
autoload -Uz compinit
zstyle ":completion:*" menu select
zstyle ":completion:*" matcher-list "" "m:{a-z}={A-Z}" "+m:{A-Z}={a-z}"
zmodload zsh/complist
compinit

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Source other zshrc files
source "$ZDOTDIR/exports"
source "$ZDOTDIR/aliases"
source "$ZDOTDIR/vim-mode"
source "$ZDOTDIR/plugins"

# Completion: include hidden files
_comp_options+=(globdots)

# Env-specific
if [ $(uname -r | grep "microsoft") ]; then

    # Start ssh-agent
    if ! pgrep -u "$USER" ssh-agent > /dev/null; then
        ssh-agent -s > "$XDG_RUNTIME_DIR/ssh-agent.env"
    fi
    if [[ ! "$SSH_AUTH_SOCK" ]]; then
        source "$XDG_RUNTIME_DIR/ssh-agent.env" > /dev/null
    fi

else

    # Autostart X at login
    if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
        exec startx
    fi

fi

# vim:ft=zsh
