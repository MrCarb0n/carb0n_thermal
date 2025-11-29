# customize.sh
# Runs in Magisk's BusyBox ash shell with "Standalone Mode" enabled

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

ui_print "- Installation complete!"
