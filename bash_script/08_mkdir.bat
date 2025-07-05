@echo off
Title Create New Folder
set /p folder_name=Enter the new folder name : 
set /p folder_path=Enter the folder path : 
set new_path=%folder_path%\%folder_name%
mkdir %new_path%
pause