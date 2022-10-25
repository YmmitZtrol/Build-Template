@ECHO OFF
cls
ECHO ----------------------------------------------------------------------------------------------------
ECHO ^|                                ----- Running Project ------                                      ^|
ECHO ----------------------------------------------------------------------------------------------------
if [%1]==[] goto Default

cd build/%1/
goto Run

:Default
cd build/Debug/
goto Run

:Run
AppName.exe
cd ../../