#!/bin/bash

read -p "¿quieres instalar el dotfile ml4w?(s/n): " respuesta

if [ "$respuesta" == "s" ]; then

echo "instalando dotfile ml4w..."

bash <(curl -s https://raw.githubusercontent.com/mylinuxforwork/dotfiles/main/setup-arch.sh)
yay -S ml4w-hyprland
ml4w-hyprland-setup

echo "instalación completada con éxito"

else
 echo "no se permitió proceder con la instalación cerrando script"
fi
