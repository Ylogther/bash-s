#!/bin/bash

NETWORK="3A2"
INTERFACE="wlan0"

while true; do
    if ! ping -c 1 8.8.8.8 &>/dev/null; then
        echo "$(date): Conexión perdida. Reiniciando interfaz..."
        
        nmcli device disconnect "$INTERFACE"
        sleep 2
        
        nmcli device set "$INTERFACE" managed yes
        sleep 2
        
        nmcli device connect "$INTERFACE"
        sleep 2

        echo "Reconectando a $NETWORK..."
        nmcli con up "$NETWORK" ifname "$INTERFACE"

        sleep 10
    fi
    sleep 20
done
