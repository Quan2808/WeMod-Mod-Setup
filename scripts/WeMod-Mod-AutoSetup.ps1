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
$logFile = Join-Path $tempDir "WeMod_Setup.log"
$weModInstaller = Join-Path $tempDir "WeMod_8.2.0_Installer.exe"
$weModPremiumZip = Join-Path $tempDir "WeMod_Premium.zip"
$weModUpdateExe = Join-Path $weModLocalPath "Update.exe"
$weModUpdateRenamed = Join-Path $weModLocalPath "Update1.exe"
$weModResourcesPath = Join-Path $weModLocalPath "app-8.2.0\resources"
$tempExtractPath = Join-Path $tempDir "WeMod_Premium"

# Function to log messages to file and console
function Write-Log {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Message,
        [Parameter(Mandatory = $false)]
        [ValidateSet("INFO", "WARNING", "ERROR")]
        [string]$Level = "INFO"
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "[$timestamp] [$Level] $Message"
    Write-Host $logMessage
    Add-Content -Path $logFile -Value $logMessage -ErrorAction SilentlyContinue
}

# Function to validate URL accessibility
function Test-Url {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Url
    )
    try {
        $response = Invoke-WebRequest -Uri $Url -Method Head -UseBasicParsing -ErrorAction Stop
        return $response.StatusCode -eq 200
    } catch {
        return $false
    }
}

# Function to download a file
function Download-File {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Url,
        [Parameter(Mandatory = $true)]
        [string]$OutputPath
    )
    Write-Log -Message "Downloading $Url to $OutputPath..." -Level INFO
    try {
        Invoke-WebRequest -Uri $Url -OutFile $OutputPath -ErrorAction Stop
        Write-Log -Message "Download completed successfully." -Level INFO
    } catch {
        Write-Log -Message "Failed to download $Url. Error: $($_.Exception.Message)" -Level ERROR
        throw
    }
}

# Function to uninstall WeMod
function Uninstall-WeMod {
    Write-Log -Message "Checking for existing WeMod installation..." -Level INFO
    try {
        $weModUninstall = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "*WeMod*" }
        if ($weModUninstall) {
            Write-Log -Message "Uninstalling WeMod..." -Level INFO
            $weModUninstall.Uninstall() | Out-Null
            Start-Sleep -Seconds 5
            Write-Log -Message "WeMod uninstalled successfully." -Level INFO
        } else {
            Write-Log -Message "No existing WeMod installation found." -Level INFO
        }
    } catch {
        Write-Log -Message "Failed to uninstall WeMod. Error: $($_.Exception.Message)" -Level ERROR
        throw
    }
}

# Function to clean directories
function Clear-Directories {
    param (
        [Parameter(Mandatory = $true)]
        [string[]]$Paths
    )
    foreach ($path in $Paths) {
        if (Test-Path $path) {
            Write-Log -Message "Cleaning directory: $path" -Level INFO
            try {
                Remove-Item -Path $path -Recurse -Force -ErrorAction Stop
                Write-Log -Message "Directory $path cleaned successfully." -Level INFO
            } catch {
                Write-Log -Message "Failed to clean $path. Error: $($_.Exception.Message)" -Level ERROR
                throw
            }
        }
    }
}

# Main script execution
try {
    # Initialize logging
    if (-not (Test-Path $tempDir)) {
        New-Item -Path $tempDir -ItemType Directory -Force | Out-Null
        Write-Log -Message "Created temporary directory: $tempDir" -Level INFO
    }

    # Validate URLs
    Write-Log -Message "Validating download URLs..." -Level INFO
    if (-not (Test-Url -Url $weModInstallerUrl)) {
        Write-Log -Message "WeMod installer URL is invalid or inaccessible: $weModInstallerUrl" -Level ERROR
        throw "Invalid installer URL"
    }
    if (-not (Test-Url -Url $weModPremiumZipUrl)) {
        Write-Log -Message "WeMod premium zip URL is invalid or inaccessible: $weModPremiumZipUrl" -Level ERROR
        throw "Invalid premium zip URL"
    }

    # Download files
    Download-File -Url $weModInstallerUrl -OutputPath $weModInstaller
    Download-File -Url $weModPremiumZipUrl -OutputPath $weModPremiumZip

    # Uninstall existing WeMod
    Uninstall-WeMod

    # Clean WeMod directories
    Clear-Directories -Paths @($weModLocalPath, $weModRoamingPath)

    # Install WeMod
    Write-Log -Message "Installing WeMod 8.2.0..." -Level INFO
    if (Test-Path $weModInstaller) {
        Start-Process -FilePath $weModInstaller -ArgumentList "/S" -Wait
        Write-Log -Message "WeMod installed successfully." -Level INFO
    } else {
        Write-Log -Message "WeMod installer not found at $weModInstaller" -Level ERROR
        throw "Installer not found"
    }

    # Prevent updates
    Write-Log -Message "Renaming Update.exe to prevent updates..." -Level INFO
    if (Test-Path $weModUpdateExe) {
        Rename-Item -Path $weModUpdateExe -NewName "Update1.exe" -Force
        Write-Log -Message "Update.exe renamed successfully." -Level INFO
    } else {
        Write-Log -Message "Update.exe not found at $weModUpdateExe" -Level WARNING
    }

    # Extract and replace app.asar
    Write-Log -Message "Extracting WeMod_Premium.zip and replacing app.asar..." -Level INFO
    if (Test-Path $weModPremiumZip) {
        if (-not (Test-Path $tempExtractPath)) {
            New-Item -Path $tempExtractPath -ItemType Directory | Out-Null
        }
        Expand-Archive -Path $weModPremiumZip -DestinationPath $tempExtractPath -Force
        $appAsar = Join-Path $tempExtractPath "app.asar"
        if (Test-Path $appAsar) {
            if (-not (Test-Path $weModResourcesPath)) {
                New-Item -Path $weModResourcesPath -ItemType Directory -Force | Out-Null
            }
            Copy-Item -Path $appAsar -Destination $weModResourcesPath -Force
            Write-Log -Message "app.asar replaced successfully." -Level INFO
        } else {
            Write-Log -Message "app.asar not found in $weModPremiumZip" -Level ERROR
            throw "app.asar not found"
        }
    } else {
        Write-Log -Message "WeMod_Premium.zip not found at $weModPremiumZip" -Level ERROR
        throw "Premium zip not found"
    }

    Write-Log -Message "Setup completed successfully. You can now run WeMod and log in (using a temporary email is recommended)." -Level INFO
    Write-Log -Message "Warning: Ensure the downloaded files are from a trusted source to avoid security risks." -Level WARNING
} catch {
    Write-Log -Message "Setup failed. Error: $($_.Exception.Message)" -Level ERROR
    exit 1
} finally {
    # Clean up temporary files
    Write-Log -Message "Cleaning up temporary files..." -Level INFO
    if (Test-Path $tempDir) {
        Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
        Write-Log -Message "Temporary files cleaned successfully." -Level INFO
    }
}