export ZDOTDIR="$HOME/.config/zsh"

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
