#!/usr/bin/python
#coding: utf-8
# PYTHON_ARGCOMPLETE_OK

PROG_DESCRIPTION = '''
    Docker Development Environment
'''

import os,sys,subprocess
scriptDir = os.path.dirname(os.path.realpath(__file__))
sys.path.append( scriptDir )
from importFile import importFile
containers = importFile( "%s/containers.py" % scriptDir ).containers

RUN_TEMPLATE = "%s/runTemplate.sh" % scriptDir

def getImgName( contName ):
    return containers[contName]["image"]["name"]


def genRunCommand( contName ):
    image  = containers[contName]["image"]
    cmd = "/usr/bin/docker run"
    cmd += " --interactive"
    cmd += " --privileged"
    cmd += " --tty=true"
    cmd += " --rm=true"
    cmd += " -e DISPLAY=$DISPLAY"
    cmd += " --workdir=/home/ddeusr/workdir"
    cmd += " -v=/tmp/.X11-unix:/tmp/.X11-unix"
    cmd += " -v=$(pwd):/home/ddeusr/workdir"
    cmd += " -v=/dev/bus/usb:/dev/bus/usb"
    cmd += " %s" % getImgName(contName)
    return cmd


def call( cmd ):
    return subprocess.check_call( cmd , shell=True )


if __name__ == "__main__":

    sys.stderr.write( "WARNING - ALPHA VERSION UNDER HEAVY DEVELOPMENT !\n" )

    contName = "dummy"

    runCmd = genRunCommand( contName )

    runScript = "run%s.sh" % contName

    fRun = open( runScript , "w" )
    for line in open( RUN_TEMPLATE , "r" ):
        fRun.write(line)
    fRun.write( runCmd )
    fRun.close()

    print "written fRun:%s" % runScript
    
    call( "bash %s" % runScript )

