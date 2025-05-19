#!/bin/bash

set -e

echo "💻 Instalando herramientas de desarrollo para C, C++ y Java..."

if command -v pacman &> /dev/null; then
    sudo pacman -S --noconfirm base-devel gcc clang cmake java-environment-openjdk openjdk
elif command -v apt &> /dev/null; then
    sudo apt update
    sudo apt install -y build-essential gcc clang cmake openjdk-17-jdk
else
    echo "⚠️ Gestor de paquetes no soportado para este script."
    exit 1
fi

echo "✔ Instalación de compiladores y herramientas completada."

echo "📦 Instalando VSCode (opcional)..."
if ! command -v code &> /dev/null; then
    if command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm code
    elif command -v apt &> /dev/null; then
        sudo snap install code --classic
    fi
fi

echo "✔ Entorno de desarrollo listo para usar."
