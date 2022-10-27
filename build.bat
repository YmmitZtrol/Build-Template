:: Arguments are:
:: 				BUILD, DEBUG, RELEASE 	[{Optional} Build Type - Default: DEBUG]
::				run 					[{Optional} Run the program after building]
::				min 					[{Optional} Run the build step but not the config]
:: 				clean					[{Optional} Remove build files, only works as a standalone argument]
:: Note order doesn't matter

@ECHO OFF

set RunFlag=False
set BuildFlag=DEBUG
set MinFlag=False

if [%1]==[clean] (
	rmdir /Q /S build
	del /Q CmakeLists.txt
	del /Q *.cmake
	exit /B 0
)

goto Flag

:Flag
	if [%2]==[run] (
		set RunFlag=True 
		if [%1]==[min] (
			set MinFlag=True
			if NOT [%3]==[] set BuildFlag=%3
		) else set BuildFlag=%1
		goto Build
	)

	if [%2]==[min] (
		set MinFlag=True 
		if [%1]==[run] (
			set RunFlag=True
			if NOT [%3]==[] set BuildFlag=%3
		) else set BuildFlag=%1
		goto Build 
	)

	if [%1]==[run] (
		set RunFlag=True
		if NOT [%2]==[] (
			set BuildFlag=%2
			if NOT [%3]==[] set MinFlag=True
		)
		goto Build 
	)

	if [%1]==[min] (
		set MinFlag=True
		if NOT [%2]==[] (
			set BuildFlag=%2
			if NOT [%3]==[] set RunFlag=True
		)
		goto Build 
	)

:Build
	if %MinFlag%==False (
		ECHO ----------------------------------------------------------------------------------------------------
		ECHO ^|                       ----- Running Premake and creating Cmake Files -----                       ^|
		ECHO ----------------------------------------------------------------------------------------------------
		premake5 cmake

		ECHO ----------------------------------------------------------------------------------------------------
		ECHO ^|                                  ----- Configuring Cmake -----                                   ^|
		ECHO ----------------------------------------------------------------------------------------------------
		cmake -S . -B ./build
	)

	ECHO ----------------------------------------------------------------------------------------------------
	ECHO ^|                                   ----- Building Project -----                                   ^|
	ECHO ----------------------------------------------------------------------------------------------------
	cmake --build ./build --config %BuildFlag%

	if %RunFlag%==True (
		cd build/%BuildFlag%
		ParserCompiler.exe
		cd ../../
	)


