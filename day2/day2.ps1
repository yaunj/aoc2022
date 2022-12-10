function ParseFile {
    param (
        [string]$Filename
    )

    $strategy = New-Object System.Collections.Generic.List[[String[]]]

    foreach ($line in Get-Content $Filename) {
        # Write-Host $line
        $parts = [string[]]($line.Split(" "))
        $strategy.Add(@($parts[0], $parts[1]))
    }

    return $strategy
}

$scoremap = @{
    "A" = 1;  # Rock
    "B" = 2;  # Paper
    "C" = 3;  # Scissors
    "X" = 1;  # Rock
    "Y" = 2;  # Paper
    "Z" = 3;  # Scissors
}

function Part1 {
    param (
        $strategy
    )

    $total = 0

    foreach ($round in $strategy) {
        $them, $me = $round
        # Write-Host "Round:" $them vs $me
        $me, $them = $scoremap[$me], $scoremap[$them]
        $score = $me

        if ($me -eq $them) {
            $score += 3  # Tie
        } elseif ($me -eq 1 -and $them -eq 3) {
            $score += 6  # Rock beats Scissors
        } elseif ($me -gt $them -and !($me -eq 3 -and $them -eq 1)) {
            $score += 6  # Win
        } else {
            $score += 0  # Loss
        }

        $total += $score
    }

    Write-Host Total: $total
}

function Part2 {
}

function Run {
    param (
        [string]$Filename = "input.txt"
    )

    # Load data
    $test = ParseFile .\day2.example.txt
    $data = ParseFile $Filename

    Write-Host "Part 1 test:"
    Part1 $test
    Write-Host "Part 1:"
    Part1 $data

    # Write-Host "Part 2 test:"
    # Part2 $test
    # Write-Host "Part 2:"
    # Part2 $data
}

if ($args[0]) {
    Run $args[0]
} else {
    Run
}