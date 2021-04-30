# Documentation d'installation

## _Ce document a pour but de guider et d'aider l'utilisateur à installer les différents environnements, exécuter les différents scripts._

Ce document va se présenter en 6 parties:
- installation des postes de Dev
- installation du serveur jenkins
- installation du serveur web
- installation du serveur nfs
- lancement du partage de fichier client serveur-web
- lancement du partage de fichier client serveur-jenkins

## Installation des postes de Dev

TO DO

## Installation du serveur jenkins

Pour pouvoir installer le serveur jenkins, il vous faudra aller dans le répertoire /serveur-jenkins/. 

Une fois dans le répertoire, vous verrez deux fichiers VagrantFile qui sert à faire nos install.

Il faudra ouvrir une "invit de command bash". Pour cela faite un clic droit avec votre souris et cliquer sur "Git bash here" (voir image).![Test Image 1](./img/Capture_serveur-jenkins.png)

Une fenêtre va alors s'ouvrir (voir image) ![Test Image 2](./img/Capture_serveur-jenkins_bash.png) taper la commande suivante :
```sh
vagrant up
```

Elle a pour but de lancer le script qui va lancer la création de la machine virtuel.

Une fois la création de la machine virtuel faite, vous le saurez quand la ligne suivante

apparaîtra ```Vanilla Debian box. See https://app.vagrantup.com/debian for help and bug reports```.

Pour entrez sur votre machine virtuel tapez la commande 
```sh
vagrant ssh
``` 

Une fois dans la machine tapez la commande suivante

```sh
cd /home/rsync
```

puis taper sur la touche "entrée".

Vous vous trouvez dans le repertoire /home/rsync qui va permettre la création du serveur jenkins.

Tapez la commande suivante pour lancer le script et valider.

```sh
sudo ./provision.sh
```

Le script va mettre un certain à s'executer, quand le script aura fini de s'exécuter il affichera ```jenkins: Success```.

Pour vérifier que l'installation du serveur jenkins a bien fonctionné, ouvrez un navigateur, entrez l'ip de votre machine qui s'affiche à la fin de l'installation en dessous de la ligne ```Veuillez notez votre IP quelque part``` cela doit donner 
```sh 
ipmachine:8080
```
et normalement vous devez atterir sur cette page. ![Test Image 3](./img/Capture_serveur-jenkins_browser.png)

Voilà l'installation de votre serveur jenkins est un succès.

## Installation du serveur web

Pour pouvoir installer le serveur web, il vous faudra aller dans le répertoire /serveur-web/. 

Une fois dans le répertoire, vous verrez deux fichiers (VagrantFile) qui sert à faire nos install.

Il faudra ouvrir une "invit de command bash". Pour cela faite un clic droit avec votre souris et cliquer sur "Git bash here" (voir image).![Test Image 1](./img/Capture_serveur-web.png)

Une fenêtre va alors s'ouvrir (voir image) ![Test Image 2](./img/Capture_serveur-jenkins_bash.png) taper la commande suivante :
```sh
vagrant up
```

Elle a pour but de lancer le script qui va lancer la création de la machine virtuel.

Une fois la création de la machine virtuel faite, vous le saurez quand la ligne suivante

apparaîtra ```Vanilla Debian box. See https://app.vagrantup.com/debian for help and bug reports```.

Pour entrez sur votre machine virtuel tapez la commande 
```sh
vagrant ssh
``` 

Une fois dans la machine tapez la commande suivante

```sh
cd /home/rsync
```

puis taper sur la touche "entrée".

Vous vous trouvez dans le repertoire /home/rsync qui va permettre la création du serveur web.

Tapez la commande suivante pour lancer le script et valider.

```sh
sudo ./provision.sh
```

Le script va mettre un certain à s'executer, quand le script aura fini de s'exécuter il affichera ```web: Success```.

Pour vérifier que l'installation du serveur web a bien fonctionné, ouvrez un navigateur, entrez l'ip de votre machine qui s'affiche à la fin de l'installation en dessous de la ligne ```Veuillez notez votre IP quelque part``` cela doit donner 
```sh 
ipmachine 
```
et normalement vous devez atterir sur cette page. ![Test Image 3](./img/Capture_serveur-web_browser.png)

