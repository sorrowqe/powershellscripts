# Ask the user for their name using Read-Host
$name = Read-Host -Prompt "What is your name"

# Display the answer in Green color using Write-Host
Write-Host "Hello, $name!" -ForegroundColor Green