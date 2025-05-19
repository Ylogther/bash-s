#!/bin/bash

set -e

VM_DIR="$HOME/VMs"
SUBVOL_NAME="VMs"
MOUNTPOINT="$VM_DIR"

# Obtener dispositivo raíz del sistema (ej. /dev/sda2)
DEVICE=$(findmnt -no SOURCE /)

# Crear directorio para montar el subvolumen si no existe
mkdir -p "$MOUNTPOINT"

# Comprobar si el subvolumen ya existe
if sudo btrfs subvolume show "/$SUBVOL_NAME" &>/dev/null; then
    echo "✔️ El subvolumen '$SUBVOL_NAME' ya existe."
else
    echo "📁 Creando subvolumen '$SUBVOL_NAME' en la raíz Btrfs..."
    sudo btrfs subvolume create "/$SUBVOL_NAME"
fi

# Obtener UUID del dispositivo raíz
UUID=$(blkid -s UUID -o value "$DEVICE")

# Preparar entrada para fstab
FSTAB_ENTRY="UUID=$UUID $MOUNTPOINT btrfs subvol=$SUBVOL_NAME,noatime,compress=no 0 0"

# Añadir la entrada a fstab si no existe
if ! grep -Fxq "$FSTAB_ENTRY" /etc/fstab; then
    echo "📄 Añadiendo entrada a /etc/fstab..."
    echo "$FSTAB_ENTRY" | sudo tee -a /etc/fstab
else
    echo "✔️ Entrada ya existente en /etc/fstab."
fi

# Montar el subvolumen
echo "🔧 Montando subvolumen '$SUBVOL_NAME' en '$MOUNTPOINT'..."
sudo mount "$MOUNTPOINT"

# Verificar montaje
mount | grep "$MOUNTPOINT"

echo -e "\n✅ Protocolo Salmón completado. Subvolumen montado en $MOUNTPOINT"

