# Custom environment variables
export PATH="$PATH:$HOME/.bin:$HOME/.scripts"
export EDITOR="nvim"
export VISUAL="nvim"
export TERM="kitty"
export BROWSER="firefox"
export READER="zathura"
export QT_STYLE_OVERRIDE="gtk2"
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true"
export npm_config_prefix="~/.local/bin/node_modules"

# Autostart X at login
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    exec startx
fi

# vim:ft=zsh
