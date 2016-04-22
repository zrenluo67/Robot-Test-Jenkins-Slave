FROM ubuntu:trusty
#FROM parisi/firefox-ubuntu-vnc
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

MAINTAINER Mark Garratt <mgarratt@gmail.com>
RUN apt-get -y update
RUN apt-get install -y -q software-properties-common wget

RUN add-apt-repository -y ppa:mozillateam/firefox-next
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list

RUN apt-get update -y
RUN apt-get install -y -q \
  supervisor \
  firefox \
  git \
  google-chrome-stable \
  openjdk-7-jre-headless \
  openssh-server \
  nodejs \
  x11vnc \
  xvfb \
  xfonts-100dpi \
  xfonts-75dpi \
  xfonts-scalable \
  xfonts-cyrillic

RUN apt-get -y install wget \
 && wget https://bootstrap.pypa.io/get-pip.py \
 && python get-pip.py \
 && pip install robotframework \
 && pip install robotframework-selenium2library requests

RUN apt-get update
RUN apt-get -y install xvfb

RUN useradd -d /home/jenkins -s /bin/bash -m jenkins
RUN echo "jenkins:jenkins" | chpasswd
RUN touch /home/jenkins/.hushlogin

# fix https://code.google.com/p/chromium/issues/detail?id=318548
RUN mkdir -p /usr/share/desktop-directories

RUN mkdir -p /var/run/sshd

COPY ./configs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./configs/sshd_config /etc/ssh/sshd_config
COPY webtest.robot /tmp/

RUN npm install -g selenium-standalone

# Needed for build (should be second Dockerfile)
RUN apt-get install -y -q \
  curl \
  php5 \
  php5-cli \
  php5-common \
  php5-curl \
  php5-gd \
  php5-mcrypt \
  php5-xsl \
  php5-sqlite \
  php-pear
RUN ln -s /etc/php5/mods-available/mcrypt.ini /etc/php5/cli/conf.d/20-mcrypt.ini

RUN php -r "readfile('https://getcomposer.org/installer');" | php
RUN mv composer.phar /usr/local/bin/composer

RUN echo "root:root" | chpasswd

EXPOSE 22 4444 5900
ENTRYPOINT ["/usr/bin/supervisord"]

#RUN apt-get update && apt-get install -y openssh-server
#RUN mkdir /var/run/sshd
#RUN echo 'root:screencast' | chpasswd
#RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
#RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

#ENV NOTVISIBLE "in users profile"
#RUN echo "export VISIBLE=now" >> /etc/profile

#EXPOSE 22
#CMD ["/usr/sbin/sshd", "-D"]
