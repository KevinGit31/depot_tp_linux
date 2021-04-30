# Documentation d'installation

## _Ce document a pour but de guider et d'aider l'utilisateur à installer les différents environnements, exécuter les différents scripts._

Ce document va se présenter en 4 parties:
- installation des postes de Dev
- installation du serveur jenkins
- installation du serveur web
- installation du serveur nfs

## Installation des postes de Dev

## Installation du serveur jenkins

Pour pouvoir installer le serveur jenkins, il vous faudra aller dans le répertoire /serveur-jenkins/. 

Une fois dans le répertoire, vous verrez deux fichiers (VagrantFile et provision.sh) qui serviront à faire nos install.

Il faudra ouvrir une "invit de command bash". Pour cela faite un clic droit avec votre souris et cliquer sur "Git bash here" (voir image).![Test Image 1](img/Capture_serveur-jenkins.png)

Une fenêtre va alors s'ouvrir (voir image) ![Test Image 2](img/Capture_serveur-jenkins_bash.png) taper la commande suivante :
```sh
vagrant up
```

Elle a pour but de lancer le script de création du serveur jenkins.

Le script va mettre un certain à s'executer, quand le script aura fini de s'exécuter il affichera ```server: Success```. 

Une fois l'installation sera fini, pensez à sauvegarder le mot de passe administrateur de jenkins qui va s'afficher en dessous de la ligne ```server: Password initial admin jenkins```.

Pour vérifier que jenkins a bien démarré, ouvrez un navigateur, entrez l'ip de votre machine qui s'affiche à la fin de l'installation en dessous de la ligne ```Veuillez notez votre IP quelque part``` avec le port 8080: cela doit donner 
```sh 
ipmachine:8080 
```
et normalement vous devez atterir sur cette page. ![Test Image 3](img/Capture_serveur-jenkins_browser.png)

Voilà l'installation de jenkins est un succès.

## Installation du serveur web

Pour pouvoir installer le serveur web, il vous faudra aller dans le répertoire /serveur-web/. 

Une fois dans le répertoire, vous verrez deux fichiers (VagrantFile et provision.sh) qui serviront à faire nos install.

Il faudra ouvrir une "invit de command bash". Pour cela faite un clic droit avec votre souris et cliquer sur "Git bash here" (voir image).![Test Image 1](img/Capture_serveur-web.png)

Une fenêtre va alors s'ouvrir (voir image) ![Test Image 2](img/Capture_serveur-jenkins_bash.png) taper la commande suivante :
```sh
vagrant up
```

Elle a pour but de lancer le script de création du serveur web.

Le script va mettre un certain à s'executer, quand le script aura fini de s'exécuter il affichera ```server: Success```.

Pour vérifier que l'installation du serveur web a bien fonctionné, ouvrez un navigateur, entrez l'ip de votre machine qui s'affiche à la fin de l'installation en dessous de la ligne ```Veuillez notez votre IP quelque part``` cela doit donner 
```sh 
ipmachine 
```
et normalement vous devez atterir sur cette page. ![Test Image 3](img/Capture_serveur-web_browser.png)

Voilà l'installation de votre serveur est un succès.

## Installation du serveur NFS

Pour pouvoir installer le serveur NFS, il vous faudra aller dans le répertoire /serveur-nfs/. 

Une fois dans le répertoire, vous verrez deux fichiers (VagrantFile et provision.sh) qui serviront à faire nos install.

Il faudra ouvrir une "invit de command bash". Pour cela faite un clic droit avec votre souris et cliquer sur "Git bash here" (voir image).![Test Image 1](img/Capture_serveur-web.png)

Une fenêtre va alors s'ouvrir (voir image) ![Test Image 2](img/Capture_serveur-jenkins_bash.png) taper la commande suivante :
```sh
vagrant up
```

Elle a pour but de lancer le script de création du serveur NFS;

Le script va mettre un certain à s'executer, quand le script aura fini de s'exécuter il affichera ```server: Success```.

Pour vérifier que l'installation du serveur web a bien fonctionné, ouvrez un navigateur, entrez l'ip de votre machine qui s'affiche à la fin de l'installation en dessous de la ligne ```Veuillez notez votre IP quelque part``` cela doit donner 
```sh 
ipmachine 
```
et normalement vous devez atterir sur cette page. ![Test Image 3](img/Capture_serveur-web_browser.png)

Voilà l'installation de votre serveur nfs est un succès.


## dos2unix

Sauvegarde sur le serveur nfs chaque minute
Archivage tous les 5 minutes