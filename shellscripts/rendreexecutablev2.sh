#!/bin/bash

# Auteur : Florian van den Bersselaar
# Date : 2026-04-08
# Description : Ce script rend un fichier exécutable. Il accepte le nom du
# fichier en paramètre ou le demande à l'utilisateur si absent.

# Vérifier si un paramètre a été fourni
if [ $# -ge 1 ]; then
    fichier=$1
else
    # Aucun paramètre : demander à l'utilisateur
    read -p "Entrez le nom du fichier à rendre exécutable : " fichier
fi

# Vérifier si le fichier existe
if [ -e "$fichier" ]; then
    chmod a+x "$fichier"
    echo "Le fichier '$fichier' est maintenant exécutable."
    ls -l "$fichier"
else
    echo "Erreur : le fichier '$fichier' n'existe pas."
fi