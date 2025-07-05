function Speak {
    [cmdletBinding()]

    param (
        [Parameter(Position=0, Mandatory = $True)]
        [string]$Sentence
    )

    $s=New-Object -ComObject SAPI.SpVoice
    $s.Rate = -2
    $s.Speak($Sentence)
    
}
$pro = netsh wlan show interface | Select-String -Pattern ' SSID '; $pro = [string]$pro; $pos = $pos.IndexOf(':');$pro =$pro.Substring($pos+2).Trim()
$pass = netsh wlan show profile $pro key=clear | Select-String -Pattern 'Key Content'; $pass = [string]$pass; $passPOS = $pass.IndexOf(':');$pass = $pass.Substring($passPOS+2).Trim()
speak "Hey $env:UserName your wifi password is $pass"