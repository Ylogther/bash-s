#!/bin/bash

set -e

GREEN='\e[32m'
RED='\e[31m'
YELLOW='\e[33m'
RESET='\e[0m'

echo -e "${YELLOW}==> Instalando Minecraft Launcher oficial (moderno) desde el AUR${RESET}"

# Verifica que estás en Arch
if ! command -v pacman &> /dev/null; then
    echo -e "${RED}Error: este script solo funciona en Arch Linux o derivados.${RESET}"
    exit 1
fi

# Verificar que git esté instalado
if ! command -v git &> /dev/null; then
    echo -e "${YELLOW}Git no está instalado. Instalando...${RESET}"
    sudo pacman -S --noconfirm git
fi

# Verificar que base-devel esté instalado
if ! pacman -Qq base-devel &> /dev/null; then
    echo -e "${YELLOW}Instalando base-devel (necesario para compilar desde el AUR)...${RESET}"
    sudo pacman -S --noconfirm base-devel
fi

# Crear carpeta temporal
TMPDIR=$(mktemp -d)
echo -e "${YELLOW}Clonando repositorio AUR en $TMPDIR${RESET}"
cd "$TMPDIR"

# Clonar el launcher oficial desde el AUR
git clone https://aur.archlinux.org/minecraft-launcher.git
cd minecraft-launcher

# Compilar e instalar
echo -e "${YELLOW}Compilando e instalando el launcher...${RESET}"
makepkg -si --noconfirm

# Limpieza
cd ~
rm -rf "$TMPDIR"

echo -e "${GREEN}Minecraft Launcher oficial (moderno) instalado correctamente.${RESET}"
echo -e "${YELLOW}Puedes ejecutarlo buscando 'Minecraft Launcher' en tu menú o usando:${RESET} minecraft-launcher"
