---

````markdown
# Scripts de Automatización y Configuración para Linux

![License](https://img.shields.io/badge/license-GPLv3-blue.svg)
![Shell Script](https://img.shields.io/badge/language-Bash-yellow.svg)

---

## Descripción

Este repositorio contiene una colección organizada de scripts Bash diseñados para facilitar la administración, configuración y mantenimiento de sistemas Linux, con especial enfoque en Arch Linux y entornos multimedia. Los scripts abordan tareas comunes como instalación de software, gestión de redes, configuración de máquinas virtuales y actualizaciones del sistema, buscando mejorar la productividad y automatizar procesos repetitivos.

---

## Índice

- [Estructura del Repositorio](#estructura-del-repositorio)  
- [Listado de Scripts y Funcionalidades](#listado-de-scripts-y-funcionalidades)  
- [Requisitos](#requisitos)  
- [Uso](#uso)  
- [Contribuciones](#contribuciones)  
- [Licencia](#licencia)  
- [Autor](#autor)  

---

## Estructura del Repositorio

```plaintext
repo-scripts/
├── aur/                   # Scripts para instalación y manejo de AUR y paquetes externos
│   └── aur_install.sh
├── multimedia/            # Instaladores y configuradores de herramientas multimedia
│   ├── multimedia_install.sh
│   └── streaming_install.sh
├── network/               # Scripts para gestión de interfaces y MAC address
│   └── mac_changer.sh
├── system/                # Scripts de mantenimiento y actualización de sistema
│   └── update_all.sh
├── virtualization/        # Configuración de máquinas virtuales y subvolúmenes Btrfs
│   └── btrfs_vm_setup.sh
└── README.md              # Documentación del repositorio
````

---

## Listado de Scripts y Funcionalidades

### Aur

* **aur\_install.sh**
  Automatiza la instalación de paquetes AUR y configuración de dotfiles específicos, incluyendo setups personalizados para entornos Hyprland.

### Multimedia

* **multimedia\_install.sh**
  Instala aplicaciones multimedia esenciales: Blender, Kdenlive, Audacity, LMMS, Ardour, y configuraciones Flatpak.

* **streaming\_install.sh**
  Configura OBS Studio junto con plugins populares como StreamFX para mejorar la experiencia de streaming.

### Network

* **mac\_changer.sh**
  Cambia la dirección MAC de una interfaz de red con opción a MAC predeterminada o personalizada, para mejorar privacidad y pruebas de red.

### System

* **update\_all.sh**
  Realiza una actualización integral del sistema incluyendo paquetes nativos, AUR, Flatpak, Snap, pip y npm, seguido de limpieza automática.

### Virtualization

* **btrfs\_vm\_setup.sh**
  Automatiza la creación de subvolúmenes Btrfs para máquinas virtuales, configura el entorno de libvirt/virt-manager y estructura inicial para ISOs y discos virtuales.

---

## Requisitos

* Sistema operativo Linux (preferentemente Arch Linux para mejor compatibilidad)
* Permisos de administrador (sudo)
* Gestores de paquetes compatibles (pacman, apt, dnf, etc.)
* Acceso a Internet para descarga de paquetes y dependencias

---

## Uso

Clona el repositorio y ejecuta los scripts según tus necesidades:

```bash
git clone https://github.com/tu_usuario/tu_repositorio.git
cd tu_repositorio

# Ejecutar script de actualización del sistema
bash system/update_all.sh

# Instalar herramientas multimedia
bash multimedia/multimedia_install.sh

# Cambiar MAC address
bash network/mac_changer.sh
```

---

## Contribuciones

¡Las contribuciones son bienvenidas! Si deseas mejorar los scripts, agregar nuevas funcionalidades o corregir errores, por favor sigue estos pasos:

1. Haz un fork del repositorio
2. Crea una rama con tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. Realiza commits claros y descriptivos
4. Envía un Pull Request describiendo tus cambios

---

## Licencia

Este proyecto está bajo la Licencia **GNU General Public License v3.0** (GPL-3.0).
Puedes consultar el archivo [LICENSE](./LICENSE) para más detalles.

---

## Autor

**Ylogther**
