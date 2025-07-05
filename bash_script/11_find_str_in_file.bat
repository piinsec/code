::@echo off
::Title Search Keyword in file
::set /p input_keyword=Enter the keyword you want to find : 
::set /p folder_path=Enter the folder path :
::cd %folder_path%
::set /p file_type=Enter file type to search(eg.pdf,exe,txt) : 
::findstr /s /i %keyword% *.%file_type%
::pause

@echo off
Title Search Keyword in file

:start
set "input_keyword="
set "folder_path="
set "file_type="

set /p "input_keyword=Enter the keyword you want to find: "
if "%input_keyword%"=="" (
    echo Error: Keyword cannot be empty!
    goto start
)

set /p "folder_path=Enter the folder path: "
if not exist "%folder_path%" (
    echo Error: Folder path does not exist!
    goto start
)

set /p "file_type=Enter file type to search (e.g., pdf, exe, txt): "
if "%file_type%"=="" (
    echo Error: File type cannot be empty!
    goto start
)

echo Searching for "%input_keyword%" in %folder_path%\*.%file_type%...
echo ============================================
findstr /s /i /m /c:"%input_keyword%" "%folder_path%\*.%file_type%"
echo ============================================
echo Search complete.

pause