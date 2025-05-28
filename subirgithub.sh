#!/bin/bash
set -euo pipefail

echo "-------- Iniciando --------"

# Verifica si hay cambios
if [[ -z $(git status --porcelain) ]]; then
    echo "Nada que confirmar. El repositorio está limpio."
    exit 0
fi

# Agrega cambios y crea commit con mensaje por defecto o personalizado
MSG=${1:-"update"}
git add .
git commit -m "$MSG"

# Establece main como rama principal (opcional: puede omitir si ya está)
git branch -M main

# Empuja a la rama main
git push -u origin main

echo "-------- Finalizado --------"

