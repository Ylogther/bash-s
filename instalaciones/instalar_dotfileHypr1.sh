#!/bin/bash

set -e  # Detiene el script si ocurre un error

read -p "¿Quieres instalar el dotfile ml4w? (s/n): " respuesta

if [[ "$respuesta" == "s" || "$respuesta" == "S" ]]; then
    echo "Instalando dotfile ml4w..."

    # Ejecutar el setup desde el repositorio
    bash <(curl -s https://raw.githubusercontent.com/mylinuxforwork/dotfiles/main/setup-arch.sh)

    # Verificar si yay está instalado
    if ! command -v yay &> /dev/null; then
        echo "Error: 'yay' no está instalado. Por favor instálalo antes de continuar."
        exit 1
    fi

    # Instalar ml4w-hyprland
    yay -S --noconfirm ml4w-hyprland

    # Verificar si el comando ml4w-hyprland-setup existe
    if ! command -v ml4w-hyprland-setup &> /dev/null; then
        echo "Error: 'ml4w-hyprland-setup' no se encontró después de la instalación."
        exit 1
    fi

    # Ejecutar setup
    ml4w-hyprland-setup

    echo "Instalación completada con éxito."
elif [[ "$respuesta" == "n" || "$respuesta" == "N" ]]; then
    echo "No se permitió proceder con la instalación. Cerrando script."
else
    echo "Respuesta inválida. Usa 's' para sí o 'n' para no."
    exit 1
fi

