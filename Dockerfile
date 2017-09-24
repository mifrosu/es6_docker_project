# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
# a list of version numbers.
#FROM phusion/passenger-full:<VERSION>
# Or, instead of the 'full' variant, use one of these:
FROM phusion/passenger-ruby24:0.9.24

# Set correct environment variables.

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...

# Replace node with node 6.x
RUN echo 'deb https://deb.nodesource.com/node_6.x xenial main' > /etc/apt/sources.list.d/nodesource.list && \
echo 'deb-src https://deb.nodesource.com/node_6.x xenial main' >> /etc/apt/sources.list.d/nodesource.list
RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -

# Upgrade the packages, keep old config
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold" && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV RAILS_ENV="development"
ENV TERM=xterm

RUN locale-gen en_GB.UTF-8
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en

# RUN apt-get install -y \
#  mysql-client git-core curl zlib1g-dev build-essential libssl-dev \
#  libreadline-dev libyaml-dev libxml2-dev \
#  libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

## Container directory for volume link
RUN mkdir /u && \
mkdir -p /etc/my_init.d

## enable the local nginx instance
RUN rm -f /etc/service/nginx/down && rm /etc/nginx/sites-enabled/default
RUN ln -s  /u/project/conf/project.conf /etc/nginx/sites-enabled/project.conf
#RUN ln -s  /u/config/setup.sh /etc/my_init.d/setup

RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc && gem install bundler

## the image source
# COPY ./app_files /home/app/app_files/

RUN adduser --uid 1000 --disabled-password --gecos "" appuser

WORKDIR /u/project

# Install node and global gulp
RUN apt-get update && apt-get install -y nodejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN npm install -g gulp eslint

# Clean up APT
