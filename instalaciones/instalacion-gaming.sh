#!/bin/bash

echo "=== ACTUALIZANDO EL SISTEMA ==="
sudo pacman -Syu --noconfirm

echo "=== INSTALANDO DRIVERS INTEL Y NVIDIA ==="
sudo pacman -Sy --noconfirm mesa libva-intel-driver libva-utils vulkan-intel
sudo pacman -Sy --noconfirm nvidia nvidia-utils nvidia-settings nvidia-prime
sudo pacman -Sy --noconfirm vulkan-icd-loader vulkan-tools
sudo systemctl enable nvidia-persistenced.service
sudo systemctl start nvidia-persistenced.service

echo "=== INSTALANDO WINE, PROTONTRICKS Y WINETRICKS ==="
sudo pacman -Sy --noconfirm wine winetricks 

echo "=== INSTALANDO STEAM ==="
sudo pacman -Sy --noconfirm steam steam-native-runtime

echo "=== INSTALANDO LUTRIS ==="
sudo pacman -Sy --noconfirm lutris

echo "=== INSTALANDO FLATPAK Y HEROIC GAMES LAUNCHER ==="
sudo pacman -Sy --noconfirm flatpak
flatpak install flathub com.heroicgameslauncher.hgl -y

echo "=== INSTALANDO PROTONUP-QT (gestor de Proton GE) ==="
flatpak install flathub net.davidotek.pupgui2 -y

echo "=== INSTALANDO MANGOHUD Y GOVERLAY ==="
sudo pacman -Sy --noconfirm mangohud goverlay

echo "=== INSTALANDO GAMEMODE ==="
sudo pacman -Sy --noconfirm gamemode

echo "=== INSTALANDO PIPEWIRE PARA AUDIO ==="
sudo pacman -Sy --noconfirm pipewire pipewire-audio pipewire-alsa pipewire-pulse wireplumber

echo "=== INSTALANDO SOPORTE PARA GAMEPADS ==="
sudo pacman -Sy --noconfirm game-devices-udev

echo "=== TODO COMPLETO. REINICIA TU SISTEMA PARA APLICAR LOS CAMBIOS. ==="
