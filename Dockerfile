FROM debian:buster

MAINTAINER kaname, <kaname.netlify.app>

RUN apt update \
    && apt upgrade -y \
    && apt -y install curl software-properties-common locales git \
    && apt-get install -y default-jre \
    && useradd -d /home/container -m container \
    && apt-get update \
    && apt-get install -yq libgconf-2-4 \
    && apt-get -y install libnss3-dev libxss1 libgbm-dev \
    && apt-get -y install pkg-config

    # NodeJS
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    && apt -y install nodejs \
    && apt -y install ffmpeg \
    && apt -y install make \
    && apt -y install build-essential \
    && apt -y install wget \ 
    && apt -y install curl \
    && apt -y install yarn

    # Python 2 & 3
RUN apt -y install python python-pip python3 python3-pip
    
    # Install basic software support
RUN apt-get update && \
    apt-get install --yes software-properties-common

    # Grant sudo permissions to container user for commands
RUN apt-get update && \
    apt-get -y install sudo
    
    # Ensure UTF-8
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
RUN locale-gen en_US.UTF-8

    # Configuration
USER container
ENV  USER container
ENV  HOME /home/container
WORKDIR /home/container
COPY ./entrypoint.sh /entrypoint.sh

    # Init
CMD ["/bin/bash", "/entrypoint.sh"]
