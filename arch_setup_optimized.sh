#!/bin/bash

# Seguridad y robustez
set -euo pipefail
IFS=$'\n\t'

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Logging a archivo
exec &> >(tee -a "$HOME/arch_setup.log")

# Funciones de mensaje
log_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
log_warn() { echo -e "${YELLOW}⚠️  $1${NC}"; }
log_error() { echo -e "${RED}❌ $1${NC}"; }
log_success() { echo -e "${GREEN}✅ $1${NC}"; }

# Variables de configuración
AUR_HELPER="paru" # yay o paru
ENABLE_FLATPAK=true
ENABLE_SNAP=false
ENABLE_GAMING=true
INSTALL_EXTRA_SOFTWARE=true

# Funciones principales

check_root() {
    if [[ $EUID -eq 0 ]]; then
        log_error "No ejecutes este script como root. Usa un usuario con sudo."
        exit 1
    fi
}

check_internet() {
    log_info "Verificando conexión a Internet..."
    if ! ping -c 1 archlinux.org &> /dev/null; then
        log_error "No hay conexión a Internet. Aborta."
        exit 1
    fi
    log_success "Conexión a Internet activa."
}

update_system() {
    log_info "Actualizando el sistema..."
    sudo pacman -Syu --noconfirm
    log_success "Sistema actualizado."
}

install_essentials() {
    log_info "Instalando paquetes básicos..."
    sudo pacman -S --needed --noconfirm \
        base-devel git curl wget openssh zsh vim neovim \
        tmux htop rsync unzip zip ntfs-3g exfat-utils \
        man-db man-pages texinfo networkmanager \
        xdg-user-dirs xdg-utils
    log_success "Paquetes básicos instalados."
}

configure_laptop() {
    if [[ -f /sys/class/dmi/id/chassis_type ]]; then
        local type=$(cat /sys/class/dmi/id/chassis_type)
        if [[ "$type" =~ ^(1|2|3|8|9)$ ]]; then
            log_info "Laptop detectada, instalando herramientas de energía..."
            sudo pacman -S --noconfirm tlp acpi acpid powertop
            sudo systemctl enable --now tlp acpid
            log_success "Optimización para laptops activada."
            return
        fi
    fi
    log_info "No es una laptop, omitiendo optimización energética."
}

detect_gpu() {
    log_info "Detectando GPU..."
    if lspci | grep -i nvidia &> /dev/null; then
        echo "nvidia"
    elif lspci | grep -i amd &> /dev/null; then
        echo "amd"
    elif lspci | grep -i intel &> /dev/null; then
        echo "intel"
    else
        echo "unknown"
    fi
}

install_graphics_drivers() {
    local gpu=$(detect_gpu)
    log_info "Instalando controladores para GPU: $gpu"

    case $gpu in
        nvidia)
            sudo pacman -S --noconfirm nvidia nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader
            ;;
        amd)
            sudo pacman -S --noconfirm mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader
            ;;
        intel)
            sudo pacman -S --noconfirm mesa lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader
            ;;
        *)
            sudo pacman -S --noconfirm mesa lib32-mesa vulkan-icd-loader lib32-vulkan-icd-loader
            log_warn "GPU no detectada, se usaron controladores genéricos."
            ;;
    esac
    log_success "Controladores gráficos instalados."
}

install_aur_helper() {
    if command -v "$AUR_HELPER" &> /dev/null; then
        log_success "$AUR_HELPER ya está instalado."
        return
    fi

    log_info "Instalando AUR helper: $AUR_HELPER"
    sudo pacman -S --needed --noconfirm git base-devel
    local temp_dir="/tmp/$AUR_HELPER"
    git clone "https://aur.archlinux.org/$AUR_HELPER.git" "$temp_dir"
    cd "$temp_dir"
    makepkg -si --noconfirm
    cd ~
    rm -rf "$temp_dir"
    log_success "$AUR_HELPER instalado correctamente."
}

install_extra_software() {
    if [[ "$INSTALL_EXTRA_SOFTWARE" == true ]]; then
        log_info "Instalando software adicional..."
        sudo pacman -S --noconfirm vlc mpv ffmpeg libreoffice-fresh evince gparted gnome-disk-utility
        log_success "Software adicional instalado."
    fi
}

configure_flatpak() {
    if [[ "$ENABLE_FLATPAK" == true ]]; then
        log_info "Configurando Flatpak..."
        sudo pacman -S --noconfirm flatpak
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        log_success "Flatpak configurado."
    fi
}

configure_snap() {
    if [[ "$ENABLE_SNAP" == true ]]; then
        log_info "Configurando Snap..."
        sudo pacman -S --noconfirm snapd
        sudo systemctl enable --now snapd.socket
        sudo ln -sf /var/lib/snapd/snap /snap
        log_warn "Reinicia para completar la configuración de Snap."
    fi
}

configure_gaming() {
    if [[ "$ENABLE_GAMING" == true ]]; then
        log_info "Configurando sistema para gaming..."

        # Remover wine si está instalado para evitar conflicto con wine-staging
        if pacman -Qs ^wine$ > /dev/null; then
            log_warn "Eliminando 'wine' para instalar 'wine-staging'..."
            sudo pacman -Rns --noconfirm wine
        fi

        sudo pacman -S --noconfirm steam lutris wine-staging winetricks \
            gamemode lib32-gamemode mangohud lib32-mangohud \
            vulkan-icd-loader lib32-vulkan-icd-loader

        if command -v "$AUR_HELPER" &> /dev/null; then
            $AUR_HELPER -S --noconfirm dxvk-bin vkd3d-proton-bin
        fi

        log_success "Entorno de gaming instalado."
    fi
}


configure_shell() {
    log_info "Configurando ZSH..."
    sudo pacman -S --noconfirm zsh zsh-completions zsh-syntax-highlighting zsh-autosuggestions
    chsh -s /bin/zsh "$USER"

    ZSHRC="$HOME/.zshrc"
    grep -qxF 'source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' "$ZSHRC" || echo 'source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> "$ZSHRC"
    grep -qxF 'source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' "$ZSHRC" || echo 'source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' >> "$ZSHRC"

    log_success "ZSH configurado. Reinicia sesión para aplicar cambios."
}

# MAIN
main() {
    log_info "🔧 Iniciando configuración avanzada de Arch Linux..."

    check_root
    check_internet
    update_system
    install_essentials
    configure_laptop
    install_graphics_drivers
    install_aur_helper
    configure_flatpak
    configure_snap
    configure_gaming
    install_extra_software
    configure_shell

    log_success "✨ Configuración completa. Reinicia para finalizar."
}

main
