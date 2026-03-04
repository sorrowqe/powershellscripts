$ees = Read-Host "Sisestage enda eesnimi: "
$pere = Read-Host "Sisestage enda perenimi: "

$nimi = ("$ees.$pere").ToLower()
$taisnimi = "$ees $pere"

$parool = ConvertTo-SecureString "Parool1!" -AsPlainText -Force

if ($?) {
    Write-Host "Kasutaja loodud: $nimi"
} else {
    Write-Host "Kasutaja loomine ebaõnnestus!"
}