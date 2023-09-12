# https://hub.docker.com/_/debian
FROM debian:bookworm

# add proper Debian sources
RUN rm /etc/apt/sources.list.d/debian.sources
COPY conf/bookworm.sources.list /etc/apt/sources.list

RUN apt update && apt install -y procps wget unzip apache2

# remove for production
RUN apt install -y bash

# add Ondrej Sury php repository
RUN wget https://packages.sury.org/php/apt.gpg -O /usr/share/keyrings/deb.sury.org-php.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ bullseye main" > /etc/apt/sources.list.d/php.list

RUN apt update && apt install -y libapache2-mod-php7.4 php7.4-gd php7.4-mbstring php7.4-mysql

# download piwigo
RUN wget "https://piwigo.org/download/dlcounter.php?code=13.8.0" -O /tmp/piwigo.zip
# extract piwigo
RUN cd /var/www/ && rm -rf html && unzip /tmp/piwigo.zip && mv -f piwigo html

COPY conf/000-default.conf /etc/apache2/sites-available/

EXPOSE 80
CMD apachectl -D FOREGROUND
