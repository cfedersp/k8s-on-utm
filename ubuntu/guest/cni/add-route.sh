#!/bin/bash

SUBNETNUM=$((16*$1))
SUBNET=\"10.65.$SUBNETNUM.0/20\"
cat /etc/cni/net.d/11-crio-ipv4-bridge.conflist | jq '.plugins[0].ipam.routes |= .+ [{"dst":$subnet, "gw":"192.168.64.23"}]' --arg subnet $SUBNET

