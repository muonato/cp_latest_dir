# muonato/cp_latest_dir.ps1 @ GitHub (11-MAR-2025)
#
# Recursively copy directory with the latest timestamp.
# Creates non-existent target directory to copy to.
#
# Usage:
#       PS> cp_latest.ps1 "<source>" "<target>"
#
# Parameters:
#       1: Path to source directory
#       2: Path to target directory
#
# Examples:
#       PS> cp_latest.ps1 -Source "\\app-server\patches" -Target "D:\patches"
#
# Platform:
#       Powershell 7.5.0
#
param (
    [string]$Source,
    [string]$Target = ".\"
)
# Validate source directory
if (Test-Path $Source) {
    Write-Output "Searching for latest in '$Source'"
} else {
    Write-Output "Invalid path, quotes maybe missing ?`r`n`t'$Source'`r`n`t'$Target'"
    exit
}

# Validate target directory
if (Test-Path $Target) {
    Write-Output "Found target directory '$Target'"
} else {
    Write-Output "Creating new directory '$Target'"
    New-Item -ItemType Directory -Force -Path $Target
}

# Get directory with the most recent timestamp
$Latest = Get-ChildItem -Path $Source -Directory -Recurse |
    Sort-Object CreationTime |
    Select-Object -Last 1

# Copy the directory with latest timestamp to target
$Destination = "$Target\$(Split-Path $Latest -Leaf)"
if ( Test-Path $Destination ) {
	Write-Output "Destination path '$Destination' already exists, skipping"
} else {
	Write-Output "Copying ($($Latest.CreationTime)): $($Latest.FullName)"
	Copy-Item -Path $Latest.FullName -Destination $Target -Recurse
}

exit
