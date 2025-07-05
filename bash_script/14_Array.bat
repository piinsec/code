@echo off 
color B 
Title Array 
set A=Pyae Phyo Naung
for %%b in (%A%) do (
    echo ------------------------
    echo %%b
    echo He is the winner...
    echo ------------------------
    timeout /t 5 /nobreak 
)