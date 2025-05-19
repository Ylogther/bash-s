#!/bin/bash

set -e

echo "🎥 Instalando OBS Studio y plugins esenciales para streaming..."

if command -v pacman &> /dev/null; then
    sudo pacman -S --noconfirm obs-studio obs-v4l2sink
elif command -v apt &> /dev/null; then
    sudo apt update
    sudo apt install -y obs-studio v4l2loopback-dkms v4l2loopback-utils
else
    echo "⚠️ Gestor de paquetes no soportado para este script."
    exit 1
fi

echo "✔ OBS Studio instalado."

echo "🔌 Instalando herramientas adicionales (opcional):"
echo "- StreamFX (efectos y mejoras para OBS)"

# Instalar StreamFX vía plugin (ejemplo para Arch con yay)
if command -v yay &> /dev/null; then
    yay -S --noconfirm obs-studio-streamfx
elif command -v apt &> /dev/null; then
    echo "Para StreamFX en Debian/Ubuntu, descarga el plugin desde https://github.com/Xaymar/obs-StreamFX/releases y sigue las instrucciones."
fi

echo "✅ Entorno de streaming configurado. ¡A transmitir!"
