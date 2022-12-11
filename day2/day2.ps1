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

$shapes = "A", "B", "C"
$scoremap = @{
    "A" = 1;  # Rock
    "B" = 2;  # Paper
    "C" = 3;  # Scissors
    "X" = 1;  # Rock
    "Y" = 2;  # Paper
    "Z" = 3;  # Scissors
}

function score {
    param(
        $they,
        $you
    )

    $you, $they = $scoremap[$you], $scoremap[$they]
    $score = $you

    if ($you -eq $they) {
        $score += 3  # Tie
    } elseif ($you -eq 1 -and $they -eq 3) {
        $score += 6  # Rock beats Scissors
    } elseif ($you -gt $they -and !($you -eq 3 -and $they -eq 1)) {
        $score += 6  # Win
    } else {
        $score += 0  # Loss
    }

    return $score
}

function one-over {
    param($shape)
    return $shapes[($shapes.IndexOf($shape) + 1) % $shapes.Length]
}

function one-below {
    param($shape)
    return $shapes[($shapes.IndexOf($shape) - 1) % $shapes.Length]
}

function Part1 {
    param (
        $strategy
    )

    $total = 0

    foreach ($round in $strategy) {
        $them, $me = $round
        # Write-Host "Round:" $them vs $me
        $total += score $them $me
    }

    Write-Host Total: $total
}

function Part2 {
    param (
        $strategy
    )
    
    $total = 0

    foreach ($round in $strategy) {
        $them, $outcome = $round

        # Write-Host "They have: ${them}"
        if ($outcome -eq "Y") {
            # Draw
            $me = $them
            # Write-Host "Should draw, I pick ${me}"
        } elseif ($outcome -eq "X") {
            # Lose
            $me = one-below $them
            # Write-Host "Should lose, I pick ${me}"
        } elseif ($outcome -eq "Z") {
            # Win
            $me = one-over $them
            # Write-Host "Should win, I pick ${me}"
        } else {
            Write-Host "Unexpected strategy ${outcome}"
        }

        $total += score $them $me
    }

    Write-Host "Total: ${total}"
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