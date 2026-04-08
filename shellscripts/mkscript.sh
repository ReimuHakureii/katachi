#!/bin/bash

# Auteur : Florian van den Bersselaar
# Date : 2026-04-08
# Description : Ce script crée un nouveau script bash avec l'en-tête automatiquement
# rempli, le rend exécutable et l'ouvre dans nano.

username=$(cat /etc/passwd | grep $USER | cut -d: -f5 | cut -d, -f1)
cdate=$(date "+%F")

base="#!/bin/bash\n\n# Auteur : $username\n# Date : $cdate\n# Description : \n\n"

if [ $# -ge 1 ]; then
    echo -e $base > $1
    chmod u+x $1
    nano $1
else
    echo "Il manque un nom de script en paramètres."
fi