#!/bin/bash

### MODE SECURE
set -u # en cas de variable non définit, arreter le script
set -e # en cas d'erreur (code de retour non-zero) arreter le script

### UTILITER ###
# fonctions, variables, etc.
# afin d'eviter les collisions, je vais préfixer mes fonction par ns_
# ns égale nsf

SHAREFOLDER_WEB=/var/nfs/web
SHAREFOLDER_JENKINS=/var/nfs/jenkins

CLIENT_WEB_IP="172.30.1.2"
CLIENT_JENKINS_IP="172.30.1.3"
CONFIG_EXIST=""

# Archive des dossiers de partage
SOURCE_JENKINS=/var/nfs/jenkins/
SOURCE_WEB=/var/nfs/web/
TARGET_JENKINS=/var/nfs/jenkins
TARGET_WEB=/var/nfs/web
SCRIPT_SAUVEGARDE=/home/rsync/cron_tar.sh

# Afficher de l'aide
ns_help(){
	1>&2 echo "Usage: ./script.sh CLIENT_IP SHAREFOLDER"
	1>&2 echo ""
    1>&2 echo "CLIENT_IP l'adresse ip du client (Obligatoire)"
    1>&2 echo "SHAREFOLDER Dossier de partage sur le serveur (Optionel)"
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
ns_config_export_file() {
FOLDER_TMP=$1
IP_TMP=$2
CONFIG_EXIST=$(cat /etc/exports | grep "$FOLDER_TMP   $IP_TMP" | wc -l)
if [ "$CONFIG_EXIST" -eq 0 ] ; then 
    echo "$FOLDER_TMP   $IP_TMP(rw,sync,no_root_squash,no_subtree_check)" >> /etc/exports
    echo "Configuration du fichier /etc/exports ok ."
else    
    echo "La config pour le client $IP_TMP exite déjà."
fi
}

ns_config_sauvegarde_cron(){

SCRIPT=$1
SRC=$2
TAR=$3

    CONFIG_EXIST=$(cat /etc/crontab | grep "$SCRIPT $SRC $TAR" | wc -l)
    if [ "$CONFIG_EXIST" -eq 0 ] ; then 
    
    #Pour des besoins de test le script s'execute tous les minutes
    echo "*/5 * * * * root /bin/bash $SCRIPT $SRC $TAR" >> /etc/crontab  

    # Configue pour l'execution chaque heure 
    #"0 * * * * root /bin/bash $SCRIPT $SRC $TAR" >> /etc/crontab
    echo "Configuration du fichier /etc/crontab ok ."
else
# Modification du du fichier /etc/crontab
    sed '/\/home\/rsync\/cron_tar\.sh/d' /etc/crontab > /etc/crontab_
    mv /etc/crontab_  /etc/crontab
    echo "*/5 * * * * root /bin/bash $SCRIPT $SRC $TAR" >> /etc/crontab
    echo "Cette configuration existe déjà."
fi

}

# Configuration ufw
ns_ufw_config(){
apt install ufw -y
ufw enable  <<< y 
ufw allow OpenSSH
ufw allow from $CLIENT_WEB_IP to any port nfs
ufw allow from $CLIENT_JENKINS_IP to any port nfs
ufw status
}


### POINT D'ENTRER DU SCRIPT ###
ns_assert_root 

apt-get install -y cron

# Install serveur nsf
ns_install_server

# Création du fichier de partage Web et Jenkins
mkdir $SHAREFOLDER_WEB -p
mkdir $SHAREFOLDER_JENKINS -p

# Configuration du fichier /etc/exports
ns_config_export_file $SHAREFOLDER_WEB $CLIENT_WEB_IP
ns_config_export_file $SHAREFOLDER_JENKINS $CLIENT_JENKINS_IP

# Redémarrage du serveur
systemctl restart nfs-kernel-server

# Install ufw 
ns_ufw_config

ns_config_sauvegarde_cron  $SCRIPT_SAUVEGARDE $SOURCE_JENKINS $TARGET_JENKINS
ns_config_sauvegarde_cron  $SCRIPT_SAUVEGARDE $SOURCE_WEB $TARGET_WEB

echo ""
echo "Success"
