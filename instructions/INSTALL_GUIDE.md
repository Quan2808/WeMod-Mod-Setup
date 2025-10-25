# Installation Guide for WeMod Premium Mod Setup

This guide provides step-by-step instructions to install WeMod version 8.2.0 with the Premium Mod using files from this repository. Follow these steps carefully to avoid issues.

## Prerequisites

- **Operating System**: Windows 10 or later.
- **Permissions**: Run all commands as Administrator.
- **Tools**:
  - PowerShell (pre-installed on Windows).
  - Internet connection for downloading files.
- **Safety Tips**:
  - Use a temporary email for WeMod login to protect your privacy.
  - This mod may violate WeMod's Terms of Service (ToS). Proceed at your own risk.
  - Optional: Install CCleaner for registry cleanup.

## Method 1: Manual Installation (No Scripting)

1. **Uninstall Existing WeMod**:

   - Go to Settings > Apps > Search for "WeMod" > Uninstall.
   - Or use Control Panel > Programs and Features.

2. **Clean Directories**:

   - Delete these folders (replace `<YourUsername>` with your user folder):
     - `%LocalAppData%\WeMod` (e.g., `C:\Users\<YourUsername>\AppData\Local\WeMod`)
     - `%AppData%\WeMod` (e.g., `C:\Users\<YourUsername>\AppData\Roaming\WeMod`)

3. **Optional: Clean Registry**:

   - Use CCleaner (or similar tool) to scan and clean WeMod entries. Restart your PC.

4. **Download and Install WeMod**:

   - Download: [WeMod_8.2.0_Installer.exe](https://raw.githubusercontent.com/Quan2808/WeMod-Mod-Setup/main/installer/WeMod_8.2.0_Installer.exe)
   - Run the installer as Administrator.
   - If WeMod launches and checks for updates, close it immediately.

5. **Disable Updates**:

   - Navigate to `%LocalAppData%\WeMod`.
   - Rename `Update.exe` to `Update.exe.bak`.

6. **Apply Premium Mod**:

   - Download: [WeMod_Premium.zip](https://raw.githubusercontent.com/Quan2808/WeMod-Mod-Setup/main/resources/WeMod_Premium.zip)
   - Extract the ZIP to get `app.asar`.
   - Copy `app.asar` to `%LocalAppData%\WeMod\app-8.2.0\resources`, replacing the existing file.

7. **Launch WeMod**:
   - Run `WeMod.exe` from `%LocalAppData%\WeMod`.
   - Log in with a temporary email.
   - Enjoy Premium features!

## Method 2: Automated Installation

Use the PowerShell script for a hands-free setup.

1. **Download the Script**:

   - Get [WeMod-Mod-AutoSetup.ps1](https://raw.githubusercontent.com/Quan2808/WeMod-Mod-Setup/main/scripts/WeMod-Mod-AutoSetup.ps1)
   - Save to a folder (e.g., `C:\Downloads`).

2. **Run PowerShell as Administrator**:

   - Press Win + X > Windows PowerShell (Admin).
   - Enable script execution (one-time): `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
   - Navigate: `cd C:\Downloads` (adjust path as needed).
   - Run: `.\WeMod-Mod-AutoSetup.ps1`
     - Optional: `.\WeMod-Mod-AutoSetup.ps1 -SkipCleanup` (if you cleaned manually).

3. **Post-Installation**:
   - The script handles uninstall, cleanup, install, mod application, and temp file removal.
   - Launch WeMod manually and log in.

## Method 3: Run Script Directly from GitHub (Recommended)

Run the PowerShell script directly from the repository without downloading it manually.

1. **Open PowerShell as Administrator**:

   - Press Win + X > Windows PowerShell (Admin).
   - Enable script execution (one-time): `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`

2. **Run the Script Directly**:
   - Execute the following command in PowerShell to download and run the script:
        ```powershell
        Invoke-Expression ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Quan2808/WeMod-Mod-Setup/main/scripts/WeMod-Mod-AutoSetup.ps1' -UseBasicParsing).Content)
        ```
   - Optional: If you manually cleaned WeMod directories and registry, append the -SkipCleanup flag:
        ```powershell
        Invoke-Expression ((Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Quan2808/WeMod-Mod-Setup/main/scripts/WeMod-Mod-AutoSetup.ps1' -UseBasicParsing).Content) -SkipCleanup
        ```
3. **Post-Installation**:

    - The script automatically handles uninstall, cleanup (unless -SkipCleanup is used), installation, mod application, and temp file cleanup.
    - Launch WeMod manually from %LocalAppData%\WeMod\WeMod.exe.
    - Log in with a temporary email.
