#!/bin/bash

set -e

echo "🎥 Instalando OBS Studio y plugins esenciales para streaming..."

# Verificar si estamos en Arch
if command -v pacman &> /dev/null; then
    sudo pacman -S --noconfirm obs-studio

    if command -v yay &> /dev/null; then
        echo "📦 Instalando obs-v4l2sink desde AUR..."
        yay -S --noconfirm obs-v4l2sink
    else
        echo "⚠️ 'yay' no está instalado. Instala yay o paru para obtener obs-v4l2sink desde AUR."
    fi

# Para distribuciones basadas en Debian
elif command -v apt &> /dev/null; then
    sudo apt update
    sudo apt install -y obs-studio v4l2loopback-dkms v4l2loopback-utils
    echo "🔧 Para v4l2sink, compílalo desde: https://github.com/CatxFish/obs-v4l2sink"
else
    echo "⚠️ Gestor de paquetes no compatible."
    exit 1
fi

# Cargar módulo v4l2loopback
echo "🎥 Cargando módulo v4l2loopback..."
sudo modprobe v4l2loopback devices=1 video_nr=10 card_label="OBS Virtual Camera" exclusive_caps=1

echo "✅ OBS Studio y cámara virtual listos para usar."
