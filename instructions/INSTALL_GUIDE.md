WeMod Premium Mod Setup
This repository provides instructions and a PowerShell script to set up WeMod version 8.2.0 with a premium mod. Follow the steps below or use the provided setup_wemod.ps1 script to automate the process.
Directory Structure

```
wemod-mod-setup/
├── resources/
│ └── WeMod_Premium.zip
├── installer/
│ └── WeMod_8.2.0_Installer.exe
└── scripts
│ └── setup.exe
```

Manual Setup Instructions

Uninstall WeMod: If WeMod is already installed, uninstall it via the Control Panel.
Clean Directories: Delete the following directories:
%LocalAppData%\WeMod
%AppData%\WeMod

Optional Registry Cleanup: Use a tool like CCleaner to clean the registry (effectiveness not guaranteed).
Download WeMod Installer: Obtain WeMod_8.2.0_Installer.exe from the installer directory or from this link.
Install WeMod: Run the installer and close WeMod immediately if it attempts to update.
Prevent Updates: Navigate to %LocalAppData%\WeMod and rename Update.exe to Update1.exe.
Download Premium Mod: Obtain WeMod_Premium.zip from the resources directory or from this link. This file is safe and contains app.asar.
Replace app.asar: Extract WeMod_Premium.zip and copy the app.asar file to %LocalAppData%\WeMod\app-8.2.0\resources, replacing the existing app.asar.
Run WeMod: Launch WeMod and log in. For safety, use a temporary email address.

Automated Setup with PowerShell

Ensure you have administrative privileges.
Place setup_wemod.ps1 in the root of the quan2808-wemod-mod-setup directory.
Open PowerShell as an administrator, navigate to the directory, and run:.\setup_wemod.ps1

The script will:
Uninstall any existing WeMod installation.
Clean WeMod directories.
Install WeMod 8.2.0.
Rename Update.exe to prevent updates.
Extract and replace app.asar from WeMod_Premium.zip.

Once complete, run WeMod and log in with a temporary email.

Notes

The WeMod_Premium.zip file is reported to be safe and contains only the app.asar file.
Using a temporary email for login is recommended to protect your personal information.
Ensure the directory structure is intact before running the script.

Disclaimer
This setup involves third-party modifications to WeMod. Use at your own risk, as it may violate WeMod's terms of service. The author is not responsible for any consequences arising from the use of this script or instructions.
