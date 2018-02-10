FROM ubuntu:16.04

MAINTAINER Caroline Salib <caroline@portabilis.com.br>

RUN apt-get -y update \
    && apt-get install -y 
    curl
    php-curl
    git-core
    apache2
    libapache2-mod-php
    php-pgsql
    php-pear
    php-mbstring
    rpl
    wget
    libreadline6
    libreadline6-dev
    make gcc
    zlib1g-dev 
    --no-install-recommends \
    && a2enmod rewrite \
# Instala pacotes pear
    && pear install XML_RPC2 Mail Net_SMTP Services_ReCaptcha \
    && apt-get clean

COPY ieducar.conf /etc/apache2/sites-available/000-default.conf
CMD a2ensite 000-default.conf

CMD mkdir /var/www/html/i-educar
CMD chmod 777 -R /var/www/html/i-educar
WORKDIR /var/www/html/i-educar

# Instala dependencia relatórios
RUN apt-get install -y software-properties-common python-software-properties \
    && add-apt-repository -y ppa:openjdk-r/ppa \
    && apt-get -y update \
    && apt-get -y install openjdk-7-jdk

CMD update-alternatives --config java

CMD chmod 777 /home/portabilis/ieducar/modules/Reports/ReportSources/

EXPOSE 80

CMD /usr/sbin/apache2ctl -D FOREGROUND

