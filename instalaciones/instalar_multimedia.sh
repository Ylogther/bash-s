#!/bin/bash

echo "🔧 Instalando herramientas multimedia..."

# Instalar Flatpak y agregar Flathub
sudo pacman -S --noconfirm flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Herramientas de diseño gráfico
sudo pacman -S --noconfirm inkscape krita

# Modelado 3D, edición de video y streaming
sudo pacman -S --noconfirm blender obs-studio kdenlive

# Edición y producción de audio
sudo pacman -S --noconfirm audacity lmms ardour

# Instalar versiones Flatpak de apps clave (opcional)
#flatpak install -y flathub org.blender.Blender
#flatpak install -y flathub org.inkscape.Inkscape
#flatpak install -y flathub org.gimp.GIMP
#flatpak install -y flathub org.kde.kdenlive
#flatpak install -y flathub com.obsproject.Studio
#flatpak install -y flathub org.audacityteam.Audacity

echo "✅ Instalación multimedia completada."

