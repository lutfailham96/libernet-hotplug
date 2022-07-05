#!/bin/bash

# Libernet hotplug installer
# version : v1.0.0
# Author  : Lutfa Ilham

INTERFACE="fibocom" # Please update this default value

while getopts i: flag; do
  case "${flag}" in
    i)
      INTERFACE=${OPTARG}
      ;;
  esac
done

prepare_interface() {
  uci -q get network.${INTERFACE} > /dev/nul || echo -e "Interface not exist" exit 1
}

prepare_workspace() {
  mkdir -p /opt
  [[ ! -f "/opt/libernet" ]] && echo -e "Creating Libernet symlink to /opt" && ln -s /root/libernet/ /opt/libernet
}

install_hotplug() {
  curl -sLko /etc/config/libernet "https://raw.githubusercontent.com/lutfailham96/libernet-hotplug/main/root/etc/config/libernet"
  curl -slko /etc/hotplug.d/iface/99-libernet "https://raw.githubusercontent.com/lutfailham96/libernet-hotplug/main/root/etc/hotplug.d/iface/99-libernet"
}

configure_hotplug() {
  uci -q set libernet.@libernet[0].main_network_interface=${INTERFACE}
  uci commit libernet
}

prepare_interface \
  && prepare_workspace \
  && install_hotplug \
  && configure_hotplug \
  && echo -e "Libernet hotplug installed successfully" \
  || echo -e "Installation was failed"
