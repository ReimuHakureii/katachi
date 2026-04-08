#!/bin/bash

# Auteur : Florian van den Bersselaar
# Date : 2026-04-08
# Description : Ce script demande un nom de fichier à l'utilisateur
# et lui ajoute la permission d'exécution pour tous.

# Demander le nom du fichier à l'utilisateur
read -p "Entrez le nom du fichier à rendre exécutable : " fichier

# Vérifier si le fichier existe
if [ -e "$fichier" ]; then
    chmod a+x "$fichier"
    echo "Le fichier '$fichier' est maintenant exécutable."
    ls -l "$fichier"
else
    echo "Erreur : le fichier '$fichier' n'existe pas."
fi