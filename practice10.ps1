$count = 0

do {
    Write-Host "Notepad is running"
    $count++
    Start-Sleep -Seconds 1
} until (-not (Get-Process -Name notepad -ErrorAction SilentlyContinue))

Write-Host $count