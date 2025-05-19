#!/bin/bash

set -e

GREEN='\e[32m'
RED='\e[31m'
YELLOW='\e[33m'
RESET='\e[0m'

echo -e "${YELLOW}==> Instalando yay (AUR helper)${RESET}"

# Verificar que pacman y git estén instalados
if ! command -v pacman &> /dev/null; then
    echo -e "${RED}Error: pacman no encontrado. Este script es solo para Arch Linux.${RESET}"
    exit 1
fi

if ! command -v git &> /dev/null; then
    echo -e "${YELLOW}Git no encontrado. Instalando git...${RESET}"
    sudo pacman -S --noconfirm git
fi

# Instalar base-devel si no está instalado (requisito para compilar paquetes AUR)
if ! pacman -Qq base-devel &> /dev/null; then
    echo -e "${YELLOW}Instalando grupo base-devel...${RESET}"
    sudo pacman -S --noconfirm base-devel
fi

# Crear carpeta temporal para la compilación
TMPDIR=$(mktemp -d)
echo -e "${YELLOW}Creando carpeta temporal en $TMPDIR${RESET}"

cd "$TMPDIR"

# Clonar repositorio de yay
echo -e "${YELLOW}Clonando yay desde AUR...${RESET}"
git clone https://aur.archlinux.org/yay.git

cd yay

# Construir e instalar yay
echo -e "${YELLOW}Compilando e instalando yay...${RESET}"
makepkg -si --noconfirm

# Volver y limpiar
cd ..
rm -rf "$TMPDIR"

echo -e "${GREEN}yay instalado correctamente.${RESET}"

