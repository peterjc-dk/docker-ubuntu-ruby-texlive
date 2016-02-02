FROM peterjc/ubuntu-ruby
MAINTAINER Harsh Vakharia <harshjv@gmail.com>

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

RUN apt-add-repository multiverse
RUN apt-get update && apt-get install -y wget

# Install the SWF toolkit
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --force-yes install swftools

# Install MS-fonts a
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
RUN apt-get install -y --quiet ttf-mscorefonts-installer

ADD https://raw.githubusercontent.com/harshjv/docker-texlive-2015/master/install-tl-ubuntu install-tl-ubuntu
RUN chmod +x install-tl-ubuntu 

RUN ./install-tl-ubuntu -a

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* \
           /tmp/* \
           /var/tmp/*

ENV PATH /opt/texbin:$PATH

VOLUME /var/texlive

WORKDIR /var/texlive