# muonato/cp_latest_dir.ps1 @ GitHub (27-FEB-2025)
#
# Copy sub-directory with the latest timestamp.
#
# Usage:
#       PS> cp_latest_dir.ps1 "<source>" "<target>"
#
# Parameters:
#       1: Path to source directory
#       2: Path to target directory
#
# Examples:
#       PS> cp_latest_dir.ps1 -Source "\\app-server\patches" -Target "D:\patches"
#
#       Leave out any trailing forward slash character from directory path names.
#
# Platform:
#       Powershell 7.5.0
#
param (
    [string]$Source,
    [string]$Target = ".\"
)
# Validate the paths specified as parameters
if ((Test-Path $Source) -and (Test-Path $Target)) {
    Write-Output "Searching latest sub-directory under '$Source'"
} else {
    Write-Output "Invalid path, quotes missing maybe ?`r`n`t'$Source'`r`n`t'$Target'"
    exit
}

# Get directory with the most recent timestamp
$Latest = Get-ChildItem -Path $Source -Directory -Recurse |
    Sort-Object CreationTime |
    Select-Object -Last 1

# Copy the directory with latest timestamp to target
$Destination = "$Target\$(Split-Path $Latest -Leaf)"
if ( Test-Path $Destination ) {
	Write-Output "Destination directory '$Destination' already exists, skipping"
} else {
	Write-Output "Copy latest ($($Latest.CreationTime)): $($Latest.FullName)"
	Copy-Item -Path $Latest.FullName -Destination $Target -Recurse
}

exit
