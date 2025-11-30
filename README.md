```text
                           
 _____         _   ___     
|     |___ ___| |_|   |___ 
|   --| .'|  _| . | | |   |
|_____|__,|_| |___|___|_|_|
 T H E R M A L by MrCarb0n
                           
```

# Carb0n Thermal (Magisk/KSU Module)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-v2.7-blue.svg)](https://github.com/MrCarb0n/carb0n_thermal/releases)
[![Device](https://img.shields.io/badge/device-Redmi%20Note%204%20(Mido)-orange.svg)](https://github.com/MrCarb0n/carb0n_thermal)

**MIDO NEVER DIES — FINAL SMOOTH THROTTLING EDITION (v2.7)**

This Magisk/KernelSU module provides a custom thermal engine configuration for the **Redmi Note 4 (Mido)** equipped with the **MSM8953** chipset. It aims to balance performance and thermal management, ensuring smooth operation without excessive throttling.

## Features

- **Optimized Charging**: Smooth charging thermal management.
- **CPU Control**: Fine-grained per-core and cluster thermal throttling.
- **GPU Control**: Adjusted GPU thermal thresholds.
- **Component Safety**: Mitigation for WLAN, Modem, Camera, Speaker, and Backlight/LCD.
- **SELinux Fix**: Includes necessary `sepolicy.rule` for `hal_power_default`.

## Installation

1. Download the latest `mido_thermal_module.zip` from the [Releases](https://github.com/MrCarb0n/carb0n_thermal/releases) page.
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
- GitHub: [MrCarb0n/carb0n_thermal](https://github.com/MrCarb0n/carb0n_thermal)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
