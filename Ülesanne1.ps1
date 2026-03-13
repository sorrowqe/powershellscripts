# Lokaalse kasutaja loomise skript

$ees = Read-Host "Sisestage enda eesnimi"
$pere = Read-Host "Sisestage enda perenimi"

# Kasutajanimi kujul ees.perenimi (väiketähtedega)
$nimi = ("$ees.$pere").ToLower()
$taisnimi = "$ees $pere"
$kirjeldus = "Kasutaja $taisnimi"

$parool = ConvertTo-SecureString "Parool1!" -AsPlainText -Force

# Proovime lokaalse kasutaja luua
try {
    New-LocalUser -Name $nimi `
                  -FullName $taisnimi `
                  -Description $kirjeldus `
                  -Password $parool `
                  -ErrorAction Stop

    Write-Host "Kasutaja loodud: $nimi" -ForegroundColor Green
}
catch {
    # Kontrollime, kas probleem on olemasoleva kasutajaga
    if ($_.Exception.Message -like "*already exists*" -or $_.CategoryInfo.Reason -eq "UserExistsException") {
        Write-Host "Kasutaja loomine ebaõnnestus! Kasutaja '$nimi' on juba olemas." -ForegroundColor Red
    } else {
        Write-Host "Kasutaja loomine ebaõnnestus! Viga: $($_.Exception.Message)" -ForegroundColor Red
    }
}