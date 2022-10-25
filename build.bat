:: Arguments are:
:: 				BUILD, DEBUG, RELEASE 	[{Optional} Build Type - Default: DEBUG]
::				run 					[{Optional} to run the programming after building]
:: Note order doesn't matter so "buld release run" and "build run release" both work

@ECHO OFF

ECHO ----------------------------------------------------------------------------------------------------
ECHO ^|                       ----- Running Premake and creating Cmake Files -----                       ^|
ECHO ----------------------------------------------------------------------------------------------------
premake5 cmake

ECHO ----------------------------------------------------------------------------------------------------
ECHO ^|                                  ----- Configuring Cmake -----                                   ^|
ECHO ----------------------------------------------------------------------------------------------------
cmake -S . -B ./build

ECHO ----------------------------------------------------------------------------------------------------
ECHO ^|                                   ----- Building Project -----                                   ^|
ECHO ----------------------------------------------------------------------------------------------------

set RunFlag=None
set BuildFlag=DEBUG

if [%1]==[run] set RunFlag=True

if [%2]==[run] (
	set RunFlag=True 
	set BuildFlag=%1
)

if NOT [%1]==[run] (
	if NOT [%1]==[] (
		set BuildFlag=%1
	)
) 

cmake --build ./build --config %BuildFlag%
if %RunFlag%==True (
	cd build/%BuildFlag%
	ParserCompiler.exe
	cd ../../
)


