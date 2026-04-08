#!/bin/bash

# Auteur : Florian van den Bersselaar
# Date : 2026-04-08
# Description : Ce script permet de créer une liste de dossier dans
# un dossier test correspondant à la liste des fichiers dans /var/

# Créer un dossier s'il n'existe pas déjà
function createFolder(){
    if [ ! -e $1 ]; then
        mkdir $1
    fi
}

createFolder test

# Liste tous les fichiers du répertoire /var/ et crée des dossiers
# avec les mêmes noms.
for f in $(ls /var/); do
    createFolder test/$f
done