function Hide-Msg {
    param (
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$Path,

        [Parameter(Mandatory = $false)]
        [string]$Message
    )

    echo "`n`n $Message" > $Env:USERPROFILE\Desktop\code\powershell\foo.txt

    cmd.exe /c copy /b "$Path" + "$Env:USERPROFILE\Desktop\code\powershell\foo.txt" "$Path"

    rm $Env:USERPROFILE\Desktop\code\powershell\foo.txt -r -Force -ErrorAction SilentlyContinue
}