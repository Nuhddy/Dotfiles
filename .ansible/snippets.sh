#! /usr/bin/env bash

update_pacman_pkglist() {
    echo "pacman_pkgs:" > pacman_pkgs.yaml
    pacman -Qen | awk '{ print "- "$1 }' >> pacman_pkgs.yaml
}

update_aur_pkglist() {
    echo "aur_pkgs:" > aur_pkgs.yaml
    pacman -Qem | awk '{ print "- "$1 }' >> aur_pkgs.yaml
}

update_pacman_pkglist
update_aur_pkglist
