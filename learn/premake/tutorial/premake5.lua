local GLFW_HOME = os.getenv("GLFW_HOME")
local CATCH_HOME = os.getenv("CATCH_HOME")
local CATCH_INCLUDE_DIR = CATCH_HOME .. "/single_include/catch2"

-- The name of your workspace will be used, for example, to name the Visual Studio .sln file generated by Premake.
workspace "tutorial"
	-- We set the location of the files Premake will generate
	location "Generated"
	
	-- We indicate that all the projects are C++ only
	language "C++"
	
	-- We will compile for x86_64. You can change this to x86 for 32 bit builds.
	architecture "x86_64"
	
	-- Configurations are often used to store some compiler / linker settings together.
    -- The Debug configuration will be used by us while debugging.
    -- The optimized Release configuration will be used when shipping the app.
	configurations { "Debug", "Release" }
	
	-- We use filters to set options, a new feature of Premake5.
	
	-- We now only set settings for the Debug configuration
	filter { "configurations:Debug" }
		-- We want debug symbols in our debug config
		symbols "On"
	
	-- We now only set settings for Release
	filter { "configurations:Release" }
		-- Release should be optimized
		optimize "On"
	
	-- Reset the filter for other settings
	filter { }
	
	-- Here we use some "tokens" (the things between %{ ... }). They will be replaced by Premake
	-- automatically when configuring the projects.
	-- * %{prj.name} will be replaced by "ExampleLib" / "App" / "UnitTests"
	--  * %{cfg.longname} will be replaced by "Debug" or "Release" depending on the configuration
	-- The path is relative to *this* folder
	targetdir ("Build/Bin/%{prj.name}/%{cfg.longname}")
    objdir ("Build/Obj/%{prj.name}/%{cfg.longname}")
	
    -- This function includes GLFW's header files
function includeGLFW()
	includedirs (GLFW_HOME .. "/include")
end	

-- This function links statically against GLFW
function linkGLFW()
	libdirs (GLFW_HOME .. "/lib-vc2019")
	
	-- Our static lib should not link against GLFW
	filter "kind:not StaticLib"
		links "glfw3"
	filter {}
end

project "ExLib"
	-- kind is used to indicate the type of this project.
	kind "StaticLib"
	
	-- We specify where the source files are.
	-- It would be better to separate header files in a folder and sources
	-- in another, but for our simple project we will put everything in the same place.
	-- Note: ** means recurse in subdirectories, so it will get all the files in ExampleLib/
	files "ExLib/**"
	
	-- We need GLFW, so we include it
	includeGLFW()


function useExLib()
	-- The library's public headers
	includedirs "ExLib"
	
	-- We link against a library that's in the same workspace, so we can just
	-- use the project name - premake is really smart and will handle everything for us.
	links "ExLib"
	
	-- Users of ExampleLib need to link GLFW
	linkGLFW()
end    

-- The windowed app
project "App"
	kind "ConsoleApp"
	files "ExApp/**"

	-- We also need the headers
	includedirs "ExLib"
	
	useExLib()
	
	-- Now we need to add the OpenGL system libraries
	
	filter { "system:windows" }
		links { "OpenGL32" }
		
	filter { "system:not windows" }
		links { "GL" }
		
        
-- We will use this function to include Catch
function includeCatch()
	-- Catch is header-only, we need just the Catch.hpp header
	includedirs( CATCH_INCLUDE_DIR )
	
	-- We can also configure Catch through defines
	defines "CATCH_CPP11_OR_GREATER"
end

project "UnitTests"
	-- Catch prints information to the console
	kind "ConsoleApp"
	
	files "ExTest/**"
	
	includeCatch()
    useExLib()
    
