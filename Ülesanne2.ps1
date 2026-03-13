$ees = Read-Host "Sisestage kustutatava kasutaja eesnimi"
$pere = Read-Host "Sisestage kustutatava kasutaja perenimi"

$nimi = ("$ees.$pere").ToLower()

Write-Host "`nÜritan kustutada kasutajat: $nimi ..." -ForegroundColor Yellow

# Proovime kasutaja kustutada
# -ErrorAction Stop tagab, et vead lähevad catch-blokki
# -Confirm:$false küsib kinnitust automaatselt mitte
try {
    Remove-ADUser -Identity $nimi -Confirm:$false -ErrorAction Stop
    Write-Host "Kasutaja '$nimi' kustutamine õnnestus!" -ForegroundColor Green
}
catch {
    # $_ sisaldab veateadet
    Write-Host "Kasutaja '$nimi' kustutamine ebaõnnestus! Kasutajat ei leitud või tekkis muu viga." -ForegroundColor Red
}