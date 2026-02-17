$csvContent = @"
Name,Age
John,8
Joe,12
Mary,7
Tom,15
Lily,16
Emily,9
"@

[System.IO.File]::WriteAllText("C:\Users\user\Documents\students.csv", $csvContent, [System.Text.Encoding]::UTF8)

$students = Import-Csv -Path "C:\Users\user\Documents\students.csv"

$result = @()

foreach ($student in $students) {
    $age = [int]$student.Age

    if ($age -ge 4 -and $age -le 10) {
        $school = "Junior"
    }
    elseif ($age -ge 11 -and $age -le 17) {
        $school = "Senior"
    }
    else {
        $school = "Unknown"
    }
    
    $newRow = [PSCustomObject]@{
        Name = $student.Name
        School = $school
    }
    
    $result += $newRow
}

Write-Host "Name    School"
Write-Host "----    ------"
foreach ($row in $result) {
    Write-Host "$($row.Name)    $($row.School)" -ForegroundColor Yellow
}

$result | Export-Csv -Path "C:\Users\aorta\Documents\students_output.csv" -NoTypeInformation