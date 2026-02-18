$color = @("Red", "Green", "Yellow", "Blue")

for ($i = 1; $i -le 20; $i++) {
    $random = Get-Random -InputObject $color
    Write-Host "$i $random"
}