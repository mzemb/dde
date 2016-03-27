# dummy file for basic docker env
# based on https://github.com/phusion/baseimage-docker
FROM phusion/baseimage:0.9.18

# Set correct environment variables
ENV HOME /root

# from now on, work in /tmp
WORKDIR /tmp

# set correct timezone (to match with host date)
RUN echo Europe/Paris > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

# relax security permissions
RUN chmod 755 /etc/container_environment
RUN chmod 644 /etc/container_environment.sh /etc/container_environment.json

# disable ssh (not needed)
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# install a package
RUN apt-get update -y && apt-get install -y locate

# setup user
RUN groupadd --gid 1000 ddeusr                             && \
    useradd ddeusr --gid 1000 --uid 1000                   && \
    echo "ddeusr:ddeusr" | chpasswd && adduser ddeusr sudo && \
    mkdir /home/ddeusr                                     && \
    chown -R ddeusr /home/ddeusr                            

# from this point, cmd are executed as user (instead of root)
USER ddeusr
WORKDIR /home/ddeusr
ENV HOME /home/ddeusr
ENV USER ddeusr

# set entry point
CMD bash

