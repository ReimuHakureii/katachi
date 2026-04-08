#!/bin/bash

# Auteur : Florian van den Bersselaar
# Date : 2026-04-08
# Description : Ce script lit le clavier et affiche l'entrée ainsi obtenu

# Suppression du contenu de l'écran
clear

# Affichage du titre de ce script
echo "********** Exemple 4 : Lecture du clavier **********"

# Affichage d'un message demandant à l'utilisateur d'entrer son nom
echo "Veuillez entrer votre nom"

# Lecture du clavier et assignation de la lecture à la variable 'name'
read name

# Autre méthode
# read -p "Veuillez entrer votre nom : " name

# Affichage de la variable 'name' à l'écran
echo "Bonjour $name"