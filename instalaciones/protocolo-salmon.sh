#!/bin/bash

# === Protocolo Salmón ===
# Crea subvolumen Btrfs sin compresión para VMs

# Ruta donde estará el subvolumen
VM_DIR="$HOME/VMs"
SUBVOL_NAME="VMs"
MOUNTPOINT="$VM_DIR"
DEVICE=$(findmnt -no SOURCE /)

# Crear carpeta si no existe
mkdir -p "$VM_DIR"

# Crear subvolumen
sudo btrfs subvolume create "$MOUNTPOINT"

# Obtener UUID del dispositivo Btrfs raíz
UUID=$(blkid -s UUID -o value "$DEVICE")

# Entrada fstab
FSTAB_ENTRY="UUID=$UUID $MOUNTPOINT btrfs subvol=$SUBVOL_NAME,noatime,compress=no 0 0"

# Agregar entrada si no existe
if ! grep -Fxq "$FSTAB_ENTRY" /etc/fstab; then
  echo "Añadiendo entrada al fstab..."
  echo "$FSTAB_ENTRY" | sudo tee -a /etc/fstab
else
  echo "Entrada ya existente en fstab."
fi

# Montar subvolumen
echo "Montando subvolumen..."
sudo mount "$MOUNTPOINT"

# Confirmar montaje
mount | grep "$MOUNTPOINT"

echo -e "\n✅ Protocolo Salmón completado. Subvolumen sin compresión montado en $MOUNTPOINT"
