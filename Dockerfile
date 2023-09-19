# https://hub.docker.com/_/debian
FROM debian:bookworm
MAINTAINER jan@tomasek.cz
ENV DEBIAN_FRONTEND=noninteractive

# add proper Debian sources
COPY conf/bookworm.sources.list /etc/apt/sources.list
COPY conf/entry.sh /

RUN rm /etc/apt/sources.list.d/debian.sources && \
    apt update && \
    apt install -y procps curl unzip apache2 && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/locale/*

# add Ondrej Sury php repository
RUN curl https://packages.sury.org/php/apt.gpg -o /usr/share/keyrings/deb.sury.org-php.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ bullseye main" > /etc/apt/sources.list.d/php.list && \
    apt update && \
    apt install -y libapache2-mod-php7.4 php7.4-gd php7.4-mbstring php7.4-mysql php7.4-xml graphicsmagick-imagemagick-compat && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/locale/*

# download piwigom extract it and clean
RUN curl "https://piwigo.org/download/dlcounter.php?code=13.8.0" -o /tmp/piwigo.zip && \
    cd /var/www/ && \
    unzip /tmp/piwigo.zip && \
    rm /tmp/piwigo.zip && \
    rm -rf html && \
    mv piwigo html && \
    cd html && \
    mkdir /piwigo-init-data && \
    cp -r  galleries upload plugins themes template-extension local _data /piwigo-init-data/

# remove for production
RUN apt install -y bash

COPY conf/000-default.conf /etc/apache2/sites-available/

EXPOSE 80
CMD /entry.sh
