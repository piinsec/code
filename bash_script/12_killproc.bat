@echo off
color B 
Title Kill process
taskkill /f /im notepad.exe
tasklist | findstr notepad.exe || start notepad.exe
pause
