#!/bin/bash

set -x

if (($EUID == '0')); then
  if [ -z $(awk -F: '{print $4}' /etc/passwd | grep ${PGID})]; then
    addgroup --system --gid ${PGID} stubby
  fi
  if [ -z $(awk -F: '{print $3}' /etc/passwd | grep ${PUID})]; then
    adduser --system --no-create-home -gid ${PGID} --uid ${PUID} stubby
  fi
fi

/bin/touch /etc/authbind/byport/53
/bin/chmod 777 /etc/authbind/byport/53

/sbin/gosu ${PUID}:${PGID} authbind --deep /bin/stubby -C /etc/stubby/stubby.yml