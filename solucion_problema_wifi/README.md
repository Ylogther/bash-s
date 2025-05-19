# 🛠️ Fix WiFi para RTL8852BE en Arch Linux

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

## 💡 Bonus: Script Systemd para apagar power_save

Crea este servicio opcional:

```bash
sudo nano /etc/systemd/system/wifi-powersave-fix.service
```

```ini
[Unit]
Description=Disable WiFi Power Save
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/bin/iw dev wlan0 set power_save off
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

Activa el servicio:

```bash
sudo systemctl enable --now wifi-powersave-fix.service
```

---

## 🔧 Referencias

- Módulo `rtw89` del kernel Linux
- Arch Wiki: [Wireless Setup](https://wiki.archlinux.org/title/Wireless_network_configuration)
- Realtek GitHub Issues (RTL8852BE)
