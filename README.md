
# 🎛️ Bash-Arch: Colección de Scripts para Arch Linux + Hyprland

**Versión**: 4.1 | **Licencia**: GPLv3  
![Estado](https://img.shields.io/badge/estado-estable-brightgreen)
![Licencia](https://img.shields.io/github/license/Ylogther/bash-s?color=blue)

🔧 Herramienta profesional para automatizar instalaciones, configuraciones y mantenimiento en Arch Linux con enfoque en Hyprland, gaming, multimedia, seguridad y desarrollo

ESTA HERRAMIENTA ES COMPATIBLE CON DRIVERS INTEL, AMD, NVIDIA, ETC.

> ✨ Ideal para desarrolladores, creadores de contenido, y entusiastas del entorno Linux personalizado con Hyprland.

---

## 🧰 Características principales

- 📦 Automatización de instalación de software esencial (desarrollo, multimedia, virtualización, etc.)
- 🖼️ Configuración optimizada para Hyprland y dotfiles personalizados.
- 🛠️ Scripts para mantenimiento y actualización del sistema (incluyendo AUR, Flatpak, pip, npm...).
- 🎥 Instalación de herramientas multimedia y de streaming.
- 🧪 Preparación de entorno para máquinas virtuales (con Btrfs y libvirt).
- 🔒 Scripts útiles para ciberseguridad como cambio de MAC.

---

## 📂 Estructura del repositorio

```bash
bash-arch/
├── actualizacion/                 # Scripts para actualizar el sistema
│   └── full_update.sh             # Actualización completa del sistema
├── desarrollo/                   # Herramientas y setups para desarrollo
│   ├── install_devtools.sh       # Instalación de herramientas de desarrollo
│   ├── ml4w_install.sh           # Instalación de ML4W (machine learning para Windows)
│   └── setup_dev_env.sh          # Configuración de entorno de desarrollo
├── gaming/                      # Scripts para optimizar y preparar el entorno gaming
│   ├── drivers_install.sh        # Instalación de drivers NVIDIA, Intel, AMD, etc.
│   └── instalacion-gaming.sh     # Configuraciones gaming adicionales
├── multimedia/                  # Instalación de programas multimedia y streaming
│   ├── davinci_resolve_deps.sh  # Dependencias para DaVinci Resolve
│   ├── multimedia_install.sh     # Instalación general de multimedia
│   └── streaming_install.sh      # Instalación y configuración de OBS y plugins
├── seguridad/                   # Scripts orientados a seguridad y red
│   ├── cambio_mac.sh             # Cambio de MAC address con opción propia o predeterminada
│   ├── firewall_fail2ban.sh      # Configuración básica de firewall y fail2ban
│   └── update_full.sh            # Script de actualización con enfoque en seguridad
├── solucion_problema_wifi/      # Scripts y documentación para problemas wifi
│   └── README.md
├── virtualizacion/              # Scripts para configurar y optimizar virtualización
│   ├── protocolo-salmon.sh
│   └── protocolo-salmon-vm.sh
├── utilidades/                  # Herramientas y scripts auxiliares generales
│   └── install_yay.sh            # Instalador automático y limpio de yay
├── LICENSE                     # Licencia GPLv3
└── README.md                   # Este archivo

````

---

## 🚀 Instalación rápida

```bash
git clone https://github.com/Ylogther/bash-arch.git
cd bash-arch
chmod +x */*.sh
```

Luego puedes ejecutar los scripts de instalación en orden o de forma individual según tus necesidades.

---

## 🧑‍💻 Requisitos

* Distribución GNU/Linux (preferentemente Arch Linux o derivadas).
* Conexión a Internet.
* Conocimientos básicos de shell/bash.

---

## 📖 Licencia

Este proyecto está licenciado bajo la **GNU GPL v3**. Puedes ver los términos completos en el archivo [`LICENSE`](LICENSE).

```
Este software es libre: puedes redistribuirlo y/o modificarlo bajo los términos de la Licencia Pública General de GNU, publicada por la Free Software Foundation, ya sea la versión 3 de la Licencia, o (a tu elección) cualquier versión posterior.
```

---

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Puedes:

* Proponer mejoras
* Reportar bugs
* Enviar tus propios scripts compatibles vía pull request

---

## 🎥 Proyecto mantenido por

**Ylogther**
🧠 Hacker ético | 🛠️ Dev multimedia y web

