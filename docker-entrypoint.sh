#!/bin/bash

# replace hostname and mailname by the current values
if [ ! -f /tmp/ssmtp_init ];
then
  sed -i s/mailhub=mail/mailhub=$SMTP_HOST/ /etc/ssmtp/ssmtp.conf
  sed -i "/^hostname/ c\hostname=`hostname -f`" /etc/ssmtp/ssmtp.conf
  touch /tmp/ssmtp_init
fi

cron -f
