$source = "C:\Scripts\Cisco-SecureCRT_SaveConfig\Backups"
$destination = "C:\Scripts\Windows_TakeLastFileFromSubfolders\LatestConfigs"

#Create destination folder if it doesn't exist
if (-not (Test-Path $destination)) {
    New-Item -ItemType Directory -Path $destination | Out-Null
}

#Loop through each subfolder
Get-ChildItem -Path $source -Directory | ForEach-Object {
    $latest = Get-ChildItem -Path "$($_.FullName)\*" -File -Include "*-Config.txt", "*-InventoryAndVersion.txt" |
              Sort-Object LastWriteTime -Descending |
              Select-Object -First 1

    if ($latest) {
        Copy-Item -Path $latest.FullName -Destination (Join-Path $destination $latest.Name)
        Write-Host "Copied $($latest.Name) from $($_.Name)"
    }
}$source = "C:\Scripts\Cisco-SecureCRT_SaveConfig\Backups"
$destination = "C:\Scripts\Windows_TakeLastFileFromSubfolders\LatestConfigs"

# Create destination folder if it doesn't exist
if (-not (Test-Path $destination)) {
    New-Item -ItemType Directory -Path $destination | Out-Null
}

# Loop through each subfolder
Get-ChildItem -Path $source -Directory | ForEach-Object {

    # Latest Config
    $latestConfig = Get-ChildItem -Path $_.FullName -File -Filter "*-Config.txt" |
                    Sort-Object LastWriteTime -Descending |
                    Select-Object -First 1

    # Latest InventoryAndVersion
    $latestInventory = Get-ChildItem -Path $_.FullName -File -Filter "*-InventoryAndVersion.txt" |
                       Sort-Object LastWriteTime -Descending |
                       Select-Object -First 1

    if ($latestConfig) {
        Copy-Item -Path $latestConfig.FullName -Destination (Join-Path $destination $latestConfig.Name) -Force
        Write-Host "Copied Config: $($latestConfig.Name) from $($_.Name)"
    }

    if ($latestInventory) {
        Copy-Item -Path $latestInventory.FullName -Destination (Join-Path $destination $latestInventory.Name) -Force
        Write-Host "Copied Inventory: $($latestInventory.Name) from $($_.Name)"
    }
}