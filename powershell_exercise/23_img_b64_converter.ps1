#img-b64 -img "C:\Users\user\Desktop\image.jpg" -location desk
#b64-img -file "C:\Users\user\Desktop\image.jpg" -location desk
function img-b64 {
[CmdletBinding()]
param (
[Parameter (Mandatory = $True, ValueFromPipeline = $True)]
[string]$img,

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

[Convert]::ToBase64String((Get-Content -Path $img -Encoding Byte)) >> "$loc\encImage.txt"
}