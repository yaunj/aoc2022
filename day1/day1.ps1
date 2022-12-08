function ParseFile {
    param (
        [string]$Filename
    )

    $elves = [int[]](0)

    foreach ($line in Get-Content $Filename) {
        # Write-Host $line
        if ($line -eq "") {
            $elves += 0
        } else {
            $current = [int]($line)
            if ($current -gt 0) {
                $elves[-1] += $current
            } else {
                Write-Warning "Dont know what to do on '${line}'"
            }
        }
    }

    return $elves | Sort-Object -Descending
}

function Part1 {
    param (
        [int[]]$elves
    )
    
    $total = ($elves | Measure-Object -Sum).Sum
    $max = $elves[0]
    Write-Host "$($elves.Length) carrying ${total} calories, max: ${max}"
}

function Part2 {
    param (
        [int[]]$elves
    )
    
    Write-Host $elves[0..2]
    Write-Host ($elves[0..2] | Measure-Object -Sum).Sum
}

function Run {
    param (
        [string]$Filename = "day1.txt"
    )

    # Load data
    $test = ParseFile .\day1.example.txt
    $data = ParseFile $Filename

    Write-Host "Part 1 test:"
    Part1 $test
    Write-Host "Part 1:"
    Part1 $data

    Write-Host "Part 2 test:"
    Part2 $test
    Write-Host "Part 2:"
    Part2 $data
}

if ($args[0]) {
    Run $args[0]
} else {
    Run
}