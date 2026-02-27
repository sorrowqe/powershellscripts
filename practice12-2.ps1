function countservice {
    param(
        [string]$status
    )

    $count = (Get-Service | Where-Object {$_.Status -eq $status}).Count
    Write-Output "Total services in $status state = $count"
}