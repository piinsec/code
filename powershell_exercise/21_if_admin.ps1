function If-Admin {
	$user = "$env:COMPUTERNAME\$env:USERNAME"
	$isAdmin = (Get-LocalGroupMember 'Administrators').Name -contains $user
if($isAdmin){
	Write-host 'Is Admin' -BackgroundColor DarkRed -ForegroundColor White
	}
	else{
	Write-host 'Not Admin' -BackgroundColor DarkBlue -ForegroundColor White
	}
}