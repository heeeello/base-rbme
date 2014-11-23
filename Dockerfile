#
# Backup base by Luispa, Nov 2014
#
# -----------------------------------------------------
#
# Contenedor muy simple que se apoya en el script schlomo/rbme
# para hacer backups de sistemas Linux.
#
# Montar el directorio /backup apuntando a un file system dedicado
# a hacer backup y ejecuta cron para arrancar de forma periódica
# el script

# run this container with a couple of volumes mounted. We mount the 
# docker run -v <backupvolume>:/backup -v <.ssh dir>:/root/.ssh/ -v <shellscript>:/etc/cron.daily/rbme_script.sh -h <hostname> dhrp/rbme

# Desde donde parto...
#
FROM debian:latest

#
MAINTAINER Luis Palacios <luis@luispa.com>

# Pido que el frontend de Debian no sea interactivo
ENV DEBIAN_FRONTEND noninteractive

# Actualizo el sistema operativo e instalo paquetes de software
#
RUN apt-get update && \
    apt-get -y install wget \
    				   make \
    				   openssh-server \
    				   rsync \
    				   cron \
    				   procmail \
    				   ssmtplocales \
					   vim-tiny \
                       curl 

# Preparo locales
#
RUN locale-gen es_ES.UTF-8
RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

# Preparo el timezone para Madrid
#
RUN echo "Europe/Madrid" > /etc/timezone; dpkg-reconfigure -f noninteractive tzdata

# Directorios necesarios
RUN mkdir /var/run/sshd 

# Descargo e instalo RBME
ADD https://github.com/schlomo/rbme/raw/master/out/rbme_4_all.deb /usr/src/
RUN dpkg -i /usr/src/rbme_4_all.deb

# Elimino cualquier entrada de CRON existente
RUN rm /etc/cron.daily/*

# Volumen
# VOLUME ["/backup"]

# Copio el comando que se debe ejecutar al arrancar
#
ADD docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
