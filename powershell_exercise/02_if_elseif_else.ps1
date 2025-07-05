#if elsif else - conditional statement
$age = 10
if($age -le 18) {
    Write-Output("You are a minor.")
}elseif ($age -gt 18 -and $age -le 60) {
    Write-Output("You are an adult.")
}else {
    Write-Output("You are an adult")
}