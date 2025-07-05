#Error handling : Try Catch finally

try {
    Get-Content -path "C:\NonExistingFile.txt" -ErrorAction Stop 
    Write-Output "That file Exists" #this line can't excute because above line is error
}
catch {
    Write-Output("Error:$($_.Exception.Message)") #Error:Cannot find path 'C:\NonExistingFile.txt' because it does not exist.
    Get-Content -Path "C:\Users\PPN\Desktop\code\powershell\test.txt" 
}   
finally {
    Write-Output("File Operations Closed")
}


# "Hello" # Error has occure but stil run next line

