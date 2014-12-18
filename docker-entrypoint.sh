#!/bin/bash
#
# El objetivo es parametrizar el contenedor cada vez que se ejecuta
#

###################################################################################
#
if [ ! -d /backup ];
then
	echo "error, no existe el directorio /backup"
	exit 255
else
    echo "Correcto: El directorio /backup existe"
fi

###################################################################################
# Pongo mi nombre de host al mandar emails
#
if [ -z "${RBME_HOSTNAME}" ];
then
	MI_HOSTNAME=`hostname -f`
	if [ -z "${MI_HOSTNAME}" ];
	then 
		echo "error, no tengo nombre de Host, usar RBME_HOSTNAME o -h <nombre>"
		exit 255
	else 
		RBME_HOSTNAME=${MI_HOSTNAME}
	fi
fi
if [ -n "${RBME_HOSTNAME}" ];
then
  sed -i "/^hostname/ c\hostname=${RBME_HOSTNAME}" /etc/ssmtp/ssmtp.conf
  sed -i "/^MAILFROM/ c\MAILFROM=root@${RBME_HOSTNAME}" /etc/rbme.conf  
  echo "RBME_HOSTNAME: ${RBME_HOSTNAME}"
fi

###################################################################################
# Guardo el nombre del smtp server
#
if [ -n "${RBME_SMTP_HOST}" ];
then
  sed -i "/^mailhub=/ c\mailhub=${RBME_SMTP_HOST}" /etc/ssmtp/ssmtp.conf
  echo "RBME_SMTP_HOST: ${RBME_SMTP_HOST}"
fi

###################################################################################
# Cambio el MAILTO en rbme.conf
#
if [ -n "${RBME_MAILTO}" ];
then
  sed -i "/^MAILTO=/ c\MAILTO=${RBME_MAILTO}" /etc/rbme.conf
  echo "RBME_MAILTO: ${RBME_MAILTO}"
fi

###################################################################################
# Mínimo tamaño libre en el disco de backup antes de iniciarlo
#
if [ -n "${RBME_MIN_FREE_BEFORE_HOST_BACKUP}" ];
then
  sed -i "/^MIN_FREE_BEFORE_HOST_BACKUP=/ c\MIN_FREE_BEFORE_HOST_BACKUP=${RBME_MIN_FREE_BEFORE_HOST_BACKUP}" /etc/rbme.conf
  echo "RBME_MIN_FREE_BEFORE_HOST_BACKUP: ${RBME_MIN_FREE_BEFORE_HOST_BACKUP}"
fi
###################################################################################
# Mínimo tamaño libre en el disco de backup antes de iniciarlo
#
if [ -n "${RBME_MIN_INODES_BEFORE_HOST_BACKUP}" ];
then
  sed -i "/^MIN_INODES_BEFORE_HOST_BACKUP=/ c\MIN_INODES_BEFORE_HOST_BACKUP=${RBME_MIN_INODES_BEFORE_HOST_BACKUP}" /etc/rbme.conf
  echo "RBME_MIN_INODES_BEFORE_HOST_BACKUP: ${RBME_MIN_INODES_BEFORE_HOST_BACKUP}"
fi
###################################################################################
# Mínimo tamaño libre en el disco de backup antes de iniciarlo
#
if [ -n "${RBME_MIN_FREE_AFTER_HOST_BACKUP}" ];
then
  sed -i "/^MIN_FREE_AFTER_HOST_BACKUP=/ c\MIN_FREE_AFTER_HOST_BACKUP=${RBME_MIN_FREE_AFTER_HOST_BACKUP}" /etc/rbme.conf
  echo "RBME_MIN_FREE_AFTER_HOST_BACKUP: ${RBME_MIN_FREE_AFTER_HOST_BACKUP}"
fi
###################################################################################
# Mínimo tamaño libre en el disco de backup antes de iniciarlo
#
if [ -n "${RBME_MIN_INODES_AFTER_HOST_BACKUP}" ];
then
  sed -i "/^MIN_INODES_AFTER_HOST_BACKUP=/ c\MIN_INODES_AFTER_HOST_BACKUP=${RBME_MIN_INODES_AFTER_HOST_BACKUP}" /etc/rbme.conf
  echo "RBME_MIN_INODES_AFTER_HOST_BACKUP: ${RBME_MIN_INODES_AFTER_HOST_BACKUP}"
fi
###################################################################################
# Mínimo tamaño libre en el disco de backup antes de iniciarlo
#
if [ -n "${RBME_MIN_KEEP_OLD_BACKUPS}" ];
then
  sed -i "/^MIN_KEEP_OLD_BACKUPS=/ c\MIN_KEEP_OLD_BACKUPS=${RBME_MIN_KEEP_OLD_BACKUPS}" /etc/rbme.conf
  echo "RBME_MIN_KEEP_OLD_BACKUPS: ${RBME_MIN_KEEP_OLD_BACKUPS}"
fi
###################################################################################
# Mínimo tamaño libre en el disco de backup antes de iniciarlo
#
if [ -n "${RBME_RSYNC_RSH}" ];
then
  sed -i "/^RSYNC_RSH=/ c\RSYNC_RSH=${RBME_RSYNC_RSH}" /etc/rbme.conf
  echo "RBME_RSYNC_RSH: ${RBME_RSYNC_RSH}"
fi


exit

cron -f
