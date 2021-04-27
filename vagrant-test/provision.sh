#!/bin/bash

### MODE SECURE
set -u # en cas de variable non définit, arreter le script
set -e # en cas d'erreur (code de retour non-zero) arreter le script

### UTILITER ###
# fonctions, variables, etc.
# afin d'eviter les collisions, je vais préfixer mes fonction par ps_
# ps égale Poste
PACKAGES_LIST="python3 python3-pip python3-dev git code"
VSC="code"

# Afficher de l'aide
ps_help(){
	1>&2 echo "Usage: ./script.sh DOMAIN"
	1>&2 echo ""
}

# Vérifier que le script est lancé en tant que root
ps_assert_root(){
	REAL_ID="$(id -u)"
	if [ "$REAL_ID" -ne 0 ]; then
		1>&2 echo "ERREUR: Le script doit etre exécuté en tant que root"
		exit 1
	fi
}

ps_install_package() {
    PACKAGE_NAME="$1"
    if ! dpkg -l |grep --quiet "^ii.*$PACKAGE_NAME " ; then 
        apt-get install -y "$PACKAGE_NAME"
    else
        echo ""
        echo "$PACKAGE_NAME est déjà installé."
    fi
}

# Vérification d'un package
ps_verif_package() {
    PACKAGE_NAME="$1"
    if ! dpkg -l |grep --quiet "^ii.*$PACKAGE_NAME " ; then 
       echo "$PACKAGE_NAME n'est pas installé."
    else
        echo ""
        echo "$PACKAGE_NAME est déjà installé."
    fi
}

ps_verif_file(){
    FILE=$1
    if test -f "$FILE"; then
        echo "$FILE existe."
    else 
        echo "$FILE n'existe pas."  
        exit 1
    fi
}

## vérification de clé ssh
ps_verif_keygen(){
    FILE_KEY=/home/vagrant/.ssh/id_rsa.pub
    FILE_KEY_PUB=/home/vagrant/.ssh/id_rsa.pub
    ps_verif_file $FILE_KEY >/dev/null
    ps_verif_file $FILE_KEY_PUB >/dev/null
    echo "Il existe une clé ssh."  
}

# Installation de visual studio code
ps_install_vsc(){
    PACKAGE_NAME_0="$1"

    # Installation de snap
    ps_install_package snapd

    if ! dpkg -l |grep --quiet "^ii.*$PACKAGE_NAME_0 " ; then 
        snap install $PACKAGE_NAME_0 --classic
    else
        echo ""
        echo "$PACKAGE_NAME_0 code est déjà installé."
    fi
}

# Génération de cle ssh
ps_keygen(){
    echo "1"
    ssh-keygen -q -t rsa -N 'vagrant' -f ~/.ssh/id_rsa <<<y 2>&1 >/dev/null
    RES=$? 
    if [ $RES -eq 0 ]; then
        echo "Clé ssh généré avec succès."
    else
        echo "Une erreur s'est produite lors de la génération de la clé ssh."
        echo "Veuillez contactez votre support."
        exit 1
    fi
}

### POINT D'ENTRER DU SCRIPT ###

## Vérifier que le script est lancé en tant que root
ps_assert_root

## mise à jour du dépot de package 
apt-get update 
## Instalation de la liste de nos packages
for PACKAGE in $PACKAGES_LIST ; do

    # Instalation du package
    if [ "$PACKAGE" = "$VSC" ] ; then
        ps_install_vsc "$PACKAGE"
    else
        ps_install_package "$PACKAGE"
    fi
done

## Génération d'une clé ssh
ps_keygen

echo ""
echo "Success"