Voilà l'installation de votre serveur web est un succès.

## Installation du serveur NFS

Pour pouvoir installer le serveur NFS, il vous faudra aller dans le répertoire /serveur-nfs/. 

Une fois dans le répertoire, vous verrez deux fichiers VagrantFile qui sert à faire nos install.

Il faudra ouvrir une "invit de command bash". Pour cela faite un clic droit avec votre souris et cliquer sur "Git bash here" (voir image).![Test Image 1](./img/Capture_serveur-web.png)

Une fenêtre va alors s'ouvrir (voir image) ![Test Image 2](./img/Capture_serveur-jenkins_bash.png) taper la commande suivante :
```sh
vagrant up
```

Elle a pour but de lancer le script qui va lancer la création de la machine virtuel.

Une fois la création de la machine virtuel faite, vous le saurez quand la ligne suivante

apparaîtra ```Vanilla Debian box. See https://app.vagrantup.com/debian for help and bug reports```.

Pour entrez sur votre machine virtuel tapez la commande 
```sh
vagrant ssh
``` 

Une fois dans la machine tapez la commande suivante

```sh
cd /home/rsync
```

puis taper sur la touche "entrée".

Vous vous trouvez dans le repertoire /home/rsync qui va permettre la création du serveur nfs.

Tapez la commande suivante pour lancer le script et valider.

```sh
sudo ./provision.sh
```

Le script va mettre un certain à s'executer, quand le script aura fini de s'exécuter il affichera ```nfs: Success```.

Pour vérifier que l'installation du serveur nfs a bien fonctionné vous verrez cette image ![Test Image 3](./img/Capture_serveur-nfs_OK.png)


## Bravo vous avez pu lancer toutes vos machine virtuel. fer

## Lancement du partage de fichier client serveur-web

Pour pouvoir lancer le serveur de sauvegarde pour le serveur-web, se rendre dans le repertoire /serveur-web/.

Il faudra ouvrir une "invit de command bash". Pour cela faite un clic droit avec votre souris et cliquer sur "Git bash here" (voir image).![Test Image 1](./img/Capture_serveur-jenkins.png)

Une fois la fenêtre bash ouvert taper la commande

```sh
cd /home/rsync
```
puis taper sur la touche "entrée".

Vous vous trouvez dans le repertoire /home/rsync.

Tapez la commande suivante pour lancer le script et valider. Celle-ci va mettre en place une sauvegarde automatique du repertoire /var/www/html/ sur le serveur nfs

```sh
sudo ./client.sh
```

Une fois le script exécuté faite un reload de la machine virtuel avec la commande suivante pour recharger la VM.

```sh
vagrant reload
```

Une fois la VM redemarré s'y connecter en utilisant la commande

```sh
vagrant ssh
```

Pour vérifier que la sauvegarde s'effectue correctement, taper la commande suivante et le répertoire doit contenir des fichiers de sauvegardes.

```sh
ls /nfs/web
```

## Lancement du partage de fichier client serveur-jenkins

Pour pouvoir lancer le serveur de sauvegarde pour le serveur-jenkins, se rendre dans le repertoire /serveur-jenkins/.

Il faudra ouvrir une "invit de command bash". Pour cela faite un clic droit avec votre souris et cliquer sur "Git bash here" (voir image).![Test Image 1](./img/Capture_serveur-jenkins.png)

Une fois la fenêtre bash ouvert taper la commande

```sh
cd /home/rsync
```
puis taper sur la touche "entrée".

Vous vous trouvez dans le repertoire /home/rsync.

Tapez la commande suivante pour lancer le script et valider. Celle-ci va mettre en place une sauvegarde automatique du repertoire /usr/local/jenkins sur le serveur nfs

```sh
sudo ./client.sh
```

Une fois le script exécuté faite un reload de la machine virtuel avec la commande suivante pour recharger la VM.

```sh
vagrant reload
```

Une fois la VM redemarré s'y connecter en utilisant la commande

```sh
vagrant ssh
```

Pour vérifier que la sauvegarde s'effectue correctement, taper la commande suivante et le répertoire doit contenir des fichiers de sauvegardes.

```sh
ls /nfs/jenkins
```