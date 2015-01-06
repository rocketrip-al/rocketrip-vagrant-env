#! /bin/bash

#
# Install app dependencies for Debian/Ubuntu environment.
#

# Vagrant runs this as sudo.

# Update the system
apt-get update

# Avoid the prompts when installing mysql
export DEBIAN_FRONTEND=noninteractive

# Install packages that we need/want
apt-get install -yq \
    build-essential \
    python-dev \
    curl \
    git \
    libmysqlclient-dev \
    mysql-server \
    python-pip \
    rabbitmq-server \
    tmux \
    vim \
    --no-install-recommends

# Need to upgrade `distribute` before pip can install Django.
easy_install -U distribute 

