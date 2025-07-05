@echo off
:start
cls
Title User Input
set /p input=Enter the Name : 
echo %input% , We are delighted to have you at the event!
pause
goto start