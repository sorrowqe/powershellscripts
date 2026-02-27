function countstart {
    $count = (Get-Service | Where-Object {$_.Status -eq 'Running'}).Count
    Write-Output "Total services in running state = $count"
}

function countstop {
    $count = (Get-Service | Where-Object {$_.Status -eq 'Stopped'}).Count
    Write-Output "Total services in stopped state = $count"
}