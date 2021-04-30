#!/bin/bash

### MODE SECURE
set -u # en cas de variable non définit, arreter le script
set -e # en cas d'erreur (code de retour non-zero) arreter le script

# Chemin du fichier de partage coté client
SOURCE=${1:-}
TARGET=${2:-}
DATE_SAVE=$(date +'%m_%d_%Y_%H_%M_%S')

# Sauvegarde de fichier
tar -czvf "${TARGET}_${DATE_SAVE}.tar.gz" "$SOURCE"
rm  -r  "${SOURCE}*"
echo "Date : $DATE_SAVE             ${TARGET}_${DATE_SAVE}.tar.gz " >> "$TARGET/info.log"
echo "Date : $DATE_SAVE             $SOURCE" >> "$TARGET/info.log"
echo "Date : $DATE_SAVE             fichier sauvegarder : nfs_$DATE_SAVE" >> "$TARGET/info.log"