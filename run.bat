:: Arguments are:
:: 					BUILD, DEBUG, RELEASE 	[{Optional} Build Type - Default: DEBUG]

@ECHO OFF
cls
ECHO ----------------------------------------------------------------------------------------------------
ECHO ^|                                ----- Running Project ------                                      ^|
ECHO ----------------------------------------------------------------------------------------------------
if [%1]==[] goto Default
goto Normal

:Normal
cd build/%1/
goto Run

:Default
cd build/Debug/
goto Run

:Run
ParserCompiler.exe
cd ../../