$nimi = Read-Host "Kirjutage enda nimi"
$tervitus = [int](Read-Host "Kirjutage mitu korda tuleb Teid tervitada")

$report = {

"=== Tervitus ==="
for ($i = 1; $i -le $tervitus; $i++) {
    "Tere, $nimi!"
}

""
"=== Susteemiinfo ==="
"Arvuti nimi: $env:COMPUTERNAME"
"Kasutajanimi: $env:USERNAME"
"PowerShelli versioon: $($PSVersionTable.PSVersion)"

""
"=== 3 tootavat protsessi ==="
(Get-Process | Select-Object -First 3 Name, Id, CPU | Format-Table -AutoSize | Out-String).TrimEnd()

""
"=== 3 teenust koos olekuga ==="
(Get-Service | Select-Object -First 3 Name, Status | Format-Table -AutoSize | Out-String).TrimEnd()

""
"=== PowerShelli versiooni kontroll ==="
if ($PSVersionTable.PSVersion.Major -lt 5) {
    "Teie PowerShelli versioon on vananenud."
} else {
    "Teie PowerShelli versioon on sobiv."
}

}

# kirjutab faili
& $report | Out-File "report.txt" -Encoding utf8

# kuvab ekraanile sama sisu
& $report | Out-Host

Write-Host "===========================" -ForegroundColor Green
Write-Host "Script finished successfully" -ForegroundColor Green
Write-Host "===========================" -ForegroundColor Green