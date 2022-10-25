:: Arguments are:
:: 				BUILD, DEBUG, RELEASE 	[Build Type - Default: DEBUG]
::				run 					[Optional to run the programming after building]
:: Example: build Release run
:: Example: build run (build in DEBUG mode)

@ECHO OFF
ECHO ----------------------------------------------------------------------------------------------------
ECHO ^|                       ----- Running Premake and creating Cmake Files -----                       ^|
ECHO ----------------------------------------------------------------------------------------------------
premake5 cmake
ECHO ----------------------------------------------------------------------------------------------------
ECHO ^|                                   ----- Building Project -----                                   ^|
ECHO ----------------------------------------------------------------------------------------------------
cmake -S . -B ./build
if [%1]==[] goto Default
if [%1]=="run" goto Run
if [%2]=="run" goto SpecificRun

cmake --build ./build --config %1 

:Default
cmake --build ./build --config DEBUG

:Run
cmake --build ./build --config DEBUG
.\run

:SpecificRun
cmake --build ./build --config %1
.\run %1
