# customize.sh
# Runs in Magisk's BusyBox ash shell with "Standalone Mode" enabled

ui_print "- Installing Mido Thermal Config..."

# Extract files is handled automatically by the installer before this script runs
# unless SKIPUNZIP=1 is set (which we don't use).

ui_print "- Setting permissions..."

# Set permissions for system config
set_perm $MODPATH/system/etc/thermal-engine.conf 0 0 0644

# Set permissions for vendor config
# Note: Magisk handles /system/vendor -> /vendor mapping
set_perm $MODPATH/system/vendor/etc/thermal-engine.conf 0 0 0644

ui_print "- Installation complete!"
