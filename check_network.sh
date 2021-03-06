#!/bin/bash

echo "ATTENTION: This script needs to be run with root privileges (sudo $0)"
echo

wlan_iface=wlan0
eth_iface=eth0

function get_address() {
  addr=$(ifconfig $1 | grep "inet addr" | cut -d ':' -f 2 | cut -d ' ' -f 1)
  echo "$addr"
}

function check_address() {
  addr=$(get_address $1)

  if [[ $addr =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Interface has valid IP associated!"
  else
    echo "Interface an no valid IP. Attempting to restart interface"
    ifconfig $1 down
    ifconfig $1 up
  fi
}

check_address $wlan_iface
check_address $eth_iface
