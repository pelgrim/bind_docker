#!/bin/bash

debug(){
  local debug_msg=$1
  if [ ! -z "$DEBUG" ]; then
    echo "[DEBUG] $debug_msg"
  fi
}

copy_conf_file(){
  debug "copying named.conf.local to bind conf dir..."
  cp /data/named.conf.local /etc/bind/
}

create_link_to_zone_files(){
  debug "creating symbolic link to the zone files..."
  for db_file in $(ls /data/db.*); do
    ln -s $db_file /var/cache/bind/
  done
}

start_named(){
  debug "starting named..."
  named -f -u bind
}

main(){
  copy_conf_file
  create_link_to_zone_files
  start_named
}

main
