<!--
=====================================================================
 _____         _   ___     
|     |___ ___| |_|   |___ 
|   --| .'|  _| . | | |   |
|_____|__,|_| |___|___|_|_|
 T H E R M A L by MrCarb0n
=====================================================================
 CHANGELOG
 MIDO NEVER DIES — GUARDIAN EDITION (v2.8)

 Author : Tiash (@MrCarb0n)
 Git    : https://github.com/MrCarb0n/carb0n_thermal.git
 License: MIT License
=====================================================================
-->

# Changelog

## v2.8 (Guardian Edition) - December 2, 2025

**Guardian of battery health** - Separate module that protects and extends battery lifespan.

### 🛡️ Protection Systems Activated

**Battery Charging Shield**

- **Maximum temp lowered**: 56°C → 48°C (8°C safer)
- **Smoother monitoring**: 6000ms → 8000ms sampling
- **Mission**: Keep battery below 45-50°C during all scenarios

**CPU Thermal Defense**

- **Cluster throttling**: Reduced max frequency by 15% (2016 → 1714 MHz)
- **Proactive intervention**: Set points lowered by 2°C (44°C → 42°C)
- **Per-core protection**: All cores throttle 3°C earlier (80°C → 77°C)
- **Effect**: Prevents CPU-induced battery heating

**GPU Thermal Management**

- **Smoother response**: 500ms → 1000ms sampling
- **Earlier shutdown**: 88°C → 86°C to protect battery from GPU heat

**Power Draw Prevention**

- **WLAN vigilance**: Activates at 38°C (from 52°C) - 14°C earlier
- **Modem watchdog**: Activates at 48°C (from 60°C) - 12°C earlier
- **Display dimming**: Starts at 42°C (from 48°C) - 6°C earlier
- **Effect**: Reduces heat generation at the source

### Module Configuration

- **Guardian ID**: `carb0n_thermal_battery` (separate from standard)
- **Version**: v2.8 (Guardian Edition)
- **Branch**: `battery` (guardian updates)

### The Guardian's Compromise

To protect your battery, performance is traded:

- ~15% lower peak CPU frequency
- Earlier throttling during intensive tasks
- Screen dimming at moderate temperatures

**Guardian's Promise**: Your battery will thank you with years of extra life 🛡️

---

## v2.8 (Standard) - December 2, 2025

- Version bump and stability improvements.
- Refined thermal management parameters.
- Updated all project references to v2.8.

## v2.7 (2025)

- Initial release of the Magisk/KSU module.
- Based on "FINAL SMOOTH THROTTLING EDITION" config.
- Added `sepolicy.rule` to fix `hal_power_default` SELinux denial.
- Systemless installation to `/system/etc` and `/vendor/etc`.
