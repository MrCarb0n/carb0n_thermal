# Carb0n Thermal 🛡️

## 🔋 Advanced Thermal Management

**Version**: v2.8  
**Role**: Battery health & Performance optimizer  
**Mission**: Keep battery temperatures below **36-42°C** during charging while maintaining smooth performance.

---

## What is Thermal-Engine?

The **thermal-engine** is a daemon that runs on Qualcomm Snapdragon devices to manage thermal conditions. It continuously monitors temperature sensors across the SoC and triggers mitigation actions to prevent overheating.

### How It Works

Carb0n Thermal reconfigures thermal-engine with **battery-first priorities**:

1. **Monitor** thermal sensors (battery, CPU cores, GPU, case, modem, camera)
2. **Predict** temperature trends using steady-state and monitoring algorithms
3. **Act** proactively by throttling frequencies, reducing power, dimming display
4. **Protect** your battery from heat-induced degradation

---

## 🌡️ Thermal Sensors Monitored

Carb0n Thermal continuously monitors these hardware sensors:

| Sensor | Location | Purpose |
|--------|----------|---------|
| **case-therm-adc** | Device case | Overall device temperature |
| **apc0-cpu0-usr** to **apc0-cpu3-usr** | CPU Cluster 0 (Little cores) | Per-core temp monitoring |
| **apc1-cpu0-usr** to **apc1-cpu3-usr** | CPU Cluster 1 (Big cores) | Per-core temp monitoring |
| **gpu0-usr** | Adreno 506 GPU | Graphics processor temp |
| **xo-therm-adc** | Crystal oscillator | System-wide thermal reference |
| **pa-therm** | Power amplifier | Speaker/audio thermal monitoring |
| **camera-usr** | Camera sensor | Camera module temperature |
| **VIRTUAL-CPU** | Software sensor | Averaged CPU cluster temperatures |

---

## 🛡️ Protection Systems

### 1. Battery Charging Shield

**Algorithm**: Monitor  
**Sensor**: `case-therm-adc`  
**Sampling**: Every 8 seconds (increased from 6s for smoother response)

```
Thresholds:  36°C → 37°C → 38°C → 39°C → 40°C → 41°C → 42°C
Clear Points: 34°C → 35°C → 36°C → 37°C → 38°C → 39°C → 40°C
Actions:      Level 1-7 charging current reduction
```

**What it does:**

- Monitors case temperature as proxy for battery temperature
- Progressively reduces charging current as temperature rises
- 7 granular steps for ultra-aggressive battery protection
- **Maximum limit**: 42°C (vs 56°C standard) - **14°C safer**
- Prevents lithium plating and electrolyte degradation during charging

---

### 2. CPU Thermal Defense

#### Cluster-Level Protection

**Algorithm**: Steady-State (SS)  
**Sensors**: `case-therm-adc`  
**Sampling**: Every 4 seconds  
**Time Constant**: 300ms (smooth gradual throttling)

**Cluster 0 & 1 (All 8 cores):**

```
Set Points:       42°C → 42.5°C → 43°C → 43.5°C → 44°C
Clear Points:     41°C → 41.5°C → 42°C → 42.5°C → 43°C
Max Frequency:    1714 MHz (reduced from 2016 MHz = 15% reduction)
```

**What it does:**

- Limits maximum CPU frequency to reduce heat generation
- Starts throttling at **42°C** (vs 44°C standard) - **2°C earlier**
- Prevents CPU from driving up case/battery temperature
- Smooth transitions prevent sudden performance drops

#### Per-Core Protection

**Algorithm**: Steady-State (SS)  
**Sensors**: Individual core temperature sensors  
**Sampling**: Every 200ms (fast response)  
**Time Constant**: 200ms

**Little Cores (CPU0-3):**

```
Set Points:    77°C → 78°C → 79°C → 80°C → 81°C
Clear Points:  76°C → 77°C → 78°C → 79°C → 80°C
```

**Big Cores (CPU4-7):**

```
Set Points:    78°C → 79°C → 80°C → 81°C → 82°C
Clear Points:  77°C → 78°C → 79°C → 80°C → 81°C
```

**What it does:**

- Fine-grained per-core frequency throttling
- Starts at **77-78°C** (vs 80-81°C standard) - **3°C earlier**
- Prevents individual cores from creating hotspots near battery
- Each core independently throttled based on its own temperature

#### Virtual CPU Monitor

**Algorithm**: Virtual (averaging)  
**Sensors**: Big cluster cores + L2 cache  
**Sampling**: Every 200ms

```
Trip Point: 84°C
Clear Point: 80°C
Math Mode: Average (2)
```

**What it does:**

- Averages temperatures across big cluster
- Emergency shutdown at extreme temperatures (74-78°C)
- Final safety net before hardware thermal shutdown

---

### 3. GPU Thermal Management

