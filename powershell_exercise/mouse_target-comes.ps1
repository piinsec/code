function Target-Comes {
    Add-Type -AssemblyName System.Windows.Forms
    $originalPOS = [System.Windows.Forms.Cursor]::Position.X
    $o=New-Object -ComObject WScript.Shell
        while (1) {
            $pauseTime = 3
            if ([Windows.Forms.Cursor]::Position.X -ne $originalPOS) {
                break
            }
            else {
                $o.SendKeys("{CAPSLOCK}");Start-Sleep -Seconds $pauseTime
            }
        }
}
Target-Comes

Start Notepad
