help:
    @just --list

alias u := update
update: sync
    nh os switch .
    nh home switch .
    @just clean

alias s := sync
sync:
    git pull
    sudo nix flake update

alias r := rebuild
rebuild +NH-ARGS:
    git add .
    nh {{NH-ARGS}}

alias c := clean
clean:
    nh clean all --keep 5 --keep-since 7d

iso:
    nom build .#nixosConfigurations.iso.config.system.build.isoImage -o result
