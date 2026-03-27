# Transliteratsiooni funktsioon - eesti täpitähed -> ladina tähestik
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

# Küsi kasutaja ees- ja perenimi
$firstName = Read-Host "Please enter user firstname"
$lastName  = Read-Host "Please enter user lastname"

# Transliteeri nimed ja koosta SamAccountName
$firstNameClean = Transliterate $firstName
$lastNameClean  = Transliterate $lastName
$samAccount     = ($firstNameClean + "." + $lastNameClean).ToLower()

# Proovi kasutaja kustutada AD-st
# -ErrorAction Stop tagab, et vead lähevad catch-i
try {
    Remove-ADUser -Identity $samAccount -Confirm:$false -ErrorAction Stop
    Write-Host "User $firstName $lastName is removed succesfully"
}
catch {
    Write-Host "User does not exist or problem is occuring during user removing, please try again"
}