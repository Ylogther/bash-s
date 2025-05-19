#!/bin/bash

# Colores
GREEN='\e[32m'
RED='\e[31m'
YELLOW='\e[33m'
RESET='\e[0m'

# Función para mostrar encabezado bonito
titulo() {
    echo -e "\n${YELLOW}===> $1${RESET}"
}

# Verificar privilegios root
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}Este script debe ejecutarse como root. Usa 'sudo ./nombre.sh'${RESET}"
    exit 1
fi

# Actualización del sistema
titulo "Actualizando el sistema"
pacman -Syu --noconfirm || { echo -e "${RED}Error al actualizar.${RESET}"; exit 1; }

# Instalación de drivers Intel y soporte Vulkan
titulo "Instalando drivers Intel + Vulkan"
pacman -S --noconfirm mesa libva-intel-driver libva-utils vulkan-intel vulkan-icd-loader vulkan-tools || {
    echo -e "${RED}Error instalando drivers Intel.${RESET}"; exit 1;
}

# Instalación de drivers NVIDIA + soporte híbrido
titulo "Instalando drivers NVIDIA propietarios"
pacman -S --noconfirm nvidia nvidia-utils nvidia-settings nvidia-prime || {
    echo -e "${RED}Error instalando drivers NVIDIA.${RESET}"; exit 1;
}

# Habilitar servicio de persistencia NVIDIA
titulo "Habilitando servicio nvidia-persistenced"
systemctl enable nvidia-persistenced.service
systemctl start nvidia-persistenced.service

titulo "Instalación completada con éxito"
echo -e "${GREEN}Reinicia tu sistema para aplicar todos los cambios.${RESET}"
