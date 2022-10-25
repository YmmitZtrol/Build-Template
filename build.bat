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
cmake --build ./build --config %1 

:Default
cmake --build ./build --config DEBUG

:Run
cmake --build ./build --config DEBUG
.\run