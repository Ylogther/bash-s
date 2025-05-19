# 🛠️ Fix WiFi para RTL8852BE(ejemplo) en Arch Linux

MAS ADELANTE DE LA EXPLICACIÓN TE ENSEÑO PARA TODAS LA TARJETAS WIFI (solo bala hasta donde diga 
Optimización de Estabilidad para Tarjetas Wi-Fi en Linux)

Este README documenta la solución a problemas comunes de conectividad WiFi (latencia, cortes, inestabilidad) usando tarjetas **Realtek RTL8852BE** en sistemas Arch Linux e híbridos (Hyprland, Wayland, etc.).

---

## ✅ Problemas Solucionados

- ❌ Cortes de conexión esporádicos
- ❌ Ping alto o inestable en juegos
- ❌ Baja velocidad pese a buena señal
- ❌ Fallos al reconectar tras suspensión
- ❌ "Power save: on" causando lag

---

## 🧩 Driver correcto

Asegúrate de que estás usando el módulo **rtw89_8852be**:

```bash
lspci -k | grep -A 3 Network
```

Debe aparecer:
```
Kernel driver in use: rtw89_8852be
Kernel modules: rtw89_8852be
```

---

## ⚙️ Desactivar Power Saving

El sistema activa por defecto el ahorro de energía, lo cual perjudica el rendimiento de red.

### 1. Apagar manualmente:

```bash
sudo iw dev wlan0 set power_save off
```

Verifica con:

```bash
iw dev wlan0 get power_save
```

Debe decir: `Power save: off`

---

### 2. Apagar permanentemente con NetworkManager

Crea el archivo:

```bash
sudo nano /etc/NetworkManager/conf.d/wifi-powersave.conf
```

Y añade:

```ini
[connection]
wifi.powersave = 2
```

Reinicia NetworkManager:

```bash
sudo systemctl restart NetworkManager
```

---

## 📶 Sugerencias adicionales

### Usar 5GHz
Si tu router lo permite, conecta a una red de 5GHz para evitar interferencias.

### Verificar canales saturados:
Desde el móvil: Usa **WiFi Analyzer**  
En terminal:

```bash
iwlist wlan0 scan | grep Channel
```

---

## 📡 Comprobación de estabilidad

Haz un test de ping:

```bash
ping -i 0.2 192.168.1.1
```

Ideal:
- Latencia estable (2–5 ms)
- Sin pérdida de paquetes

---


```

---

## 🔧 Referencias

- Módulo `rtw89` del kernel Linux
- Arch Wiki: [Wireless Setup](https://wiki.archlinux.org/title/Wireless_network_configuration)
- Realtek GitHub Issues (RTL8852BE)



# 🛠️ Optimización de Estabilidad para Tarjetas Wi-Fi en Linux

Este archivo explica cómo desactivar funciones agresivas de ahorro de energía en tarjetas Wi-Fi para evitar problemas como:
- Desconexiones aleatorias
- Altos pings o lag en juegos online
- Microcortes o latencia inestabilidad 


ANTES DE ESTO DESACTIVA POWER SAVE LA EXPLICACIÓN ESTA EN EL COMIENZO DEL README

---

## 🔍 Paso 1: Identificar el módulo de tu tarjeta

Ejecuta:

```bash
lspci -k | grep -A 3 -i network
````

Busca la línea que diga `Kernel driver in use:` y `Kernel modules:`. Ahí verás el módulo que necesitas configurar.

---

## 🧩 Paso 2: Verificar que el módulo está cargado

```bash
lsmod | grep NOMBRE_DEL_MODULO
```

Reemplaza `NOMBRE_DEL_MODULO` por el módulo detectado (por ejemplo `iwlwifi`, `rtw89_pci`, `rtl8821ce`, etc).

---

## ⚙️ Paso 3: Ver parámetros disponibles del módulo

```bash
modinfo NOMBRE_DEL_MODULO | grep parm
```

Esto te dará una lista de opciones configurables del módulo.

---

## 📝 Paso 4: Crear archivo de configuración para el módulo

### ✅ Ejemplo: Tarjetas **Intel (iwlwifi)**

```bash
sudo nano /etc/modprobe.d/iwlwifi.conf
```

Contenido del archivo:

```conf
options iwlwifi power_save=0 d0i3_disable=1
```

---

### ✅ Ejemplo: Tarjetas **Realtek (rtw89\_pci o similares)**

```bash
sudo nano /etc/modprobe.d/rtl8852be.conf
```

Contenido del archivo:

```conf
options rtw89_pci disable_aspm=1 disable_clkreq=1 disable_lps_deep=1
```

---

## 🔄 Paso 5: Regenerar `initramfs` (si tu sistema lo usa)

Solo si tu sistema usa initramfs (como Arch Linux, Fedora, etc.):

```bash
sudo mkinitcpio -P
```

---

## 🔁 Paso 6: Reinicia para aplicar los cambios

```bash
sudo reboot
```

---

## ✅ Paso 7: Verifica que el cambio se haya aplicado

Consulta el valor del parámetro (si es soportado):

```bash
cat /sys/module/NOMBRE_DEL_MODULO/parameters/NOMBRE_DEL_PARAMETRO
```

---

## 🧪 Notas y recomendaciones

* No todos los módulos soportan los mismos parámetros.
* Este ajuste **reduce el ahorro energético**, lo que puede impactar levemente la batería en laptops.
* Solo se recomienda si experimentas problemas reales de conexión o latencia.

---

## 📘 Referencias

* `modinfo` para investigar módulos.
* ArchWiki, documentación de Intel y Realtek.
* Testeado en sistemas basados en Arch Linux (Hyprland, KDE, GNOME).

---

**Con estos pasos podrás estabilizar la conexión Wi-Fi de tu laptop o PC en la mayoría de los casos.**

```