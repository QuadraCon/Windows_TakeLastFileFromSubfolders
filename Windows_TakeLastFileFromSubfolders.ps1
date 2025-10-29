$source = "C:\Source"
$destination = "C:\Destination"

#Create destination folder if it doesn't exist
if (-not (Test-Path $destination)) {
    New-Item -ItemType Directory -Path $destination | Out-Null
}

#Loop through each subfolder
Get-ChildItem -Path $source -Directory | ForEach-Object {
    $latest = Get-ChildItem -Path $_.FullName -Filter "*-Config.txt" |
              Sort-Object LastWriteTime -Descending |
              Select-Object -First 1

    if ($latest) {
        Copy-Item -Path $latest.FullName -Destination (Join-Path $destination $latest.Name)
        Write-Host "Copied $($latest.Name) from $($_.Name)"
    }
}