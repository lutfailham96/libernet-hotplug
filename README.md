# libernet-hotplug
Simple hotplug to auto start Libernet if main connection from WAN is ready/link status is up

## Prerequisites
- Please disable/uncheck Libernet feature `Auto start on boot`, because it will be conflicted with this Libernet hotplug

## Installation
- Run installation script:
```sh
bash -c "$(curl -sko - 'https://raw.githubusercontent.com/lutfailham96/libernet-hotplug/main/install.sh')"
```
## Configuration
- Configuration file are located in `/etc/config/libernet`
- Update `main_network_interface` value based on your current network setting
