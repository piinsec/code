@echo off
:start
set /p user_input=Do you like to continue (y/n)? : 
if not defined user_input goto start
if /i %user_input%==y goto Yes
if /i %user_input%==n (goto No) else (goto invalid) 

:Yes
echo User has enter Yes!
goto start

:No
echo User has enter No!
exit

:invalid
echo %user_input% is an invalid entery, try again!
pause
goto start