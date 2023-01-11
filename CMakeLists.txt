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

project(LinuxFileSystem)

set(CMAKE_GENERATOR Ninja)

FILE(GLOB_RECURSE SRC Terminal/*.cpp)
FILE(GLOB_RECURSE HEADERS Terminal/*.hpp)

add_executable(FileSys main.cpp ${SRC} ${HEADERS})

message("make prog: ${CMAKE_MAKE_PROGRAM}")
