# WeMod Premium Mod Setup

<!-- [![GitHub Repo stars](https://img.shields.io/github/stars/Quan2808/WeMod-Mod-Setup)](https://github.com/Quan2808/WeMod-Mod-Setup) -->

[![GitHub last commit](https://img.shields.io/github/last-commit/Quan2808/WeMod-Mod-Setup)](https://github.com/Quan2808/WeMod-Mod-Setup)
[![License](https://img.shields.io/github/license/Quan2808/WeMod-Mod-Setup)](https://github.com/Quan2808/WeMod-Mod-Setup/blob/main/LICENSE)

This repository provides tools and instructions to set up WeMod version 8.2.0 with a Premium Mod on Windows systems. It includes installers, mod files, and PowerShell scripts for both manual and automated setup.

**⚠️ Warning**: This involves third-party modifications that may violate WeMod's Terms of Service (ToS). Use at your own risk. Always use a temporary email for WeMod login to protect your privacy.

## Features

- Install WeMod 8.2.0 (locked to avoid forced updates).
- Apply Premium Mod via `app.asar` replacement for premium features.
- Disable WeMod auto-updates to maintain mod compatibility.
- Manual setup and automated PowerShell script options.
- Safe, tested files (e.g., `WeMod_Premium.zip` contains only `app.asar`).

## Repository Structure

```
WeMod-Mod-Setup/
├── installer/
│   └── WeMod_8.2.0_Installer.exe  # Official WeMod 8.2.0 installer
├── resources/
│   └── WeMod_Premium.zip          # Premium mod archive (app.asar)
├── scripts/
│   └── WeMod-Mod-AutoSetup.ps1    # Advanced automated setup script
├── INSTALL.md                     # Detailed installation guide
└── README.md                      # This file
```

## Quick Start

1. **Manual Setup**:

   - Follow the step-by-step guide in [INSTALL.md](INSTALL.md).

2. **Automated Setup (Download Script)**:

   - Download: [WeMod-Mod-AutoSetup.ps1](https://raw.githubusercontent.com/Quan2808/WeMod-Mod-Setup/main/scripts/WeMod-Mod-AutoSetup.ps1)
   - Run in PowerShell (Admin): `.\WeMod-Mod-AutoSetup.ps1`
   - Optional: `.\WeMod-Mod-AutoSetup.ps1 -SkipCleanup` (if manually cleaned).

3. **Direct Run from GitHub**:

   - Run in PowerShell (Admin):

     ```powershell
     Invoke-Expression ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Quan2808/WeMod-Mod-Setup/main/scripts/WeMod-Mod-AutoSetup.ps1' -UseBasicParsing).Content)
     ```

   - Optional: Append `-SkipCleanup` if you cleaned manually.

## Notes

- Version: Locked to WeMod 8.2.0 to ensure mod compatibility.
- Safety:

  - Files are sourced from trusted locations. Scan with antivirus if concerned.
  - `WeMod_Premium.zip` contains only `app.asar`, reported as safe.

- Updates: If WeMod updates accidentally, re-run the setup to restore the mod.
- Legal: This is for educational purposes only. Respect WeMod's ToS.
