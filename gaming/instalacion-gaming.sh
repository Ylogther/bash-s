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

# Verificar y activar repo multilib en /etc/pacman.conf
titulo "Verificando repositorio multilib en /etc/pacman.conf"

PACMAN_CONF="/etc/pacman.conf"

if grep -q "^\s*#\s*\[multilib\]" "$PACMAN_CONF"; then
    echo "Repositorio [multilib] está comentado, intentando activarlo..."

    if sed -i '/^\s*#\s*\[multilib\]/s/^\s*#\s*//' "$PACMAN_CONF" && \
       sed -i '/^\s*#\s*Include = \/etc\/pacman.d\/mirrorlist/s/^\s*#\s*//' "$PACMAN_CONF"; then
        echo -e "${GREEN}[multilib] activado correctamente.${RESET}"
        echo "Actualizando la base de datos de paquetes..."
        pacman -Sy --noconfirm
    else
        echo -e "${RED}No se pudo modificar /etc/pacman.conf. Ejecuta el script con permisos adecuados.${RESET}"
        exit 1
    fi
elif grep -q "^\s*\[multilib\]" "$PACMAN_CONF"; then
    echo -e "${GREEN}[multilib] ya está activado.${RESET}"
else
    echo -e "${RED}Repositorio [multilib] no encontrado en /etc/pacman.conf.${RESET}"
fi

# Actualizar sistema
titulo "ACTUALIZANDO EL SISTEMA"
pacman -Syu --noconfirm || { echo -e "${RED}Error actualizando el sistema.${RESET}"; exit 1; }

# Detectar hardware GPU
titulo "Detectando hardware GPU..."

HAS_NVIDIA=0
HAS_INTEL=0
HAS_AMD=0

# Detectar NVIDIA
if lspci | grep -i "NVIDIA" &> /dev/null; then
    HAS_NVIDIA=1
fi

# Detectar Intel
if lspci | grep -i "Intel Corporation UHD" &> /dev/null || lspci | grep -i "Intel Corporation HD Graphics" &> /dev/null; then
    HAS_INTEL=1
fi

# Detectar AMD
if lspci | grep -i "AMD/ATI" &> /dev/null || lspci | grep -i "Radeon" &> /dev/null; then
    HAS_AMD=1
fi

echo "Detección:"
echo "NVIDIA: $HAS_NVIDIA"
echo "Intel: $HAS_INTEL"
echo "AMD: $HAS_AMD"

# Instalar drivers según hardware detectado

# Intel drivers
if [[ $HAS_INTEL -eq 1 ]]; then
    titulo "Instalando drivers Intel + Vulkan"
    pacman -S --noconfirm mesa libva-intel-driver libva-utils vulkan-intel vulkan-icd-loader vulkan-tools || {
        echo -e "${RED}Error instalando drivers Intel.${RESET}"; exit 1;
    }
fi

# AMD drivers
if [[ $HAS_AMD -eq 1 ]]; then
    titulo "Instalando drivers AMD + Vulkan"
    pacman -S --noconfirm mesa xf86-video-amdgpu vulkan-radeon vulkan-icd-loader vulkan-tools || {
        echo -e "${RED}Error instalando drivers AMD.${RESET}"; exit 1;
    }
fi

# NVIDIA drivers
if [[ $HAS_NVIDIA -eq 1 ]]; then
    titulo "Instalando drivers NVIDIA propietarios"
    pacman -S --noconfirm nvidia nvidia-utils nvidia-settings nvidia-prime || {
        echo -e "${RED}Error instalando drivers NVIDIA.${RESET}"; exit 1;
    }
    systemctl enable nvidia-persistenced.service
    systemctl start nvidia-persistenced.service
fi

if [[ $HAS_NVIDIA -eq 0 && $HAS_INTEL -eq 0 && $HAS_AMD -eq 0 ]]; then
    echo -e "${YELLOW}No se detectó GPU compatible para instalar drivers gráficos específicos.${RESET}"
fi

# Wine y herramientas
titulo "INSTALANDO WINE Y WINETRICKS"
pacman -S --noconfirm wine winetricks || { echo -e "${RED}Error instalando Wine.${RESET}"; exit 1; }

# Steam
titulo "INSTALANDO STEAM"
pacman -S --noconfirm steam steam-native-runtime || { echo -e "${RED}Error instalando Steam.${RESET}"; exit 1; }

# Lutris
titulo "INSTALANDO LUTRIS"
pacman -S --noconfirm lutris || { echo -e "${RED}Error instalando Lutris.${RESET}"; exit 1; }

# Flatpak + Heroic
titulo "INSTALANDO FLATPAK Y HEROIC GAMES LAUNCHER"
pacman -S --noconfirm flatpak || { echo -e "${RED}Error instalando Flatpak.${RESET}"; exit 1; }
flatpak install -y flathub com.heroicgameslauncher.hgl || { echo -e "${RED}Error instalando Heroic Games Launcher.${RESET}"; exit 1; }

# ProtonUp-QT
titulo "INSTALANDO PROTONUP-QT"
flatpak install -y flathub net.davidotek.pupgui2 || { echo -e "${RED}Error instalando ProtonUp-QT.${RESET}"; exit 1; }

# MangoHUD y GOverlay
titulo "INSTALANDO MANGOHUD Y GOVERLAY"
pacman -S --noconfirm mangohud goverlay || { echo -e "${RED}Error instalando MangoHUD o GOverlay.${RESET}"; exit 1; }

# GameMode
titulo "INSTALANDO GAMEMODE"
pacman -S --noconfirm gamemode || { echo -e "${RED}Error instalando GameMode.${RESET}"; exit 1; }

# Audio con PipeWire
titulo "INSTALANDO PIPEWIRE"
pacman -S --noconfirm pipewire pipewire-audio pipewire-alsa pipewire-pulse wireplumber || { echo -e "${RED}Error instalando PipeWire.${RESET}"; exit 1; }

# Soporte gamepads
titulo "INSTALANDO SOPORTE PARA GAMEPADS"
pacman -S --noconfirm game-devices-udev || { echo -e "${RED}Error instalando soporte para gamepads.${RESET}"; exit 1; }

# Final
titulo "TODO COMPLETO. REINICIA TU SISTEMA PARA APLICAR LOS CAMBIOS."
