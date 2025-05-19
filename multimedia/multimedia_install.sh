#!/bin/bash

# Colores para mejor lectura
GREEN='\e[32m'
YELLOW='\e[33m'
RESET='\e[0m'

echo -e "${YELLOW}🔧 Instalando herramientas multimedia...${RESET}"

# Actualizar la base de datos de paquetes (solo una vez)
sudo pacman -Sy --noconfirm || { echo "Error al sincronizar paquetes"; exit 1; }

# Instalar flatpak y agregar Flathub si no existe
if ! flatpak remote-info flathub &>/dev/null; then
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

# Paquetes nativos para diseño gráfico, modelado, edición y audio
PAQUETES=(
    inkscape krita
    blender obs-studio kdenlive
    audacity lmms ardour
)

sudo pacman -S --noconfirm "${PAQUETES[@]}" || { echo "Error instalando paquetes multimedia"; exit 1; }

# Opcional: instalar versiones Flatpak (descomenta si quieres usar Flatpak)
# flatpak install -y flathub org.blender.Blender \
#     org.inkscape.Inkscape org.gimp.GIMP org.kde.kdenlive \
#     com.obsproject.Studio org.audacityteam.Audacity

echo -e "${GREEN}✅ Instalación multimedia completada.${RESET}"
