#!/bin/bash

echo "🎬 Instalación de dependencias para DaVinci Resolve en Arch Linux"

# 1. Instalar dependencias base
echo "📦 Instalando dependencias esenciales..."
sudo pacman -S --noconfirm libxcrypt-compat ocl-icd

# 2. Soporte para GPU NVIDIA
echo "🟢 Instalando soporte para NVIDIA..."
sudo pacman -S --noconfirm nvidia nvidia-utils opencl-nvidia

# 3. Soporte para GPU Intel (opcional para laptops híbridas)
echo "🔵 Instalando soporte para Intel (opcional)..."
sudo pacman -S --noconfirm intel-media-driver intel-compute-runtime opencl-intel

# 4. Activar systemd-resolved y configurar resolv.conf
echo "🔧 Configurando systemd-resolved..."
sudo systemctl enable --now systemd-resolved
sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

# 5. Verificar si OpenCL y GPU están disponibles
echo "🧪 Verificando disponibilidad de OpenCL y GPU..."
if ! command -v clinfo &> /dev/null; then
    echo "📦 Instalando clinfo para verificación de GPU..."
    sudo pacman -S --noconfirm clinfo
fi

echo "📋 Resultado de clinfo:"
clinfo | grep "Device"

echo "✅ Configuración completa. Ahora puedes ejecutar el instalador .run de DaVinci Resolve."
