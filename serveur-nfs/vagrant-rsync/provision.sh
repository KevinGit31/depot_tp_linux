#!/bin/bash

### MODE SECURE
set -u # en cas de variable non définit, arreter le script
set -e # en cas d'erreur (code de retour non-zero) arreter le script

### UTILITER ###
# fonctions, variables, etc.
# afin d'eviter les collisions, je vais préfixer mes fonction par ns_
# ns égale nsf
SHARFOLDER=/var/nfs/general
SHARFOLDER_TMP=""
CLIENT_IP="172.30.1.102"
CONFIG_EXIST=""



# Afficher de l'aide
ns_help(){
	1>&2 echo "Usage: ./script.sh CLIENT_IP SHARFOLDER"
	1>&2 echo ""
    1>&2 echo "CLIENT_IP l'adresse ip du client (Obligatoire)"
    1>&2 echo "SHARFOLDER Dossier de partage sur le serveur (Optionel)"
}

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
    if ! dpkg -l |grep --quiet "^ii.*nfs-kernel-server " ; then 
        apt-get install -y nfs-kernel-server
    else
        echo ""
        echo "Le serveur nfs est déjà installé."
    fi
}

# Confirguration du fichier /etc/export
ns_config_export_file(){
CONFIG_EXIST=$(cat /etc/exports | grep "$SHARFOLDER   $CLIENT_IP" | wc -l)
if [ "$CONFIG_EXIST" -eq 0 ] ; then 
    echo "$SHARFOLDER   $CLIENT_IP(rw,sync,no_root_squash,no_subtree_check)" >> /etc/exports
    echo "Configuration du fichier /etc/exports ok ."
else    
    echo "La config pour le client $CLIENT_IP exite déjà."
fi
}

# Configuration ufw
ns_ufw_config(){
    apt install ufw -y
ufw enable  <<< y 
ufw allow OpenSSH
ufw allow from $CLIENT_IP to any port nfs
ufw status
}


### POINT D'ENTRER DU SCRIPT ###
if [ -z "${1:-}" ]; then
    echo "L'adresse ip de la machine cliente n'est pas spécifié"
    ns_help
    exit 1
else
    CLIENT_IP=$1
fi

if  [[ ! -z "${2:-}" ]]; then
    SHARFOLDER=$2
fi 

ns_assert_root 

# Install serveur nsf
ns_install_server

# Création du fichier de partage
mkdir $SHARFOLDER -p

# Configuration du fichier /etc/exports
ns_config_export_file

# Redémarrage du serveur
systemctl restart nfs-kernel-server

# Install ufw 
ns_ufw_config

echo ""
echo "Success"
