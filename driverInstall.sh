#!/bin/bash

echo "Actualizando el sistema..."
sudo pacman -Syu --noconfirm

echo "Instalando drivers Intel..."
sudo pacman -S --noconfirm mesa libva-intel-driver intel-media-driver vulkan-intel

echo "Instalando drivers Nvidia (para GPU híbrida)..."
sudo pacman -S --noconfirm nvidia nvidia-utils nvidia-settings lib32-nvidia-utils vulkan-icd-loader lib32-vulkan-icd-loader

echo "Instalando herramientas PRIME para GPUs híbridas..."
sudo pacman -S --noconfirm nvidia-prime

echo "Regenerando initramfs..."
sudo mkinitcpio -P

echo "Actualizando grub si existe..."
if [ -f /boot/grub/grub.cfg ]; then
    sudo grub-mkconfig -o /boot/grub/grub.cfg
fi

echo "Creando archivo xorg para Nvidia PRIME..."
sudo mkdir -p /etc/X11/xorg.conf.d
cat <<EOF | sudo tee /etc/X11/xorg.conf.d/10-nvidia-prime.conf
Section "ServerLayout"
    Identifier "layout"
    Screen 0 "nvidia"
    Inactive "intel"
EndSection

Section "Device"
    Identifier "nvidia"
    Driver "nvidia"
    BusID "PCI:1:0:0"
    Option "AllowEmptyInitialConfiguration"
EndSection

Section "Screen"
    Identifier "nvidia"
    Device "nvidia"
EndSection

Section "Device"
    Identifier "intel"
    Driver "modesetting"
    BusID "PCI:0:2:0"
EndSection
EOF

echo "Instalación completada. Reinicia tu sistema para aplicar los cambios."
