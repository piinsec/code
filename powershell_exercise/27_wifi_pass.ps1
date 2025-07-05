# function Get-CurrentNetwork {

# $pro = netsh wlan show interface | Select-String -Pattern ' SSID '; $pro = [string]$pro; $pos = $pro.IndexOf(':'); $pro = $pro.Substring($pos+2).Trim()

# $pass = netsh wlan show profile $pro key=clear | Select-String -Pattern 'Key Content'; $pass = [string]$pass;$passPOS = $pass.IndexOf(':');$pass = $pass.Substring($passPOS+2).Trim()

# return "$pro	:	$pass"

# } 

# $CurrentNetwork = Get-CurrentNetwork

function Get-CurrentNetwork {
    try {
        # Get current SSID
        $wlanInfo = netsh wlan show interface | Select-String -Pattern ' SSID '
        if (-not $wlanInfo) {
            throw "No WiFi interface found or not connected to any network"
        }
        
        $ssid = ($wlanInfo -split ':')[-1].Trim()
        
        # Get WiFi password
        $profileInfo = netsh wlan show profile name="$ssid" key=clear
        $passwordLine = $profileInfo | Select-String -Pattern 'Key Content'
        
        if ($passwordLine) {
            $password = ($passwordLine -split ':')[-1].Trim()
        } else {
            $password = "No password (Open network)"
        }
        
        [PSCustomObject]@{
            SSID = $ssid
            Password = $password
        }
    }
    catch {
        Write-Warning "Error: $_"
        return $null
    }
}

# Usage
$CurrentNetwork = Get-CurrentNetwork
if ($CurrentNetwork) {
    Write-Host "Connected to: $($CurrentNetwork.SSID)"
    Write-Host "Password: $($CurrentNetwork.Password)"
}