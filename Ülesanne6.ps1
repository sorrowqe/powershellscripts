$backupRoot = "C:\Backup"

# Loo C:\Backup kaust kui seda pole
if (-not (Test-Path $backupRoot)) {
    New-Item -ItemType Directory -Path $backupRoot | Out-Null
    Write-Host "Created backup directory: $backupRoot"
}

# Kuupäev failinime jaoks kujul PP.MM.YYYY
$date = Get-Date -Format "dd.MM.yyyy"

# Hangi kõik AD kasutajad (v.a süsteemikontod)
$users = Get-ADUser -Filter * -Properties HomeDirectory | Where-Object { $_.Enabled -eq $true }

foreach ($user in $users) {
    $samAccount   = $user.SamAccountName
    $homeDir      = $user.HomeDirectory

    # Kontrolli, kas kasutajal on kodukataloog määratud ja see eksisteerib
    if (-not $homeDir) {
        Write-Host "SKIP: $samAccount - no home directory configured in AD"
        continue
    }

    if (-not (Test-Path $homeDir)) {
        Write-Host "SKIP: $samAccount - home directory '$homeDir' does not exist"
        continue
    }

    # Varunduse failinimi: kasutajanimi-PP.MM.YYYY.zip
    $zipName = "$samAccount-$date.zip"
    $zipPath = Join-Path $backupRoot $zipName

    # Tee varundus - ZIP
    try {
        Compress-Archive -Path "$homeDir\*" -DestinationPath $zipPath -Force
        Write-Host "OK: $samAccount - backup saved to $zipPath"
    }
    catch {
        Write-Host "ERROR: $samAccount - backup failed: $_"
    }
}

Write-Host ""
Write-Host "Backup completed. Files saved to $backupRoot"