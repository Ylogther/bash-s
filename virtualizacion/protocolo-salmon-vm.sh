#!/bin/bash

set -e

VM_ROOT="$HOME/VMs"
SUBVOL_NAME="VMs"

# Obtener el dispositivo raíz y punto de montaje
ROOT_MOUNT_POINT="/"
DEVICE=$(findmnt -no SOURCE "$ROOT_MOUNT_POINT")

# Crear carpeta base si no existe
mkdir -p "$VM_ROOT"

# Crear subvolumen dentro del dispositivo raíz Btrfs
echo "📁 Creando subvolumen $SUBVOL_NAME dentro de $ROOT_MOUNT_POINT..."
if sudo btrfs subvolume show "$VM_ROOT" &> /dev/null; then
    echo "✔️ Subvolumen $SUBVOL_NAME ya existe."
else
    sudo btrfs subvolume create "$VM_ROOT"
fi

# Obtener UUID
UUID=$(blkid -s UUID -o value "$DEVICE")

# Entrada para fstab con subvolumen correcto
FSTAB_ENTRY="UUID=$UUID $VM_ROOT btrfs subvol=$SUBVOL_NAME,noatime,compress=no 0 0"

if ! grep -Fxq "$FSTAB_ENTRY" /etc/fstab; then
  echo "📄 Añadiendo entrada a /etc/fstab..."
  echo "$FSTAB_ENTRY" | sudo tee -a /etc/fstab
else
  echo "✔️ Entrada ya existente en /etc/fstab"
fi

# Montar subvolumen
echo "🔧 Montando subvolumen $SUBVOL_NAME en $VM_ROOT..."
sudo mount "$VM_ROOT" || echo "⚠️ Ya está montado o ocurrió un error."

# Crear estructura para ISOs y VMs
echo "📁 Creando carpetas $VM_ROOT/isos y $VM_ROOT/vms..."
mkdir -p "$VM_ROOT/isos" "$VM_ROOT/vms"

# Configurar libvirt
echo "🔌 Habilitando e iniciando libvirtd..."
sudo systemctl enable --now libvirtd.service
sudo usermod -aG libvirt "$USER"

echo "ℹ️ Para aplicar los permisos de grupo libvirt, cierra y vuelve a iniciar sesión o ejecuta: newgrp libvirt"

# Instalar dependencias base
echo "📦 Instalando virt-manager, qemu y herramientas de red..."
sudo pacman -S --noconfirm virt-manager qemu vde2 dnsmasq bridge-utils openbsd-netcat

# Preguntar si quiere crear VM de prueba
read -p "¿Quieres crear una VM de prueba ahora? (s/n): " CREAR_VM

if [[ "$CREAR_VM" =~ ^[sS]$ ]]; then
    echo "⚙️ Preparando creación de VM..."
    echo "💡 Descarga o copia la ISO a $VM_ROOT/isos antes de continuar."

    read -p "Ruta absoluta de la ISO (ejemplo: $VM_ROOT/isos/debian.iso): " ISO_PATH
    if [[ ! -f "$ISO_PATH" ]]; then
        echo "❌ Archivo ISO no encontrado en $ISO_PATH"
        exit 1
    fi

    read -p "Nombre para la VM: " VM_NAME

    virt-install \
        --name "$VM_NAME" \
        --ram 4096 \
        --vcpus 2 \
        --disk path="$VM_ROOT/vms/${VM_NAME}.qcow2",size=20 \
        --os-type linux \
        --os-variant generic \
        --network network=default \
        --graphics spice \
        --cdrom "$ISO_PATH"
else
    echo "📌 Puedes usar virt-manager para crear VMs manualmente cuando quieras."
fi

echo -e "\n✅ Configuración completa."
