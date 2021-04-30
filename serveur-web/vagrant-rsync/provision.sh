#!/bin/bash

### PARANOIA MODE
set -u # en cas de variable non définie, arreter le script
set -e # en cas d'erreur (code de retour non-zero) arreter le script

DIRECTORY="/var/www/html"

PACKAGES="apache2 ufw w3m cron"

kg_install_apache_ufw() {
	PACKAGE_NAME="$1"
	if ! dpkg -l |grep --quiet "^ii.*$PACKAGE_NAME " ; then
		apt-get install -y "$PACKAGE_NAME"
	else
		echo "$PACKAGE_NAME est déjà installé"
	fi

}

kg_apache2_datadir_setup() {
	echo "kg_apache2_datadir_setup"
	TARGET_DIRECTORY="$1"
	chown -R www-data:www-data "$TARGET_DIRECTORY"
	kg_page_html
}


kg_apache2_reload() {
	echo "kg_apache2_reload"
	systemctl stop apache2
	systemctl start apache2
}

kg_page_html() {
	cp -R /home/rsync/page/index.html /var/www/html/
}

kg_config_ufw() {
	#enable firewall on debian and allow ssh connections to the servers
	ufw allow ssh/tcp
	ufw enable <<<y
	# a voir si on ne met pas l'ip de notre machine
	ufw allow WWW
	ufw allow OpenSSH
}

kg_display_ipadress_machine(){
    echo "*******************************"
    echo "Adresse ip serveur web"
    echo "Veuillez notez votre IP quelque part"
    # Cette command permet de récupérer l'adresse ip de la machine après un ip on va filtrer
    ip a | grep eth1 | grep inet | awk -F "/" '{print $1}' | awk -F " " '{print $2}'
    echo "*******************************"
}

## Installer package
apt-get update
for package in $PACKAGES
	do
		echo "*********$package*********"
		kg_install_apache_ufw "$package"
	done

kg_apache2_datadir_setup "$DIRECTORY"
kg_apache2_reload
kg_config_ufw
kg_display_ipadress_machine

echo "Success"