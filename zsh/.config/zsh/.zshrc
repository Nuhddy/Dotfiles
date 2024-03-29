# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

setopt appendhistory

# man zshoptions for more info
setopt extendedglob nomatch menucomplete interactive_comments
stty stop undef <$TTY >$TTY # Disable ctrl+s to freeze terminal
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
        ssh-agent -s > "/tmp/ssh-agent.env"
    fi
    if [[ ! "$SSH_AUTH_SOCK" ]]; then
        source "/tmp/ssh-agent.env" > /dev/null
    fi

else

    # Autostart X at login
    if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
        exec startx
    fi

fi

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/zsh/.config/zsh/.p10k.zsh.
[[ ! -f ~/.dotfiles/zsh/.config/zsh/.p10k.zsh ]] || source ~/.dotfiles/zsh/.config/zsh/.p10k.zsh

# vim:ft=zsh
