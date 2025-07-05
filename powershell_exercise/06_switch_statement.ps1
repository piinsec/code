#Switch statement

$input1 = "Green"
switch ($input1) {
    "Red" {Write-Output "Stop"}
    "Yellow" {Write-Output "Caution!"}
    "Green" {Write-Output "Go"}
    Default {Write-Output "Unkwon Color"}
}

