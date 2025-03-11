# cp_latest dir

Powershell script to search for and copy subdirectory with the latest timestamp.
Creates non-existent target directory to copy subdirectory to.

## Parameters
```
PS> .\cp_latest_dir.ps -Source </path/to/source dir> -Target </path/to/target dir>
```
1. Source: directory path to search recursively for latest subdirectory
2. Target: directory path to copy the subdirectory with latest timestamp to
   
Leave out any trailing forward slash character from directory path names.

## Examples:
```
PS> cp_latest_dir.ps1 -Source "\\app-server\patches" -Target "D:\patches"
```
