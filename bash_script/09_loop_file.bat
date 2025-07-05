@echo off
Title Loop Through file
:scan_file
set /p folder_path=Enter the folder path : 
cd %folder_path%
for %%i in (*.*) do echo %%i
pause 