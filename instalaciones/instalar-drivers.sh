#!/bin/bash

echo "=== Actualizando el sistema ==="
sudo pacman -Syu --noconfirm

echo "=== Instalando drivers Intel ==="
sudo pacman -S --noconfirm mesa libva-intel-driver libva-utils vulkan-intel

echo "=== Instalando drivers NVIDIA propietarios ==="
sudo pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

echo "=== Instalando soporte Vulkan ==="
sudo pacman -S --noconfirm vulkan-icd-loader vulkan-tools

echo "=== Instalando nvidia-prime para soporte híbrido ==="
sudo pacman -S --noconfirm nvidia-prime

echo "=== Habilitando servicio de persistencia NVIDIA ==="
sudo systemctl enable nvidia-persistenced.service
sudo systemctl start nvidia-persistenced.service

echo "=== Instalación completa. Se recomienda reiniciar el sistema. ==="
