### Device specifications

Basic   | Spec Sheet
-------:|:-------------------------
CPU     | Octa-core (2x2.0 GHz Cortex-A75 & 6x1.8 GHz Cortex-A55)
Chipset | Unisoc T616 (12 nm)
GPU     | Mali-G57 MP2
Memory  | 4GB,6GB RAM
Shipped Android Version | 11 GO
Storage | 64GB,128GB eMMC 5.1
Battery | 5000 mAh, non-removable
Display | 720 x 1600 pixels, 20:9 ratio (~270 ppi density)

## Features

Blocking checks
- [X] Correct screen/recovery size
- [X] Working Touch, screen
- [X] Backup to internal/microSD
- [X] Restore from internal/microSD
- [X] reboot to system
- [X] ADB


Medium checks
- [X] update.zip sideload
- [X] UI colors (red/blue inversions)
- [X] Screen goes off and on
- [X] F2FS/EXT4 Support, exFAT/NTFS where supported
- [X] (Need to fix) all important partitions listed in mount/backup lists
- [ ] (Untested) backup/restore to/from external (USB-OTG) storage
- [ ] (Untested) backup/restore to/from adb (https://gerrit.omnirom.org/#/c/15943/)
- [ ] decrypt /data
- [X] Correct date


Minor checks
- [X] (WIP) MTP export
- [X] reboot to bootloader
- [X] reboot to recovery
- [X] poweroff
- [X] battery level
- [X] temperature
- [ ] encrypted backups
- [X] (Untested) input devices via USB (USB-OTG) - keyboard, mouse and disks
- [ ] USB mass storage export (device does not support it)
- [X] set brightness
- [ ] vibrate
- [X] screenshot
- [X] (Untested) partition SD card

## Compile

First checkout minimal twrp with aosp tree:

```
repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
repo sync -j$(nproc --all)
```

Then add these projects to .repo/manifest.xml:

```xml

```

Finally execute these:

```
source build/envsetup.sh
repopick <needed patch>
lunch twrp_Z60plus-eng
mka vendorbootimage -j$(nproc --all)
```
