#! /bin/bash

#
# Install app dependencies for Debian/Ubuntu environment.
#

# Vagrant runs this as sudo.

PIP_URL="https://bootstrap.pypa.io/get-pip.py"

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
    rabbitmq-server

# python-pip is broken if we install from apt-get
# http://askubuntu.com/questions/561377/pip-wont-run-throws-errors-instead
wget $PIP_URL
python get-pip.py
rm get-pip.py

gem install sass

# Nice to have
apt-get install -yq --no-install-recommends \
    tmux \
    vim \
    ipython

# Need to upgrade `distribute` before pip can install Django.
easy_install -U distribute 

