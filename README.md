# phoe-nix
Building my NixOS config...or burning it down...

# Instalación
En una instalación limpia de NixOS, seleccionando en la instalación "no desktop"...
```bash
nix-shell -p git
git clone https://github.com/FORGIS98/phoe-nix.git ; cd phoe-nix ; sh setup.sh
```
# Wifi? - Simple
```bash
nmcli dev wifi list
nmcli dev wifi connect "nombre" password "passw"
```