# Mido Thermal Config (Magisk/KSU Module)

**MIDO NEVER DIES — FINAL SMOOTH THROTTLING EDITION (v2.7, 2025)**

This Magisk/KernelSU module provides a custom thermal engine configuration for the **Redmi Note 4 (Mido)** equipped with the **MSM8953** chipset. It aims to balance performance and thermal management, ensuring smooth operation without excessive throttling.

## Features

- **Optimized Charging**: Smooth charging thermal management.
- **CPU Control**: Fine-grained per-core and cluster thermal throttling.
- **GPU Control**: Adjusted GPU thermal thresholds.
- **Component Safety**: Mitigation for WLAN, Modem, Camera, Speaker, and Backlight/LCD.
- **SELinux Fix**: Includes necessary `sepolicy.rule` for `hal_power_default`.

## Installation

1. Download the latest `mido_thermal_module.zip` from the [Releases](https://github.com/MrCarb0n/midothermal/releases) page.
2. Open **Magisk** or **KernelSU** app.
3. Go to **Modules** -> **Install from Storage**.
4. Select the zip file and install.
5. Reboot.

## Compatibility

- **Device**: Redmi Note 4 (Mido)
- **SoC**: Snapdragon 625 (MSM8953)
- **Root**: Magisk or KernelSU required.

## Author

- **Tiash** (@MrCarb0n)
