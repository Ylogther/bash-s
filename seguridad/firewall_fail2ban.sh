#!/bin/bash

set -e

echo "🚧 Instalando y configurando firewall y fail2ban..."

# Instalar firewall (ufw) y fail2ban
if command -v pacman &> /dev/null; then
    sudo pacman -S --noconfirm ufw fail2ban
elif command -v apt &> /dev/null; then
    sudo apt install -y ufw fail2ban
else
    echo "⚠️ No se detectó gestor de paquetes compatible para instalar ufw y fail2ban."
    exit 1
fi

# Activar y habilitar ufw
sudo systemctl enable ufw --now
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw enable

echo "✔ Firewall UFW configurado y habilitado."

# Configurar fail2ban con reglas básicas
sudo systemctl enable fail2ban --now

echo "✔ Fail2ban habilitado y en ejecución."

echo "🔒 Configuración de seguridad básica completada."
