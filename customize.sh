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

ui_print "- Setting permissions..."

# Set permissions for system config
set_perm $MODPATH/system/etc/thermal-engine.conf 0 0 0644

# Set permissions for vendor config
# Note: Magisk handles /system/vendor -> /vendor mapping
set_perm $MODPATH/system/vendor/etc/thermal-engine.conf 0 0 0644

ui_print "- Cleaning up..."
rm -f $MODPATH/update.json
rm -f $MODPATH/changelog.md

ui_print "- Installation complete!"
