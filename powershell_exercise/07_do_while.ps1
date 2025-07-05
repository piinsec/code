#do-while : loop that excutes a block of code atleast once
#then, continue executing the block until condition is true

$count = 0

do {
    Write-output $count
    $count++
} while (
    $count -le 5
)