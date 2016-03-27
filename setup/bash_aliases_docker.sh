# small bash aliases to ease docker usage

# docker rm all
function dra (){
    containers=$(docker ps -aq)
    if [ "$containers" != "" ]; then
        docker rm -f $containers
    else
        echo "nothing to do: no containers"
    fi
}

# docker start & attach
function dsa (){
    docker start $1 && docker attach $1
}

# docker run
function dr (){
    docker run --net none --privileged --interactive -t $1
}

# docker status
function dst (){
    echo "***** DISK USAGE *****"
    sudo bash -c "/usr/bin/du -h --max-depth=0 /var/lib/docker/aufs"
    echo "***** IMAGES *****"
    docker images
    echo "***** CONTAINERS *****"
    docker ps -a
}

# docker build
function db (){
    docker build -t $1 .
}

# docker clean cache : removes all cached images
function dcc() {
#    read -p "warning: you are about to clean all <none> images, are you sure ? (y/n) " yn
#    if [ "$yn" == "y" ]; then
        docker rmi $(docker images -q --filter "dangling=true")
#    fi
}

# docker alias help
function dh (){
    echo "db  - docker build          (docker build -t \$1 .)"
    echo "dr  - docker run            (docker run --net none --privileged --interactive -t \$1)"
    echo "dsa - docker start & attach (docker start \$1 && docker attach \$1)"
    echo "dst - docker status         (docker images ; docker ps -a)"
    echo "dra - docker rm all         (docker rm -f \$(docker ps -aq))"
    echo "dcc - docker clean cache    (docker images -q --filter 'dangling=true')"
}
