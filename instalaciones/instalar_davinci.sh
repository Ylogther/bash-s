#!/bin/bash

# ==== Colores ====
GREEN='\e[32m'
RED='\e[31m'
YELLOW='\e[33m'
BLUE='\e[34m'
RESET='\e[0m'

titulo() {
    echo -e "\n${YELLOW}===> $1${RESET}"
}

error() {
    echo -e "${RED}✖ $1${RESET}"
    exit 1
}

# ==== Comprobación de root ====
if [[ $EUID -ne 0 ]]; then
    error "Este script debe ejecutarse como root (usa sudo)"
fi

titulo "🎬 Instalación de dependencias para DaVinci Resolve en Arch Linux"

# 1. Dependencias base
titulo "📦 Instalando dependencias esenciales..."
pacman -S --noconfirm libxcrypt-compat ocl-icd || error "Error instalando dependencias base"

# 2. NVIDIA GPU
titulo "🟢 Instalando soporte para NVIDIA..."
pacman -S --noconfirm nvidia nvidia-utils opencl-nvidia || error "Error instalando soporte NVIDIA"

# 3. Intel GPU (opcional)
titulo "🔵 Instalando soporte para Intel (opcional)..."
pacman -S --noconfirm intel-media-driver intel-compute-runtime opencl-intel || echo -e "${BLUE}Intel no es obligatorio. Puedes omitirlo si no usas iGPU.${RESET}"

# 4. Activar systemd-resolved y configurar resolv.conf
titulo "🔧 Configurando systemd-resolved..."
systemctl enable --now systemd-resolved || error "No se pudo habilitar systemd-resolved"
ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf || error "No se pudo configurar /etc/resolv.conf"

# 5. Verificar clinfo
titulo "🧪 Verificando disponibilidad de OpenCL y GPU..."
if ! command -v clinfo &> /dev/null; then
    echo -e "${YELLOW}Instalando clinfo...${RESET}"
    pacman -S --noconfirm clinfo || error "Error instalando clinfo"
fi

echo -e "${BLUE}📋 Resultado de clinfo:${RESET}"
clinfo | grep -E "Device|Platform Name|Vendor"

titulo "✅ Configuración completa. Ahora puedes ejecutar el instalador .run de DaVinci Resolve"
