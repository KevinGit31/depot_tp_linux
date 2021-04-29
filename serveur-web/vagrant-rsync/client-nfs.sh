#!/bin/bash

### MODE SECURE
set -u # en cas de variable non définit, arreter le script
set -e # en cas d'erreur (code de retour non-zero) arreter le script

### UTILITER ###
# fonctions, variables, etc.
# afin d'eviter les collisions, je vais préfixer mes fonction par ns_
# ns égale nsf

# Chemin du fichier de partage coté client 
SHAREFOLDER=/nfs/web

# Chemin du fichier de partage coté serveur
SERVEUR_SHAREFOLDER=/var/nfs/web

# Adresse Ip du serveur NFS
SERVEUR_NFS_IP="172.30.1.101"

# Vérifier que le script est lancé en tant que root
ns_assert_root(){
	REAL_ID="$(id -u)"
	if [ "$REAL_ID" -ne 0 ]; then
		1>&2 echo "ERREUR: Le script doit etre exécuté en tant que root"
		exit 1
	fi
}

# Instalation du serveur nsf
ns_install_server(){
    if ! dpkg -l |grep --quiet "^ii.*nfs-common " ; then 
        sudo apt install nfs-common -y
    else
        echo ""
        echo "Le client nfs est déjà installé."
    fi
}

# Confirguration du fichier /etc/fstab
ns_config_fstab_file() {

S_IP=$1
S_FOLDER=$2
FOLDER=$3

CONFIG_EXIST=$(cat /etc/fstab | grep "$SERVEUR_NFS_IP:$SERVEUR_SHAREFOLDER    $SHAREFOLDER" | wc -l)

if [ "$CONFIG_EXIST" -eq 0 ] ; then 
    
    echo "$SERVEUR_NFS_IP"
    echo "$SERVEUR_SHAREFOLDER"
    echo "$SHAREFOLDER"
    echo "$SERVEUR_NFS_IP:$SERVEUR_SHAREFOLDER $SHAREFOLDER"

    echo "$SERVEUR_NFS_IP:$SERVEUR_SHAREFOLDER    $SHAREFOLDER   nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" >> /etc/fstab
    echo "Configuration du fichier /etc/fstab ok ."
else    
    echo "La config pour le serveur $S_IP exite déjà."
fi

}

# Redémarrage de la machine
ns_reboot(){
    echo ""
    echo "Le client nfs va rédemarrer."
    echo ""
    reboot
}


### POINT D'ENTRER DU SCRIPT ###
ns_assert_root 

# Install serveur nsf
ns_install_server

# Création du fichier de partage Web et Jenkins
mkdir $SHAREFOLDER -p

# Configuration du fichier /etc/fstab
ns_config_fstab_file $SERVEUR_NFS_IP $SERVEUR_SHAREFOLDER    $SHAREFOLDER 

ns_reboot

echo ""
echo "Success"