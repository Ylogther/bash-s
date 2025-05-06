#!/bin/bash

# Colores para mejor legibilidad
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔄 Iniciando actualización completa del sistema...${NC}"

# 1. Actualizar paquetes de pacman (oficial)
echo -e "\n${YELLOW}1. 🔄 Actualizando paquetes de pacman (oficial)...${NC}"
sudo pacman -Syu --noconfirm

# 2. Actualizar paquetes de AUR (yay)
if command -v yay &> /dev/null; then
    echo -e "\n${YELLOW}2. 🔄 Actualizando paquetes de AUR (yay)...${NC}"
    yay -Syu --noconfirm
else
    echo -e "${RED}⚠ 'yay' no está instalado. Omitiendo actualización de AUR.${NC}"
fi

# 3. Actualizar paquetes de flatpak
if command -v flatpak &> /dev/null; then
    echo -e "\n${YELLOW}3. 🔄 Actualizando paquetes de Flatpak...${NC}"
    flatpak update -y
else
    echo -e "${RED}⚠ 'flatpak' no está instalado. Omtiendo actualización de Flatpak.${NC}"
fi

# 4. Actualizar paquetes de snap
if command -v snap &> /dev/null; then
    echo -e "\n${YELLOW}4. 🔄 Actualizando paquetes de Snap...${NC}"
    sudo snap refresh
else
    echo -e "${RED}⚠ 'snap' no está instalado. Omtiendo actualización de Snap.${NC}"
fi

# 5. Actualizar paquetes globales de pip (Python)
if command -v pip &> /dev/null; then
    echo -e "\n${YELLOW}5. 🔄 Actualizando paquetes globales de pip (Python)...${NC}"
    pip list --outdated | cut -d ' ' -f 1 | xargs -n1 pip install -U --user
elif command -v pip3 &> /dev/null; then
    echo -e "\n${YELLOW}5. 🔄 Actualizando paquetes globales de pip3 (Python)...${NC}"
    pip3 list --outdated | cut -d ' ' -f 1 | xargs -n1 pip3 install -U --user
else
    echo -e "${RED}⚠ 'pip' no está instalado. Omtiendo actualización de paquetes Python.${NC}"
fi

# 6. Actualizar paquetes globales de npm (Node.js)
if command -v npm &> /dev/null; then
    echo -e "\n${YELLOW}6. 🔄 Actualizando paquetes globales de npm (Node.js)...${NC}"
    npm update -g
else
    echo -e "${RED}⚠ 'npm' no está instalado. Omtiendo actualización de paquetes Node.js.${NC}"
fi

# Limpieza post-actualización
echo -e "\n${BLUE}🧹 Realizando limpieza post-actualización...${NC}"

# a) Eliminar dependencias huérfanas en pacman
echo -e "\n${YELLOW}a) 🗑️ Eliminando dependencias huérfanas (pacman)...${NC}"
sudo pacman -Rns $(pacman -Qdtq) 2>/dev/null || echo -e "${RED}⚠ No hay dependencias huérfanas.${NC}"

# b) Limpiar caché de yay
if command -v yay &> /dev/null; then
    echo -e "\n${YELLOW}b) 🗑️ Limpiando caché de yay...${NC}"
    yay -Yc --noconfirm
fi

# c) Limpiar flatpaks no usados
if command -v flatpak &> /dev/null; then
    echo -e "\n${YELLOW}c) 🗑️ Eliminando flatpaks no usados...${NC}"
    flatpak uninstall --unused -y
fi

# Verificación final
echo -e "\n${GREEN}✅ ¡Actualización y limpieza completadas con éxito!${NC}"
