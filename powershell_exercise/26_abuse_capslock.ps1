#Caps-Indicator -pause 250 -blinks 3

function Caps-Indicator {

[CmdletBinding()]
param (	
[Parameter (Mandatory = $True, ValueFromPipeline = $True)]
[string]$pause,

[Parameter (Mandatory = $True)]
[int]$blinks
)

$o=New-Object -ComObject WScript.Shell
for($i = 1; $i -le $blinks * 2; $i++) {
    $o.SendKeys("{CAPSLOCK}");Start-Sleep -Milliseconds $pause
    }
}

#capslock-off
# function Caps-Off {
# Add-Type -AssemblyName System.Windows.Forms
# $caps = [System.Windows.Forms.Control]::IsKeyLocked('CapsLock')

# #If true, toggle CapsLock key, to ensure that the script doesn't fail
# if ($caps -eq $true){

# $key = New-Object -ComObject WScript.Shell
# $key.SendKeys('{CapsLock}')
# }
# }