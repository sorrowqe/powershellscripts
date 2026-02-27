while ($true) {
    Clear-Host
    Write-Host "Area Calculator" -ForegroundColor Green
    Write-Host "1: Area of Square"
    Write-Host "2: Area of Rectangle"
    Write-Host "3: Area of Circle"
    Write-Host "4: Area of Triangle"
    Write-Host "5: Exit"
    $choice = Read-Host "Enter your choice"

    if ($choice -eq "5") { break }

    Clear-Host
    $area = $null

    switch ($choice) {
        "1" {
            Write-Host "Area of Square" -ForegroundColor Green
            $s = [double](Read-Host "Enter the side of the square")
            $area = $s * $s
            Write-Host "Area of the square : $area" -ForegroundColor Green
        }
        "2" {
            Write-Host "Area of Rectangle" -ForegroundColor Green
            $l = [double](Read-Host "Enter the length")
            $w = [double](Read-Host "Enter the width")
            $area = $l * $w
            Write-Host "Area of the rectangle : $area" -ForegroundColor Green
        }
        "3" {
            Write-Host "Area of Circle" -ForegroundColor Green
            $r = [double](Read-Host "Enter the radius")
            $area = [math]::Round(([math]::PI * $r * $r), 2)
            Write-Host "Area of the circle : $area" -ForegroundColor Green
        }
        "4" {
            Write-Host "Area of Triangle" -ForegroundColor Green
            $b = [double](Read-Host "Enter the base")
            $h = [double](Read-Host "Enter the height")
            $area = 0.5 * $b * $h
            Write-Host "Area of the triangle : $area" -ForegroundColor Green
        }
        default {
            Write-Host "Enter correct option" -ForegroundColor Red
            Start-Sleep 1
            continue
        }
    }

    # Next option menu (keeps asking until correct)
    while ($true) {
        Write-Host ""
        Write-Host "Please select the next option"
        Write-Host "1: Return to Main Menu"
        Write-Host "2: Exit"
        $next = Read-Host "Enter your choice"

        if ($next -eq "1") { break }          # back to main menu
        elseif ($next -eq "2") { exit }       # exit script
        else { Write-Host "Enter correct option" -ForegroundColor Red }
    }
}