#!/bin/bash

# Salir si algo falla
set -e

echo "🔧 Instalando drivers y utilidades NVIDIA..."
sudo pacman -Syu --noconfirm nvidia nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader

echo "🎮 Instalando Steam..."
sudo pacman -S --noconfirm steam

echo "🧩 Seleccionando Vulkan de 32 bits para NVIDIA..."
# Automatizar elección de lib32-nvidia-utils como proveedor (requiere intervención manual en algunos casos)
# Si estás creando un instalador 100% automático, deberías usar una AUR helper como yay para evitar la selección manual

echo "🧰 Instalando herramientas básicas..."
sudo pacman -S --noconfirm base-devel git bluez bluez-utils blueman zzuf

echo "🔌 Habilitando Bluetooth..."
sudo systemctl enable --now bluetooth.service

echo "📦 Instalando yay (AUR helper)..."
cd ~
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

echo "📦 Instalando snapd desde repositorio de Arch (AUR si es necesario)..."
if ! pacman -Q snapd &> /dev/null; then
    yay -S --noconfirm snapd
fi

echo "🔌 Habilitando Snap..."
sudo systemctl enable --now snapd.socket
sudo ln -sf /var/lib/snapd/snap /snap

echo "⏳ Esperando para asegurar montaje de Snap..."
sleep 3

echo "🛍 Instalando Snap Store y dependencias..."
sudo snap install snap-store

echo "🍷 Instalando ProtonUp-Qt (AUR)..."
yay -S --noconfirm protonup-qt

echo "✅ Finalizado. Puedes lanzar Steam, Snap Store y ProtonUp-Qt desde tu entorno gráfico."
