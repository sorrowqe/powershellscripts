# Transliteratsioon
function Transliterate {
    param([string]$text)

    $text = $text -replace 'ä', 'a'
    $text = $text -replace 'Ä', 'A'
    $text = $text -replace 'ö', 'o'
    $text = $text -replace 'Ö', 'O'
    $text = $text -replace 'ü', 'u'
    $text = $text -replace 'Ü', 'U'
    $text = $text -replace 'õ', 'o'
    $text = $text -replace 'Õ', 'O'
    $text = $text -replace 'š', 's'
    $text = $text -replace 'Š', 'S'
    $text = $text -replace 'ž', 'z'
    $text = $text -replace 'Ž', 'Z'

    return $text
}

# Parooligeneraator
function Generate-Password {
    param([int]$length = 12)

    $upper   = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    $lower   = 'abcdefghijklmnopqrstuvwxyz'
    $digits  = '0123456789'
    $special = '!@#$%^&*()-_=+'

    $allChars = ($upper + $lower + $digits + $special).ToCharArray()

    # Taga vähemalt üks märk igast grupist
    $passwordChars = @(
        $upper[(Get-Random -Maximum $upper.Length)]
        $lower[(Get-Random -Maximum $lower.Length)]
        $digits[(Get-Random -Maximum $digits.Length)]
        $special[(Get-Random -Maximum $special.Length)]
    )

    # Täida ülejäänud kohad juhuslike märkidega
    for ($i = $passwordChars.Count; $i -lt $length; $i++) {
        $passwordChars += $allChars[(Get-Random -Maximum $allChars.Length)]
    }

    # Sega märgid juhuslikusse järjekorda
    $shuffled = $passwordChars | Get-Random -Count $passwordChars.Count
    return -join $shuffled
}

# Loe kasutajad CSV-failist
$users = Import-Csv -Path "adkasutajad.csv"

foreach ($user in $users) {
    $firstName  = Transliterate $user.FirstName
    $lastName   = Transliterate $user.LastName

    $samAccount  = ($firstName + "." + $lastName).ToLower()
    $upn         = "$samAccount@sv-kool.local"
    $displayName = "$firstName $lastName"

    # Genereeri unikaalne parool igale kasutajale
    $plainPassword = Generate-Password -length 12
    $password      = ConvertTo-SecureString $plainPassword -AsPlainText -Force

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

        # Kontrolli, kas lisamine õnnestus
        if ($?) {
            Write-Host "New user $samAccount added succesfully"

            # Salvesta kasutajanimi ja parool CSV-faili nimega <kasutajanimi>.csv
            [PSCustomObject]@{
                Username = $samAccount
                Password = $plainPassword
            } | Export-Csv -Path "$samAccount.csv" -NoTypeInformation -Encoding UTF8

            Write-Host "Credentials saved to $samAccount.csv"
        } else {
            Write-Host "ERROR: Failed to add user $samAccount"
        }
    }
}