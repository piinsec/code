rem @echo off
rem Rem This is for listing down all the files in the directory Program files
rem pause
rem dir "C:\Users\PPN\Desktop\code\bash_script" > "C:\Users\PPN\Desktop\code\bash_script\list_file.txt"
rem echo "Complete!!"
rem pause

@echo off
REM This script lists all files in the specified directory and saves the list to a text file

echo Listing files in the directory...
dir "E:\0x0\" /A-D /B > "C:\Users\PPN\Desktop\code\bash_script\list.txt"

if %errorlevel% equ 0 (
    echo Operation completed successfully!
) else (
    echo Error occurred while listing files
)

pause