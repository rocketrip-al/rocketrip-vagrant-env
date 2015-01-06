#! /bin/bash

#
# Install app dependencies for Debian/Ubuntu environment.
#

# Vagrant runs this as sudo.

# Update the system
apt-get update

# Avoid the prompts when installing mysql
export DEBIAN_FRONTEND=noninteractive

# Install packages that we need
apt-get install -yq --no-install-recommends \
    build-essential \
    python-dev \
    curl \
    git \
    libmysqlclient-dev \
    mysql-server \
    python-pip \
    rabbitmq-server

# Nice to have
apt-get install -yq --no-install-recommends \
    tmux \
    vim \
    ipython

# Need to upgrade `distribute` before pip can install Django.
easy_install -U distribute 

