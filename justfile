help:
    just --list

alias u := update
update:
    git pull
    sudo nix flake update
    nh os switch .
    nh home switch .
    nh clean all --keep 5 --keep-since 7d
