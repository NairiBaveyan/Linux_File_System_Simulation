cmake_minimum_required(VERSION 3.12)

if(NOT CMAKE_BUILD_TYPE)
	message(WARNING "Build type not set, falling back to Release mode.
		To specify build type use:
		-DCMAKE_BUILD_TYPE=<mode> where <mode> is Debug or Release.")
	set(CMAKE_BUILD_TYPE "Release")
	message("Choose the type of build, options are: Debug Release.")
endif()

set(VERSION_MAJOR 0)
set(VERSION_MINOR 0)

#[[
execute_process(
                COMMAND ${GIT_EXECUTABLE} submodule update --init ${RECURSIVE} ${SUBMODULE}
		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
                RESULT_VARIABLE GIT_SUBMOD_RESULT
                )
	if  (NOT GIT_SUBMOD_RESULT EQUAL "0")
                message(FATAL_ERROR "\"${GIT_EXECUTABLE} submodule update --init ${RECURSIVE} ${SUBMODULE}\" failed with ${GIT_SUBMOD_RESULT}, please checkout submodule manually")
	endif()
]]

project(LinuxFileSystem)

set(CMAKE_GENERATOR Ninja)

FILE(GLOB_RECURSE SRC Terminal/*.cpp)
FILE(GLOB_RECURSE HEADERS Terminal/*.hpp)

add_executable(FileSys main.cpp ${SRC} ${HEADERS})

add_custom_command(TARGET FileSys PRE_BUILD
	COMMAND pwsh.exe cygwin.ps1
	WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/Terminal)

add_custom_command(TARGET FileSys POST_BUILD
	COMMAND pwsh.exe action.ps1
	WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
	COMMENT "Building MSbuild project")

message("make prog: ${CMAKE_MAKE_PROGRAM}")
