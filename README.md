
# 🎛️ script necesarios para Arch linux

**Versión**: 4.0 | **Licencia**: GPLv3  
![Estado](https://img.shields.io/badge/estado-estable-brightgreen)
![Licencia](https://img.shields.io/github/license/Ylogther/bash-s-?color=blue)

🔧 Herramienta profesional para automatizar la configuración de un entorno de trabajo Linux moderno, seguro y completo, con soporte para virtualización, multimedia y ciberseguridad.

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
ml4w/
├── 00-dotfiles/
│   └── instalar-dotfiles.sh
├── 01-actualizacion/
│   └── actualizacion-global.sh
├── 02-herramientas-multimedia/
│   ├── multimedia-base.sh
│   └── obs-streaming.sh
├── 03-vms/
│   ├── protocolo-salmon.sh
│   └── protocolo-salmon-con-vm.sh
├── 04-redes/
│   └── cambiar-mac.sh
├── 05-utils/
│   └── crear-estructura.sh
├── README.md
└── LICENSE
````

---

## 🚀 Instalación rápida

```bash
git clone https://github.com/Ylogther/ml4w.git
cd ml4w
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

