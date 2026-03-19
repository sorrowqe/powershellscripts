# Loe kasutajad CSV-failist
$users = Import-Csv -Path "adkasutajad.csv"

foreach ($user in $users) {
    # Transliteeri ees- ja perekonnanimi
    $firstName  = $user.FirstName
    $lastName   = $user.LastName

    # Koosta SamAccountName, UPN ja DisplayName
    $samAccount     = ($firstName + "." + $lastName).ToLower()
    $upn            = "$samAccount@sv-kool.local"
    $displayName    = "$firstName $lastName"
    $password       = ConvertTo-SecureString $user.Password -AsPlainText -Force

    # Kontrolli, kas kasutaja juba eksisteerib AD-s
    $existingUser = Get-ADUser -Filter { SamAccountName -eq $samAccount } -ErrorAction SilentlyContinue

    if ($existingUser) {
        # Kasutaja on juba olemas
        Write-Host "User $samAccount already exists - can not add this users"
    } else {
        # Kasutajat pole - proovime lisada
        New-ADUser `
            -Name $displayName `
            -GivenName $firstName `
            -Surname $lastName `
            -SamAccountName $samAccount `
            -UserPrincipalName $upn `
            -Department $user.Department `
            -Title $user.Role `
            -AccountPassword $password `
            -Enabled $true

        # Kontrolli, kas lisamine õnnestus ($? = viimase käsu väljundstaatus)
        if ($?) {
            Write-Host "New user $samAccount added succesfully"
        } else {
            Write-Host "ERROR: Failed to add user $samAccount"
        }
    }
}