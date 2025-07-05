# For a network profile using a Password use:

# Add-NetWork -SSID wifi-name -PW wifi-password

# For a network profile NOT using a Password use:

# Add-NetWork -SSID wifi-name 

function Add-NetWork {

[CmdletBinding()]
param (	
[Parameter (Mandatory = $True)]
[string]$SSID,

[Parameter (Mandatory = $False)]
[Alias("s")]
[string]$Security,

[Parameter (Mandatory = $False)]
[string]$PW

)

if (!$PW) {$Security = "f"}
if ($PW) {$Security = "t"}

# -------------------------------------------------------------------------------------------------

$sec = switch ( $Security )
{
    "t"  { 
"
        <security>
            <authEncryption>
                <authentication>WPA2PSK</authentication>
                <encryption>AES</encryption>
                <useOneX>false</useOneX>
            </authEncryption>
            <sharedKey>
                <keyType>passPhrase</keyType>
                <protected>false</protected>
                <keyMaterial>$PW</keyMaterial>
            </sharedKey>
        </security>
"
}
    "f" { 

"
        <security>
            <authEncryption>
                <authentication>open</authentication>
                <encryption>none</encryption>
                <useOneX>false</useOneX>
            </authEncryption>
        </security>
" 

}
}

# -------------------------------------------------------------------------------------------------

$profilefile="ACprofile.xml"
$SSIDHEX=($SSID.ToCharArray() |foreach-object {'{0:X}' -f ([int]$_)}) -join''
$xmlfile="<?xml version=""1.0""?>
<WLANProfile xmlns=""http://www.microsoft.com/networking/WLAN/profile/v1"">
    <name>$SSID</name>
    <SSIDConfig>
        <SSID>
            <hex>$SSIDHEX</hex>
            <name>$SSID</name>
        </SSID>
    </SSIDConfig>
    <connectionType>ESS</connectionType>
    <connectionMode>auto</connectionMode>
    <MSM>
$sec
    </MSM>
</WLANProfile>
"

$XMLFILE > ($profilefile)
netsh wlan add profile filename="$($profilefile)"
}