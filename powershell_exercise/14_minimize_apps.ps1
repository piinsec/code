function Minimize-App {
    $app = New-Object -ComObject Shell.application
    $app.MinimizeAll()
}