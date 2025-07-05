# The 4 variations of the syntax:
#B64 -encString "Start notepad"
#B64 -decString
#B64 -encFile -decFile
function B64 {
    param (
        [Parameter(Position=0, ParameterSetName="encFile")]
        [Alias("ef")]
        [string]$encFile,

        [Parameter(Position=0, ParameterSetName="encString")]
        [Alias("es")]
        [string]$encString,

        [Parameter(Position=0, ParameterSetName="decFile")]
        [Alias("df")]
        [string]$decFile,

        [Parameter(Position=0, ParameterSetName="decString")]
        [Alias("ds")]
        [string]$decString
    )
    if ($PSCmdlet.ParameterSetName -eq "encFile") {
        $encoded = [System.Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((Get-Content -Path $encFile -Raw -Encoding UTF8)))
        return $encoded
    }
    elseif ($PSCmdlet.ParameterSetName -eq "encString") {
        $encoded = [System.Convert]::ToBase64String([System.Text.Encoding]::Unicode.Getbytes($encString))
        return $encoded
    }
    elseif ($PSCmdlet.ParameterSetName -eq "decFile") {
        $data = Get-Content $decFile
        $encoded = [system.text.encoding]::ASCII.GetString([System.Convert]::FromBase64String($data))
        return $encoded
    }
    elseif ($PSCmdlet.ParameterSetName -eq "decString") {
        $decoded = [system.text.encoding]::ASCII.GetString([System.Convert]::FromBase64String($decString))
        return $decoded
    }
    
}