require "cmake"

workspace "AppName"
    configurations { "Debug", "Release", "Dist" }
    architecture ("x64")

    
project "AppName"
    kind "ConsoleApp"
    language "C++"
	cppdialect "C++20"

	targetdir "../Build/%{cfg.buildcfg}"
	objdir ("../Build/Obj/%{cfg.buildcfg}")

    includedirs {}
    libdirs {}
    links {}

    files { "Source/**.hpp", "Source/**.cpp", "Source/**.h" }

    postbuildcommands { 'robocopy;/MT:16;../Resources;%{cfg.buildcfg}/Resources' }

    filter "configurations:Debug"
       defines { "DEBUG" }
       symbols "On"
 
    filter "configurations:Release"
       defines { "RELEASE" }
       optimize "On"

	filter "configurations:Dist"
       defines { "DIST" }
       optimize "On"
