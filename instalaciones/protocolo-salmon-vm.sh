#!/bin/bash

# === Protocolo Salmón + Preparación de VM ===
# Crea subvolumen Btrfs sin compresión para VMs, estructura de carpetas y configura entorno para virt-manager

VM_ROOT="$HOME/VMs"
SUBVOL_NAME="VMs"
DEVICE=$(findmnt -no SOURCE /)

# 1. Crear subvolumen
echo "📁 Creando subvolumen $SUBVOL_NAME..."
mkdir -p "$VM_ROOT"
sudo btrfs subvolume create "$VM_ROOT"

# 2. Obtener UUID del dispositivo raíz
UUID=$(blkid -s UUID -o value "$DEVICE")

# 3. Agregar a /etc/fstab
FSTAB_ENTRY="UUID=$UUID $VM_ROOT btrfs subvol=$SUBVOL_NAME,noatime,compress=no 0 0"

if ! grep -Fxq "$FSTAB_ENTRY" /etc/fstab; then
  echo "📄 Añadiendo entrada a /etc/fstab..."
  echo "$FSTAB_ENTRY" | sudo tee -a /etc/fstab
else
  echo "✔️ Entrada ya existente en fstab."
fi

# 4. Montar el subvolumen
echo "🔧 Montando subvolumen..."
sudo mount "$VM_ROOT"

# 5. Crear estructura de carpetas
echo "📁 Creando estructura: $VM_ROOT/isos y $VM_ROOT/vms"
mkdir -p "$VM_ROOT/isos"
mkdir -p "$VM_ROOT/vms"

# 6. Verificar servicios de libvirt
echo "🔌 Verificando e iniciando libvirtd..."
sudo systemctl enable --now libvirtd.service
sudo usermod -aG libvirt $USER

# 7. Instalar dependencias básicas (opcional)
echo "📦 Instalando virt-manager y herramientas base..."
sudo pacman -S --noconfirm virt-manager qemu vde2 dnsmasq bridge-utils openbsd-netcat

# 8. (Opcional) Preguntar si quiere crear una VM de prueba
read -p "¿Quieres crear una VM de prueba ahora mismo? (s/n): " CREAR_VM

if [[ "$CREAR_VM" == "s" || "$CREAR_VM" == "S" ]]; then
    echo "⚙️ Creando VM de prueba..."
    echo "💡 Asegúrate de haber descargado una ISO a $VM_ROOT/isos antes de continuar."

    read -p "Ruta absoluta de la ISO (por ejemplo: $VM_ROOT/isos/debian.iso): " ISO_PATH
    read -p "Nombre de la VM: " VM_NAME

    virt-install \
        --name "$VM_NAME" \
        --ram 4096 \
        --vcpus 2 \
        --disk path=$VM_ROOT/vms/${VM_NAME}.qcow2,size=20 \
        --os-type linux \
        --os-variant generic \
        --network network=default \
        --graphics spice \
        --cdrom "$ISO_PATH"
else
    echo "📌 Puedes usar virt-manager para crear VMs manualmente más tarde."
fi

echo -e "\n✅ Todo listo. Reinicia sesión para aplicar los permisos del grupo libvirt."
