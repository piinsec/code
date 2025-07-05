## Pipeline : Output of one command as input of another command
#command1 | command2 | command3
"Hello World" | ForEach-Object {$_.ToUpper()} #HELLO WORLD
Get-Process | Where-Object {$_.Name -eq "firefox"} | Select-Object id, Name