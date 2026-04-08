#!/bin/bash

# Auteur : Florian van den Bersselaar
# Date : 2026-04-08
# Description : Ce script affiche le dossier courant et son contenu

# Suppression du contenu de l'écran
clear

# Affichage du titre de ce script
echo "********** Exemple 1 : Où suis-je **********"

echo "*** Dossier courant : "
pwd

echo "*** Contenu du dossier courant : "
ls -l