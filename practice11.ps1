[int]$firstnum = Read-Host "Enter first number: "
[int]$secondnum = Read-Host "Enter second number: "

Write-Host "Calculator" -ForegroundColor Green
Write-Host "1: Addition" -ForegroundColor Yellow
Write-Host "2: Substraction" -ForegroundColor Yellow
Write-Host "3: Division" -ForegroundColor Yellow
Write-Host "4: Multiplication" -ForegroundColor Yellow

$choice = Read-Host "Enter your choice: "

switch($choice)
{
    1 {
        $sum = $firstnum + $secondnum
        Write-Host "Sum is: $sum"
    }
    2 {
        $sum = $firstnum - $secondnum
        Write-Host "Difference is $sum"
    }
    3 {
        $sum = $firstnum / $secondnum
        Write-Host "Quotient is $sum"
    }
    4 {
        $sum = $firstnum * $secondnum
        Write-Host "Product sum is $sum"
    }
}