# PowerShell script to automate WeMod setup with premium mod using GitHub repository
# Ensure the script is run with administrative privileges
#Requires -RunAsAdministrator

# Define URLs for downloading files
$weModInstallerUrl = "https://raw.githubusercontent.com/Quan2808/WeMod-Mod-Setup/main/installer/WeMod_8.2.0_Installer.exe"
$weModPremiumZipUrl = "https://raw.githubusercontent.com/Quan2808/WeMod-Mod-Setup/main/resources/WeMod_Premium.zip"

# Define local paths
$localAppData = $env:LOCALAPPDATA
$roamingAppData = $env:APPDATA
$weModLocalPath = Join-Path $localAppData "WeMod"
$weModRoamingPath = Join-Path $roamingAppData "WeMod"
$tempDir = Join-Path $env:TEMP "WeMod_Setup"
$weModInstaller = Join-Path $tempDir "WeMod_8.2.0_Installer.exe"
$weModPremiumZip = Join-Path $tempDir "WeMod_Premium.zip"
$weModUpdateExe = Join-Path $weModLocalPath "Update.exe"
$weModUpdateRenamed = Join-Path $weModLocalPath "Update1.exe"
$weModResourcesPath = Join-Path $weModLocalPath "app-8.2.0\resources"
$tempExtractPath = Join-Path $tempDir "WeMod_Premium"

# Create temporary directory
if (-not (Test-Path $tempDir)) {
    New-Item -Path $tempDir -ItemType Directory | Out-Null
}

# Step 1: Download required files
Write-Host "Downloading WeMod installer..."
Invoke-WebRequest -Uri $weModInstallerUrl -OutFile $weModInstaller -ErrorAction Stop
Write-Host "Downloading WeMod premium zip..."
Invoke-WebRequest -Uri $weModPremiumZipUrl -OutFile $weModPremiumZip -ErrorAction Stop

# Step 2: Uninstall WeMod if installed
Write-Host "Checking for existing WeMod installation..."
$weModUninstall = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "*WeMod*" }
if ($weModUninstall) {
    Write-Host "Uninstalling WeMod..."
    $weModUninstall.Uninstall() | Out-Null
    Start-Sleep -Seconds 5
}

# Step 3: Clean WeMod directories
Write-Host "Cleaning WeMod directories..."
if (Test-Path $weModLocalPath) {
    Remove-Item -Path $weModLocalPath -Recurse -Force -ErrorAction SilentlyContinue
}
if (Test-Path $weModRoamingPath) {
    Remove-Item -Path $weModRoamingPath -Recurse -Force -ErrorAction SilentlyContinue
}

# Step 4: Install WeMod 8.2.0
Write-Host "Installing WeMod 8.2.0..."
if (Test-Path $weModInstaller) {
    Start-Process -FilePath $weModInstaller -ArgumentList "/S" -Wait
} else {
    Write-Error "WeMod installer not found at $weModInstaller"
    exit 1
}

# Step 5: Prevent WeMod from updating
Write-Host "Renaming Update.exe to prevent updates..."
if (Test-Path $weModUpdateExe) {
    Rename-Item -Path $weModUpdateExe -NewName "Update1.exe" -Force
} else {
    Write-Warning "Update.exe not found at $weModUpdateExe"
}

# Step 6: Extract and replace app.asar
Write-Host "Extracting WeMod_Premium.zip and replacing app.asar..."
if (Test-Path $weModPremiumZip) {
    # Create temporary directory for extraction
    if (-not (Test-Path $tempExtractPath)) {
        New-Item -Path $tempExtractPath -ItemType Directory | Out-Null
    }
    Expand-Archive -Path $weModPremiumZip -DestinationPath $tempExtractPath -Force
    $appAsar = Join-Path $tempExtractPath "app.asar"
    if (Test-Path $appAsar) {
        if (-not (Test-Path $weModResourcesPath)) {
            New-Item -Path $weModResourcesPath -ItemType Directory | Out-Null
        }
        Copy-Item -Path $appAsar -Destination $weModResourcesPath -Force
        Write-Host "app.asar replaced successfully."
    } else {
        Write-Error "app.asar not found in $weModPremiumZip"
        exit 1
    }
    # Clean up temporary directory
    Remove-Item -Path $tempExtractPath -Recurse -Force
} else {
    Write-Error "WeMod_Premium.zip not found at $weModPremiumZip"
    exit 1
}

# Step 7: Clean up temporary files
Write-Host "Cleaning up temporary files..."
Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "Setup complete. You can now run WeMod and log in (using a temporary email is recommended)."