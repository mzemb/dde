# dde

docker development environment - a simple and small wrapper around docker to ease it's usage as a dev env


# summary 

The purpose of DDE is to give you a fully controlled developement environnement.

- strictly identical between developpers 

- versionned ( to reproduced your old dev environments )

- no hidden dependencies ( internet acces is disabled by default, no environment variables )

- disconnected from your system and its updates


# requirements

- bash ( tested on 4.3.42 )

- docker > 1.7 ( tested on 1.10.3 )

- python 2.7.x ( tested on 2.7.10 )

- optionnal: python argcomplete to have nice shell autocomplete with <tab>


# installation

If docker is not already installed on your machine: 

> sudo bash setup/installDocker.sh


Dde itself does not need any installation, you can however add it to your path, or add an alias to it:

alias dde='/home/git/dde.git/dde.py'


Optionnally, I suggest you add the small bash aliases so that docker command lines are more user friendly.


