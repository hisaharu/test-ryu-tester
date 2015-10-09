FROM ubuntu:14.04.2

RUN : \
 && apt-get update \
 && apt-get install -y \
        git \
        python-dev \
        python-pip \
        python-virtualenv \
        libxslt1-dev \
        libxml2-dev \
        build-essential \
        zlib1g-dev \
 && :
RUN : \
 && apt-get install -y\
        python-eventlet \
        python-lxml \
        python-paramiko \
 && :

COPY test.sh /test.sh
