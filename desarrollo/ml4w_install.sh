#!/bin/bash

set -e  # Detener si hay algún error

# ==== Colores para mejor legibilidad ====
GREEN='\e[32m'
RED='\e[31m'
YELLOW='\e[33m'
RESET='\e[0m'

titulo() {
    echo -e "\n${YELLOW}==> $1${RESET}"
}

error() {
    echo -e "${RED}✖ $1${RESET}"
    exit 1
}

success() {
    echo -e "${GREEN}✔ $1${RESET}"
}

# ==== Solicitar confirmación al usuario ====
read -p "¿Quieres instalar el dotfile ml4w? (s/n): " respuesta

if [[ "$respuesta" =~ ^[sS]$ ]]; then
    titulo "Instalando dotfile ml4w..."

    # Ejecutar script remoto con seguridad
    if curl -s --head --fail https://raw.githubusercontent.com/mylinuxforwork/dotfiles/main/setup-arch.sh > /dev/null; then
        bash <(curl -s https://raw.githubusercontent.com/mylinuxforwork/dotfiles/main/setup-arch.sh)
    else
        error "No se pudo acceder al script remoto. Verifica tu conexión o la URL."
    fi

    # Verificar si yay está instalado
    if ! command -v yay &> /dev/null; then
        error "'yay' no está instalado. Por favor instálalo antes de continuar."
    fi

    titulo "Instalando paquete ml4w-hyprland..."
    yay -S --noconfirm ml4w-hyprland || error "Fallo al instalar ml4w-hyprland"

    # Verificar el comando de configuración
    if ! command -v ml4w-hyprland-setup &> /dev/null; then
        error "'ml4w-hyprland-setup' no se encontró después de la instalación."
    fi

    titulo "Ejecutando configuración final..."
    ml4w-hyprland-setup || error "Error al ejecutar ml4w-hyprland-setup"

    success "Instalación completada con éxito."

elif [[ "$respuesta" =~ ^[nN]$ ]]; then
    echo -e "${YELLOW}Instalación cancelada por el usuario.${RESET}"
else
    error "Respuesta inválida. Usa 's' para sí o 'n' para no."
fi

