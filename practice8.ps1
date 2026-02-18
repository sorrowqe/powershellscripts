while(Get-Process -Name notepad -ErrorAction SilentlyContinue) {
    Write-Host "Notepad is running"
    Start-Sleep -Seconds 1
}