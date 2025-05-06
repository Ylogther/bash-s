#!/bin/bash

# Archivo que contiene el estado de carga
BAT_STATUS_FILE="/sys/class/power_supply/BAT1/status"
# Estado anterior (inicialmente vacío)
PREV_STATUS=""

while true; do
    CUR_STATUS=$(cat "$BAT_STATUS_FILE")
    if [ "$CUR_STATUS" != "$PREV_STATUS" ]; then
        notify-send "Estado de batería" "Estado cambiado: $CUR_STATUS"
        PREV_STATUS="$CUR_STATUS"
    fi
    sleep 20  # Tiempo entre chequeos (puedes ajustarlo)
done
