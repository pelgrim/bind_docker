#!/bin/bash

debug(){
  local debug_msg=$1
  if [ ! -z "$DEBUG" ]; then
    echo "[DEBUG] $debug_msg"
  fi
}

copy_conf_files(){
  debug "copying named.conf.local to bind conf dir..."
  cp /data/named.conf.log /etc/bind/
  cp /data/named.conf.local /etc/bind/
}

fix_zone_files_permission() {
  debug "fixing zone files permissions..."
  chgrp bind "/data/db.*"
  chmod g+rw "/data/db.*"
}

create_link_to_zone_files(){
  debug "creating symbolic link to the zone files..."
  for db_file in $(ls /data/db.*); do
    ln -s $db_file /var/lib/bind/
  done
}

fix_ddns_key_permission() {
  debug "fixing ddns key file permission..."
  if [ -f "/data/ddns.key" ]; then
    chgrp bind "/data/ddns.key"
  fi
}

start_named(){
  debug "starting named..."
  named -f -u bind
}

main(){
  copy_conf_files
  fix_zone_files_permission
  create_link_to_zone_files
  fix_ddns_key_permission
  start_named
}

main