**Algorithm**: Monitor  
**Sensor**: `gpu0-usr`  
**Sampling**: Every 1000ms (increased from 500ms for smoother response)

```
Thresholds:  76°C → 77°C → 78°C → 79°C → 80°C → 81°C → 82°C → 83°C → 84°C → 85°C → 86°C
Clear Points: 75°C → 76°C → 77°C → 78°C → 79°C → 80°C → 81°C → 82°C → 83°C → 84°C → 85°C
Actions:      GPU freq reduction levels 1-10 → Emergency shutdown
```

**What it does:**

- Monitors GPU temperature during gaming/graphics workloads
- Progressive frequency throttling across 10 levels
- Emergency shutdown at **86°C** (vs 88°C standard) - **2°C safer**
- Slower sampling prevents thermal shock to battery

---

### 4. WLAN Power Mitigation

**Algorithm**: Monitor  
**Sensor**: `case-therm-adc`  
**Sampling**: Every 6 seconds

```
Thresholds:  38°C → 40°C → 42°C → 44°C → 46°C → 48°C → 50°C
Clear Points: 36°C → 38°C → 40°C → 42°C → 44°C → 46°C → 48°C
Actions:      WLAN power reduction levels 1-7
```

**What it does:**

- Activates at **38°C** (vs 52°C standard) - **14°C earlier!**
- Reduces WiFi transmit power and scanning frequency
- Prevents wireless radio from contributing to battery heating
- Maintains connectivity while reducing power draw

---

### 5. Modem PA Mitigation

**Algorithm**: Monitor  
**Sensor**: `case-therm-adc`  
**Sampling**: Every 6 seconds

```
Thresholds:  48°C → 50°C → 52°C → 54°C → 56°C → 58°C → 60°C
Clear Points: 46°C → 48°C → 50°C → 52°C → 54°C → 56°C → 58°C
Actions:      Modem PA power reduction levels 1-7
```

**What it does:**

- Activates at **48°C** (vs 60°C standard) - **12°C earlier**
- Reduces cellular modem power amplifier output
- Prevents modem from heating battery during calls/data transfers
- May slightly reduce signal strength at high temperatures

---

### 6. Display Backlight Control

**Algorithm**: Monitor  
**Sensor**: `case-therm-adc`  
**Sampling**: Every 5 seconds

```
Thresholds:  42°C → 43°C → 44°C → 45°C → 46°C
Clear Points: 40°C → 41°C → 42°C → 43°C → 44°C
Actions:      Brightness limits: 1536 → 1280 → 1024 → 768 → 512 (out of 4095)
```

**What it does:**

- Activates at **42°C** (vs 48°C standard) - **6°C earlier**
- Progressively dims screen to reduce backlight power consumption
- Display backlight can generate significant heat near battery
- Minimum brightness: 12.5% at 46°C

**LCD Monitor State (Additional):**

- Sensor: `xo-therm-adc`
- Targets LCD refresh rate/power states at extreme temps (66-69°C)

---

### 7. Camera Thermal Protection

**Algorithm**: Monitor  
**Sensor**: `camera-usr`  
**Sampling**: Every 1 second

```
Thresholds:  57°C → 58°C → 59°C → 60°C → 61°C
Clear Points: 55°C → 56°C → 57°C → 58°C → 59°C
Actions:      Camera power/framerate reduction levels 1-5
```

**What it does:**

- Monitors camera sensor temperature during video recording
- Reduces framerate, resolution, or ISP processing
- Prevents sustained camera use from overheating battery

---

### 8. Speaker/Audio Protection

**Algorithm**: Monitor  
**Sensor**: `pa-therm` (power amplifier thermal sensor)  
**Sampling**: Every 5 seconds

```
Thresholds:  63°C → 64.5°C → 66°C → 67.5°C → 69°C
Clear Points: 60°C → 61.5°C → 63°C → 64.5°C → 66°C
Actions:      Speaker output reduction levels 1-5
```

**What it does:**

- Monitors speaker amplifier temperature
- Reduces audio output volume at high temperatures
- Protects amplifier and prevents distortion

---

### 9. Emergency Shutdowns

**High Temperature Emergency:**

- Sensor: `xo-therm-adc`
- Threshold: **90°C**
- Action: Immediate system shutdown

**CPU Emergency:**

- Sensor: `VIRTUAL-CPU`
- Thresholds: Progressive shutdowns from 65-78°C
- Action: System shutdown before hardware thermal limit

---

## 📊 Temperature Targets

| Scenario | Target |
|----------|--------|
| **Max Charging Temp** | 42°C |
| **CPU Cluster Throttle Start** | 42°C |
| **Per-Core CPU Throttle** | 77-78°C |
| **GPU Shutdown** | 86°C |
| **WLAN Mitigation Start** | 38°C |
| **Modem Mitigation Start** | 48°C |
| **Backlight Dimming Start** | 42°C |
| **CPU Max Frequency** | 1714 MHz |

