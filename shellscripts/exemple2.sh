#!/bin/bash

# Auteur : Florian van den Bersselaar
# Date : 2026-04-08
# Description : Ce script affiche le calendrier CLI et affiche le contenu de
# la variable d'environnement

clear

# Affichage du titre de ce script
echo "********** Exemple 2 : Calendrier et variables d'environnement **********"

echo "Calendrier : "
cal

# Affichage des valeurs de deux variable d'environnement
echo "Dossier courant : " $PWD
echo "Nom de cette machine : " $HOSTNAME

# Cariage Return
echo -e "\n"