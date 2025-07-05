#b64-img -file "C:\Users\user\Desktop\image.jpg" -location desk

function b64-img {
[CmdletBinding()]
param (
[Parameter (Mandatory = $True)]
[string]$file,

[Parameter (Mandatory = $False)]
[ValidateSet('desk', 'temp')]
[string]$location
)

if (!$location) {$location = "desk"}

$loc = switch ( $location )
{
	"desk"  { "$Env:USERPROFILE\Desktop"
	}
	"temp" { "$env:TMP" 
	}
}

Add-Type -AssemblyName System.Drawing
$Base64 = Get-Content -Raw -Path $file
$Image = [Drawing.Bitmap]::FromStream([IO.MemoryStream][Convert]::FromBase64String($Base64))
$Image.Save("$loc\decImage.jpg")
}