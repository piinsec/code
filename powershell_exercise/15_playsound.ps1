function PlaySound {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $True, Position=0, ValueFromPipeline = $True)]
        [string]$File 
    )
    $PlaySound=New-Object System.Media.SoundPlayer; $PlaySound.SoundLocation=$File;$PlaySound.PlaySync()
}

PlaySound "C:\Users\PiiN\Desktop\anao.wav"