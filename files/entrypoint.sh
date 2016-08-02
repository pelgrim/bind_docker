#!/bin/bash

debug(){
  local debug_msg=$1
  if [ ! -z "$DEBUG" ]; then
    echo "[DEBUG] $debug_msg"
  fi
}

main(){
  debug "copying named.conf.local to bind conf dir..."
  cp /data/named.conf.local /etc/bind/
  debug "starting named..."
  named -f -u bind
}

main
