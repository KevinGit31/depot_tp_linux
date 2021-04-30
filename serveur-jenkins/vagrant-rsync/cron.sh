#!/bin/bash

### MODE SECURE
set -u # en cas de variable non définit, arreter le script
set -e # en cas d'erreur (code de retour non-zero) arreter le script

# Chemin du fichier de partage coté client
SOURCE=${1:-}
TARGET=${2:-}
DATE_SAVE=$(date +'%m_%d_%Y %H_%M_%S')

# Sauvegarde de fichier
cp -R "$SOURCE" "$TARGET/jenkins_$DATE_SAVE/"
echo "Date : $DATE_SAVE             fichier sauvegarder : jenkins_$DATE_SAVE" >> "$TARGET/info.log"