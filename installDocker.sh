#!/bin/bash
# docker-engine installation script for convenience
# instructions from https://docs.docker.com/engine/installation/linux/ubuntulinux/

set -o errexit
set -o nounset
set -o pipefail

die () {
    echo >&2 "$@"
    exit 1
}

while true; do
    read -p "this script will install docker-engine, continue (y/n) ?"  yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

ubuntuVersion=$( lsb_release --release --short )
if [ "$ubuntuVersion" != "15.10" ]; then
    die "unexpected ubuntu version: $ubuntuVersion , expected 15.10"
fi


if [ "$(whoami)" != "root" ]; then
	die "error: please run again as root or with sudo"
fi


apt-get update

apt-get install apt-transport-https ca-certificates

apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo "deb https://apt.dockerproject.org/repo ubuntu-wily main" >> /etc/apt/sources.list.d/docker.list

apt-get update

apt-get purge lxc-docker

apt-cache policy docker-engine

apt-get update

apt-get install linux-image-extra-$(uname -r)

apt-get install docker-engine

service docker start

docker run hello-world

usermod -a -G docker $SUDO_USER

echo "done. Logout, and test by running (as your user, not root): >docker run hello-world"

