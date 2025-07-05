#hash table has key and value(can't duplicate keys) 
$settings = @{
    "AppName" = "App1"
    "version" = "1.0.0"
    "maxusers" = 100
}
$settings["appname"] #App1
$settings["version"] = "2.0.0" #change the key value
foreach ($i in $settings.keys)
{
    $i #print whatever you like
}
$settings.ContainsKey("version") #True
$settings.count