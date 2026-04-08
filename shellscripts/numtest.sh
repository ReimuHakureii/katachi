#!/bin/bash

# Auteur : Florian van den Bersselaar
# Date : 2026-04-08
# Description : Exemple de condition numérique.

# Ce script permet de comparer 2 nombres
echo "Exécution du script en cours ..."

# Déclaration de variables
num1=$1
num2=$2

if [ $num1 -eq $num2 ]; then
    echo "Les variables sont égales et ont une valeur de $num1."
elif [ $num1 -gt $num2 ]; then
    echo "La première variable est plus élevé ($num1 > $num2)."
else
    echo "La deuxième variable est plus élevé ($num1 < $num2)."
fi