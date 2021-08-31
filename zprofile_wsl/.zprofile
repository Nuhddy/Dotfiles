# Custom environment variables
export PATH="$PATH:$HOME/.bin:$HOME/.scripts"
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="wslview"
export READER="wslview"
export npm_config_prefix="~/.local/bin/node_modules"

if [[ -o login ]]; then
    genie -i
fi

# vim:ft=zsh
