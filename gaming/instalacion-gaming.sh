#!/bin/bash

# Colores
GREEN='\e[32m'
RED='\e[31m'
YELLOW='\e[33m'
RESET='\e[0m'

# Función para mostrar título
titulo() {
    echo -e "\n${YELLOW}=== $1 ===${RESET}"
}

# Verificar si se está ejecutando como root
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}Este script debe ejecutarse como root. Usa 'sudo ./nombre.sh'${RESET}"
    exit 1
fi

# Actualizar sistema
titulo "ACTUALIZANDO EL SISTEMA"
pacman -Syu --noconfirm || { echo -e "${RED}Error actualizando el sistema.${RESET}"; exit 1; }

# Instalar drivers Intel y NVIDIA
titulo "INSTALANDO DRIVERS INTEL Y NVIDIA"
pacman -S --noconfirm \
    mesa libva-intel-driver libva-utils vulkan-intel \
    nvidia nvidia-utils nvidia-settings nvidia-prime \
    vulkan-icd-loader vulkan-tools

systemctl enable nvidia-persistenced.service
systemctl start nvidia-persistenced.service

# Wine y herramientas
titulo "INSTALANDO WINE Y WINETRICKS"
pacman -S --noconfirm wine winetricks

# Steam
titulo "INSTALANDO STEAM"
pacman -S --noconfirm steam steam-native-runtime

# Lutris
titulo "INSTALANDO LUTRIS"
pacman -S --noconfirm lutris

# Flatpak + Heroic
titulo "INSTALANDO FLATPAK Y HEROIC GAMES LAUNCHER"
pacman -S --noconfirm flatpak
flatpak install -y flathub com.heroicgameslauncher.hgl

# ProtonUp-QT
titulo "INSTALANDO PROTONUP-QT"
flatpak install -y flathub net.davidotek.pupgui2

# MangoHUD y GOverlay
titulo "INSTALANDO MANGOHUD Y GOVERLAY"
pacman -S --noconfirm mangohud goverlay

# GameMode
titulo "INSTALANDO GAMEMODE"
pacman -S --noconfirm gamemode

# Audio con PipeWire
titulo "INSTALANDO PIPEWIRE"
pacman -S --noconfirm pipewire pipewire-audio pipewire-alsa pipewire-pulse wireplumber

# Soporte gamepads
titulo "INSTALANDO SOPORTE PARA GAMEPADS"
pacman -S --noconfirm game-devices-udev

# Final
titulo "TODO COMPLETO. REINICIA TU SISTEMA PARA APLICAR LOS CAMBIOS."
