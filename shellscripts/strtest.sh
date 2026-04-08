#!/bin/bash

# Auteur : Florian van den Bersselaar
# Date : 2026-04-08
# Description : Exemple de comparaison de chaînes de caractères.

# Ce script permet de comparer 2 chaînes de caractères
echo "Exécution du script en cours ..."

# Déclaration de variables (envoyées en paramètre)
str1=$1
str2=$2

if [ $str1 = $str2 ]; then
    echo "Les chaînes de caractères sont identiques."
else
    echo "Les chaînes de caractères sont différentes."
fi