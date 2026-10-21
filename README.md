# Delta Force Stretched Resolution Tool

Play **Delta Force in stretched 4:3 resolution on a standard 16:9 monitor** while keeping the game in borderless windowed mode.

This tool automates display resolution switching when the game launches and restores your original display settings when it closes. No more manually changing your Windows resolution every time you want to play.

## Features

- **Automatic Resolution Detection** — Detects supported 4:3 display resolutions and selects a suitable mode.
- **Automatic Resolution Switching** — Switches to 4:3 resolution when Delta Force launches.
- **Automatic Resolution Restoration** — Restores your original display resolution and refresh rate when the game closes.
- **Borderless Windowed Support** — Enables stretched 4:3 gameplay on a 16:9 monitor when configured correctly.
- **Simple Installation** — Includes an installer that configures the tool and creates a desktop shortcut.
- **Background Monitoring** — Checks for the Delta Force process every two seconds.

## Requirements

- Windows
- Delta Force
- A monitor and graphics configuration supporting a suitable 4:3 resolution
- Administrator privileges for installation
- [QRes 1.1](https://www.softpedia.com/get/Multimedia/Video/Other-VIDEO-Tools/QRes.shtml) by Anders Kjersem

## Configuration

Before launching the tool, configure the following settings.

### 1. Delta Force

Set the game's display mode to **Borderless**.

### 2. GPU Scaling

Enable full-screen scaling in your graphics control panel so the 4:3 image stretches across your entire 16:9 monitor instead of displaying black bars.

- **NVIDIA:** NVIDIA Control Panel → Adjust desktop size and position → Scaling mode → Full-screen
- **AMD:** AMD Software: Adrenalin Edition → Display → GPU Scaling / Scaling Mode → Full panel, where available
- **Intel:** Intel Graphics Command Center → Display → Scale → Stretched, where available

Menu names and available options may vary depending on your GPU, driver, and display configuration.

## Installation & Usage

1. Download or clone this repository.
2. Ensure QRes 1.1 is available in the location expected by the tool.
3. Run `Install.bat` with administrator privileges.
4. Launch the game using the **Play Delta Force 4-3** desktop shortcut.
5. The tool detects when Delta Force starts and switches to the selected 4:3 resolution.
6. Close Delta Force when finished. Your original display resolution and refresh rate will be restored.

## How It Works

The tool monitors the Delta Force process in the background. When the game launches, it uses QRes to switch Windows to a supported 4:3 resolution. Your GPU's full-screen scaling stretches the image to fill your monitor.

When the game closes, the tool restores your original display settings.

If no suitable 4:3 resolution is detected, the tool uses **1024×768** as a fallback.

## Third-Party Software

This project uses **QRes 1.1** by Anders Kjersem to change display resolutions.

- Original download: [QRes on Softpedia](https://www.softpedia.com/get/Multimedia/Video/Other-VIDEO-Tools/QRes.shtml)
- Copyright © 2003 Anders Kjersem. All rights reserved.

QRes includes its own disclaimer and is a third-party utility, not developed or maintained by this project. Its original copyright notice and applicable terms must be respected.

## Disclaimer

This is an unofficial community tool and is not affiliated with, endorsed by, or supported by the developers of Delta Force.

Use at your own risk. Resolution switching depends on your monitor, GPU, drivers, and supported display modes.


