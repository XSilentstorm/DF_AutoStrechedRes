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
- QRes 1.1 by Anders Kjersem

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

## Installation

1. Download the release ZIP and extract its contents.
2. Ensure `QRes.exe` is available in the location expected by the tool.
3. Run `Install.bat` as administrator.
4. If Windows blocks the PowerShell script due to an execution policy restriction, follow the instructions below.
5. Once installed, launch the tool using the **Play Delta Force 4-3** desktop shortcut.

## PowerShell Execution Policy

The tool uses a PowerShell (`.ps1`) script to monitor Delta Force and handle resolution switching.

**You may not need to change anything.** If the script runs normally, leave your PowerShell settings as they are.

If Windows blocks the script because of your execution policy, open PowerShell and check the current policy:

```powershell
Get-ExecutionPolicy
```

If necessary, allow locally created scripts for your user account by running:

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

Confirm the change if prompted, then try launching the tool again.

**Security note:** Only run scripts you trust. Avoid setting the policy to `Unrestricted` or disabling security protections globally. If your computer is managed by an organization, its policies may prevent you from changing this setting.

## Usage

1. Launch **Play Delta Force 4-3** using the desktop shortcut.
2. The tool monitors Delta Force and detects when the game starts.
3. The display switches to the selected 4:3 resolution.
4. Play Delta Force in borderless windowed mode with GPU full-screen scaling enabled.
5. Close Delta Force when finished. The tool restores your original display resolution and refresh rate.

If no suitable 4:3 resolution is detected, the tool uses **1024×768** as a fallback.

## How It Works

The tool monitors the Delta Force process in the background. When the game launches, it uses QRes to switch Windows to a supported 4:3 resolution. Your GPU's full-screen scaling then stretches the image to fill your 16:9 monitor.

When the game closes, the tool restores your original display settings.

## Third-Party Software

This project uses **QRes 1.1** by Anders Kjersem to change display resolutions.

- Original download: [QRes on Softpedia](https://www.softpedia.com/get/Multimedia/Video/Other-VIDEO-Tools/QRes.shtml)
- Copyright © 2003 Anders Kjersem. All rights reserved.

QRes is a third-party utility and is not developed or maintained by this project. Please respect its original copyright notice and applicable distribution terms.

## Disclaimer

This is an unofficial community tool and is not affiliated with, endorsed by, or supported by the developers of Delta Force.

Use at your own risk. Resolution switching depends on your monitor, GPU, drivers, and supported display modes.