---

## 🔬 Battery Science: Why This Matters

### Lithium-Ion Battery Chemistry

**Optimal Operating Range**: 15-35°C  
**Acceptable Range**: 0-45°C  
**Degradation Accelerates**: Above 45°C

### Heat-Induced Damage Mechanisms

1. **Lithium Plating** (during charging above 45°C)
   - Metallic lithium deposits on anode instead of intercalating
   - Reduces capacity and creates safety hazards
   - **Carb0n Thermal protects**: Caps charging at 48°C vs 56°C standard

2. **Electrolyte Decomposition** (sustained high temps)
   - SEI layer growth consumes lithium and electrolyte
   - Increases internal resistance
   - **Carb0n Thermal protects**: Earlier throttling keeps average temps lower

3. **Structural Degradation** (thermal cycling)
   - Expansion/contraction damages electrode structure
   - Creates microcracks and particle isolation
   - **Carb0n Thermal protects**: Smoother thermal transitions, less shock

### Long-Term Impact

By keeping temperatures lower, you can expect significantly better battery health retention over time compared to standard thermal configurations.

**Estimated Capacity Retention:**

- Year 1: ~95% capacity remaining
- Year 2: ~85% capacity remaining
- Year 3: ~75% capacity remaining (still usable)

**Result**: 1-2 extra years of viable battery life

---

## ⚖️ Trade-offs

To protect your battery, Carb0n Thermal makes these compromises:

### Performance Impact

- **CPU**: 15% lower peak frequency (1714 vs 2016 MHz)
- **Gaming**: May throttle during extended sessions (30+ min)
- **Benchmarks**: Will score 10-15% lower in CPU tests
- **Daily use**: Minimal impact for browsing, social media, video

### User Experience

- **Screen**: May dim at 42°C+ (restore by cooling device)
- **WiFi/4G**: Slight signal reduction at high temps
- **Charging**: May slow down if device exceeds 48°C
- **Speaker**: Volume reduction above 63°C

**The Reward**: Years of extended battery life

---

## 🎯 Who is this for?

### ✅ Perfect for

- **Long-term owners** (3-4+ years with same device)
- **Daily drivers** who prioritize reliability over benchmarks
- **Hot climate users** (temperatures regularly exceed 30°C)
- **Wireless charging users** (generates more heat than wired)
- **Battery health enthusiasts** who monitor degradation

### ❌ Not recommended for

- **Mobile gamers** needing sustained 60fps performance
- **Benchmark enthusiasts** chasing high scores
- **Power users** maxing out CPU constantly
- **Short-term owners** who upgrade yearly

---

## 📥 Installation

1. Download `carb0n_thermal_vX.X.zip`
2. Open **Magisk** or **KernelSU** app
3. Go to **Modules** → **Install from Storage**
4. Select the zip file and install
5. Reboot
6. Your battery is now under Carb0n Thermal protection 🛡️

**Note**: Module ID is `carb0n_thermal`.

---

## 📱 Compatibility

- **Device**: Redmi Note 4 (Mido)
- **SoC**: Qualcomm Snapdragon 625 (MSM8953)
- **Root**: Magisk v20.4+ or KernelSU required

---

## 🔍 Monitor Thermal Status

### Recommended Apps

- **DevCheck** - Real-time battery temps
- **Kernel Adiutor** - CPU/GPU frequencies
- **AccuBattery** - Long-term battery health tracking
- **3C Toolbox** - Thermal zone monitoring

### Target Temperatures

- **Charging**: < 42-45°C ✅
- **Heavy usage**: < 48-50°C ✅
- **Idle**: < 35-38°C ✅

### Check Thermal Status (via terminal)

```bash
# View all thermal zones
cat /sys/class/thermal/thermal_zone*/temp

# View CPU frequencies
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq

# View thermal-engine status
logcat -s ThermalEngine
```

---

## 🔧 Technical Implementation

Carb0n Thermal modifies `/system/vendor/etc/thermal-engine.conf`:

- **Systemless installation** via Magisk/KSU (no system modification)
- **SELinux policy** included for `hal_power_default` access
- **Device check** ensures Mido-only installation
- **Multiple thermal algorithms**: Monitor, Steady-State, Virtual
- **15 thermal zones** actively managed
- **8 cooling devices**: CPU, GPU, battery, WLAN, modem, LCD, camera, speaker

See [thermal-engine.conf](system/vendor/etc/thermal-engine.conf) for complete configuration.

---

## 👨‍💻 Author

**Tiash** (@MrCarb0n)  
GitHub: [MrCarb0n/carb0n_thermal](https://github.com/MrCarb0n/carb0n_thermal)

---

## 📄 License

MIT License - See [LICENSE](LICENSE) file for details.

---

**MIDO NEVER DIES (v2.8)** 🛡️
