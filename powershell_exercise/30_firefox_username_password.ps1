function Get-FirefoxPasswords {
    $profilePath = (Get-ChildItem "$env:APPDATA\Mozilla\Firefox\Profiles\" -Filter "*.default-release").FullName
    $loginsPath = Join-Path $profilePath "logins.json"

    if (-not (Test-Path $loginsPath)) {
        Write-Warning "Firefox logins file not found!"
        return
    }

    $jsonContent = Get-Content $loginsPath -Raw | ConvertFrom-Json
    $result = @()

    foreach ($login in $jsonContent.logins) {
        $result += [PSCustomObject]@{
            URL = $login.hostname
            Username = $login.username
            Password = $login.password
        }
    }

    return $result
}

Get-FirefoxPasswords | Format-Table -AutoSize