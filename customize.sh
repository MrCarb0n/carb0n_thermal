#!/system/bin/sh
# =====================================================================
#  _____         _   ___     
# |     |___ ___| |_|   |___ 
# |   --| .'|  _| . | | |   |
# |_____|__,|_| |___|___|_|_|
#  T H E R M A L by MrCarb0n
# =====================================================================
#  MAGISK/KERNELSU MODULE INSTALLER SCRIPT
#  MIDO NEVER DIES (v2.8)
#
#  Author : Tiash (@MrCarb0n)
#  Git    : https://github.com/MrCarb0n/carb0n_thermal.git
#  Version: v2.8
#  License: MIT License
# =====================================================================

ui_print " _____         _   ___     "
ui_print "|     |___ ___| |_|   |___ "
ui_print "|   --| .'|  _| . | | |   |"
ui_print "|_____|__,|_| |___|___|_|_|"
ui_print " T H E R M A L by MrCarb0n"
ui_print " "
ui_print "- Installing Carb0n Thermal..."

# Device Check
ui_print "- Checking device..."
DEVICE=$(getprop ro.product.device)

if [ "$DEVICE" != "mido" ]; then
  ui_print "*************************************************"
  ui_print "! Wrong Device!"
  ui_print "! This module is for Redmi Note 4 (mido) only."
  ui_print "! Your device is detected as: $DEVICE"
  ui_print "*************************************************"
  abort
else
  ui_print "- Device match: mido"
fi

ui_print "- Searching system for thermal config..."

THERMAL_TARGET=""
for D in /vendor/etc /system/etc /system/vendor/etc /odm/etc /product/etc; do
  for N in thermal-engine.conf thermal-engine-"$DEVICE".conf thermal.conf; do
    if [ -f "$D/$N" ]; then
      THERMAL_TARGET="$D/$N"
      break
    fi
  done
  [ -n "$THERMAL_TARGET" ] && break
  P=$(ls "$D"/thermal-engine*.conf 2>/dev/null | head -n 1)
  if [ -n "$P" ]; then
    THERMAL_TARGET="$P"
    break
  fi
done

if [ -z "$THERMAL_TARGET" ]; then
  THERMAL_TARGET="/vendor/etc/thermal-engine.conf"
  ui_print "- No existing thermal found, defaulting to $THERMAL_TARGET"
else
  ui_print "- Found thermal at $THERMAL_TARGET"
fi

THERMAL_DIR=$(dirname "$THERMAL_TARGET")
case "$THERMAL_DIR" in
  /system/*) THERMAL_MAP_DIR="$MODPATH/system/${THERMAL_DIR#/system/}";;
  /*)        THERMAL_MAP_DIR="$MODPATH/system/${THERMAL_DIR#/}";;
esac
mkdir -p "$THERMAL_MAP_DIR"

CONF_FILE="$MODPATH/thermal-engine.conf"
THERMAL_DEST="$THERMAL_MAP_DIR/$(basename "$THERMAL_TARGET")"
cp -fp "$CONF_FILE" "$THERMAL_DEST"

:

ui_print "- Setting permissions..."

if [ -f "$THERMAL_DEST" ]; then
  set_perm "$THERMAL_DEST" 0 0 0644
fi
:

ui_print "- Cleaning up..."
for f in update.json changelog.md README.md LICENSE; do
  rm -f "$MODPATH/$f"
done

ui_print "- Installation complete!"
