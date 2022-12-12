$alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

function Part1 {
    param ([string]$Filename)

    $score = 0

    foreach ($line in Get-Content $Filename) {
        $middle = $line.Length / 2
        $left = $line.SubString(0, $middle).ToCharArray() | sort
        $right = $line.SubString($middle).ToCharArray() | sort

        $seen = [char[]]@()

        foreach ($c in $left) {
            if ($right.Contains($c)) {
                $seen += $c
            }
        }

        foreach ($char in ($seen | sort -Unique)) {
            $score += $alphabet.IndexOf($char) + 1
        }
    }

    Write-Host $score
}

function Run {
    param (
        [string]$Filename = "input.txt"
    )

    Write-Host "Part 1 test:"
    Part1 .\day3.example.txt
    Write-Host "Part 1:"
    Part1 $Filename
}

if ($args[0]) {
    Run $args[0]
} else {
    Run
}
