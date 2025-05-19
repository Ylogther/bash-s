#!/bin/bash

set -e

# === Instalación de herramientas de desarrollo ===
# Nombre: install_devtools.sh
# Descripción: Instala herramientas básicas para programación y desarrollo web en varias distros.

echo "🛠️ Instalando herramientas de desarrollo..."

# Función para verificar si un comando existe
command_exists() {
    command -v "$1" &> /dev/null
}

if command_exists pacman; then
    echo "📦 Usando pacman (Arch Linux)"

    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm \
        git base-devel neovim code docker docker-compose \
        nodejs npm python python-pip \
        jdk-openjdk jre-openjdk \
        gcc g++ cmake clang rust go \
        sqlite postgresql mariadb \
        unzip zip wget curl make

elif command_exists apt; then
    echo "📦 Usando apt (Debian/Ubuntu)"

    sudo apt update && sudo apt upgrade -y
    sudo apt install -y \
        build-essential git neovim code docker.io docker-compose \
        nodejs npm python3 python3-pip \
        openjdk-17-jdk openjdk-17-jre \
        gcc g++ cmake clang rustc golang \
        sqlite3 postgresql mariadb-server \
        unzip zip wget curl make

elif command_exists dnf; then
    echo "📦 Usando dnf (Fedora)"

    sudo dnf upgrade -y
    sudo dnf install -y \
        git @development-tools neovim code docker docker-compose \
        nodejs npm python3 python3-pip \
        java-17-openjdk java-17-openjdk-devel \
        gcc gcc-c++ cmake clang rust golang \
        sqlite postgresql mariadb \
        unzip zip wget curl make

else
    echo "⚠️ Gestor de paquetes no compatible o no detectado."
    exit 1
fi

# Activar y añadir usuario al grupo docker (opcional)
if command_exists docker; then
    echo "🐳 Habilitando y configurando Docker..."
    sudo systemctl enable --now docker
    sudo usermod -aG docker "$USER"
fi

echo "✅ Herramientas de desarrollo instaladas correctamente."
echo "📌 Reinicia tu sesión para aplicar los cambios del grupo docker (si aplica)."
