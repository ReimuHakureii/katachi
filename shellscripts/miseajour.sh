#!/bin/bash

# Auteur : Florian van den Bersselaar
# Date : 2026-04-08
# Description : Ce script automatise la mise à jour du système sans interaction
# et enregistre les messages dans un fichier de log ET à l'écran.

LOGFILE="MiseAjour.log"

# Écraser le fichier de log et écrire la date/heure actuelle en première ligne
echo "Mise à jour effectuée le : $(date)" > $LOGFILE

# Fonction pour exécuter une commande, afficher ET loguer la sortie
run_cmd() {
    "$@" 2>&1 | tee -a $LOGFILE
}

echo "=== apt update ===" | tee -a $LOGFILE
run_cmd apt update -y

echo "=== apt upgrade ===" | tee -a $LOGFILE
run_cmd apt upgrade -y

echo "=== apt autoremove ===" | tee -a $LOGFILE
run_cmd apt autoremove -y

echo "=== apt autoclean ===" | tee -a $LOGFILE
run_cmd apt autoclean -y

echo "Mise à jour terminée." | tee -a $LOGFILE