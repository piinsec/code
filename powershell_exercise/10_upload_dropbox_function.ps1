function DropBox-Upload {

[CmdletBinding()]
param (	
[Parameter (Mandatory = $True, ValueFromPipeline = $True)]
[Alias("f")]
[string]$SourceFilePath
) 
$DropBoxAccessToken = "sl.u.AFzwAjF7KthIVqHFMmKwCcocUokuofM_UCQICM7XyopcaonIG7_m_0liHDkOMdsMW_Xw_GQnRYsYkkNXPdmGXyC2WlsnSAb3jRREpp08YwyyUI3vpJIWHOkXfdqTSbVmJm3a2yFbkezGxXqeRF7QkY0WwT-1zE5MwHk90rI7Ykn96GCAuVfqPw_o1R6ge-gKglMcZxeWOl5jRNVpDd14KIujuOcuk0fl8dqEbSZXsH_bL9qujetPFBKYZICykVI1BUEVpYCF0SF3YgZ9L_IJCZ4YjA1c3U1PvtbQ--twnKapfk_8m0-dp_X8H2n1xACH18IQTN7jq_A-Z_frqyHa0izIwJf4WsfIJ97oBhuZJcWddbWDTFDT1hb_MBrZsvaC27W0bIi9SjVrRKClUVapY9juyc6RiDbqSBNOg1h2iFRX3QdK_Fzs2iu3LWo7GDG-cbFRPwqqirn4ajOROvmtxb4UHr0_Hfvq93FyY-_ICIIvKhE_MAtADd9MkG6O2QGmQ7rfql8kVwZubkNvx4BNwlC0t_tAdUbzvjVpjfKwc7jqb3PvVLgaQZ3FGiT8-9SU5dO0FcXqQwQx-y7vUjPDsIXTAkTSbh9NWvjCCEiGK7hjfIhTgqvnvQYeFBuJz8M355TibrMQMFr8hXnIcE0Btj_wQHyOvKn6Dj2KDKODg8cN1VpHrQRr6w-Rh4HVQRU2HYAMYktaaSvMRTkn91wRcyp0RfT41BARKnYVvzqGyNxUoFexsfJno4FP4UuGUGb8h3Yr7QsZq1rvkhVaYQz8X55HrR8CT-od0-IH9hTUcO5qXhA-KHqyaiubH-0t84OwMYRNPYvve6br-7gsYgEBZ13RYnGcQSL08HvXrA7MDMbBUJTX0AUoewL3tvplPqY7z8zIt8OC2ECG0i0z5eq4bIgVQZKxOpOmWAshMfP-j4IpBvIbeVcu7xOEzwBMCP4RuabyKFJ47AGw7wF286QPnFD9I9BEyF3DZSdHYCbXQdMdBgjRldciWrsmn4OOd7f_ygeoac20EvWD7uDL65VwFHWmiRH7cn2lRWM3nssqJ-amonTgVf14AK2-PlK9GlUMSWHW-qqzEURtu_1-7GcS7xqcXUMeVdvvL-smAptN3L008q2Y7r_ilfeZa3HP1FLJVBJyZeX6oC6lGhFxkhSTkTpMcREaYc007jdvJW3jDWnTmlqZ6qxKHe35szqx8J4uObVd5jOLAQ7LTWbOItEV38KSVWal6pQNLx06JVIlT591WFI5OFf0tKxM2MzoZBXLVQI"   # Replace with your DropBox Access Token
$outputFile = Split-Path $SourceFilePath -leaf
$TargetFilePath="/$outputFile"
$arg = '{ "path": "' + $TargetFilePath + '", "mode": "add", "autorename": true, "mute": false }'
$authorization = "Bearer " + $DropBoxAccessToken
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", $authorization)
$headers.Add("Dropbox-API-Arg", $arg)
$headers.Add("Content-Type", 'application/octet-stream')
Invoke-RestMethod -Uri https://content.dropboxapi.com/2/files/upload -Method Post -InFile $SourceFilePath -Headers $headers
}