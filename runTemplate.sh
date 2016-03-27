#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

die () {
    echo >&2 "$@"
    exit 1
}

checkNotRoot () {
    echo "checking for normal user..."
    if [ $USER == "root" ]; then
        die "error: please run as your user and not as root"
    fi
}


checkRequirements () {
    echo "checking for docker..."
    type docker
    result=$?
    expectedDockVer="Docker version 1.10.3"
    if [ $result != 0 ]; then
        die "error: docker not found"
    else
        foundDockVer=$( \docker --version | sed 's/,.*//' )
        if [ "$foundDockVer" != "$expectedDockVer" ]; then
            die "error: found $foundDockVer, expected $expectedDockVer"
        else
            echo "found $expectedDockVer"
        fi
    fi
}


checkIDs () {
    echo "checking for UID/GID..."
    DOCKDEV_HARDCODED_UID=1000
    DOCKDEV_HARDCODED_GID=1000
    PASSWD=$(cat /etc/passwd | grep $USER)
    CURRENT_UID=$(echo $PASSWD | cut -f3 -d:)
    CURRENT_GID=$(echo $PASSWD | cut -f4 -d:)
    if [[ $CURRENT_UID != $DOCKDEV_HARDCODED_UID || $CURRENT_GID != $DOCKDEV_HARDCODED_GID ]]; then
        die "error: this docker expects your userid:$DOCKDEV_HARDCODED_UID and groupid:$DOCKDEV_HARDCODED_GID , got uid=$CURRENT_UID gid=$CURRENT_GID"
    fi
}

printDiskUsage () {
    diskUsage=$( sudo bash -c "/usr/bin/du -h --max-depth=0 /var/lib/docker/aufs" )
    echo "INFO: your current docker disk usage is: $diskUsage"
}


#
# SCRIPT ENTRY POINT
#
containerName=$0
echo "running $containerName"
checkNotRoot
checkRequirements
checkIDs
printDiskUsage
#
# v - commands appended by dde script - v
#
