# WeMod Premium Mod Setup Instructions

This document provides instructions to set up WeMod version 8.2.0 with a premium modification using files from the GitHub repository: https://github.com/Quan2808/WeMod-Mod-Setup.

## Prerequisites

- Administrative privileges on a Windows system.
- A tool like CCleaner (optional) for registry cleanup.
- A temporary email address for logging into WeMod (recommended for safety).
- Internet access to download files from GitHub.

## Directory Structure

The required files are hosted at:

```
wemod-mod-setup/
├── resources/
│ └── WeMod_Premium.zip
├── installer/
│ └── WeMod_8.2.0_Installer.exe
├── scripts/
│ └── setup.ps1
```

## Manual Setup Instructions

1.  Uninstall WeMod:

- If WeMod is installed, uninstall it via the Control Panel or Settings.

2. Clean WeMod Directories:

- Delete the following directories:

  `%LocalAppData%\WeMod` (e.g., `C:\Users\<YourUsername>\AppData\Local\WeMod`)

  `%AppData%\WeMod` (e.g., `C:\Users\<YourUsername>\AppData\Roaming\WeMod`)

3. Optional Registry Cleanup:

- Use a tool like CCleaner to clean the Windows registry. This step is optional and its effectiveness is not guaranteed.

4. Download WeMod Installer:

- Download `WeMod_8.2.0_Installer.exe` from: `https://raw.githubusercontent.com/Quan2808/WeMod-Mod-Setup/main/installer/WeMod_8.2.0_Installer.exe`

5. Install WeMod:

- Run the downloaded installer.
- If WeMod attempts to update after installation, close it immediately to prevent updates.

6. Prevent Updates:

- Navigate to `%LocalAppData%\WeMod.`
- Locate `Update.exe` and rename it to `Update1.exe` (or similar) to disable automatic updates.

7. Download Premium Mod:

- Download `WeMod_Premium.zip` from: `https://raw.githubusercontent.com/Quan2808/WeMod-Mod-Setup/main/resources/WeMod_Premium.zip`
- This file is reported to be safe and contains the `app.asar` file.

8. Replace app.asar:

- Extract `WeMod_Premium.zip` to access the `app.asar` file.
- Copy `app.asar` to `%LocalAppData%\WeMod\app-8.2.0\resources`, replacing the existing `app.asar` file.

9. Run WeMod:

Launch WeMod and log in. For safety, use a temporary email address.

## Automated Setup with PowerShell

1. Download the Setup Script:

- Download `setup.ps1` from: `https://raw.githubusercontent.com/Quan2808/WeMod-Mod-Setup/main/scripts/setup.ps1`
- Save it to a local directory (e.g., `C:\Users\<YourUsername>\Downloads`).

2. Run the Script:

- Open PowerShell as an administrator.
- Navigate to the directory containing `setup.ps1` using: `cd <path-to-directory>`

- Run the script: `.\setup.ps1`

3. Script Actions:

- Downloads the required files from the GitHub repository.
- Uninstalls any existing WeMod installation.
- Cleans WeMod directories.
- Installs WeMod 8.2.0.
- Renames `Update.exe` to prevent updates.
- Extracts and replaces `app.asar` from `WeMod_Premium.zip`.
- Cleans up temporary files.

4. Post-Setup:

- Once the script completes, launch WeMod and log in with a temporary email.

## Notes

- The `WeMod_Premium.zip` file is reported to be safe and contains only the app.asar file.
- Using a temporary email is recommended to protect your personal information.
- Ensure a stable internet connection for downloading files.

## Disclaimer

This setup involves third-party modifications to WeMod, which may violate its terms of service. Proceed at your own risk. The author is not responsible for any consequences resulting from the use of these instructions or the script.
