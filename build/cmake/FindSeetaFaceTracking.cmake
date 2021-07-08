# find SeetaFaceTracking
#<NAME>_FOUND
#<NAME>_INCLUDE_DIRS or <NAME>_INCLUDES
#<NAME>_LIBRARIES or <NAME>_LIBRARIES or <NAME>_LIBS
#<NAME>_VERSION
#<NAME>_DEFINITIONS

#variables:
#<NAME>_NAME
#<NAME>_INCLUDE_DIR
#<NAME>_LIBRARY
#<NAME>_MODULE_PATH

set(SeetaFaceTracking_NAME "")
set(SeetaFaceTracking_VERSION_MAJOR "")
set(SeetaFaceTracking_VERSION_MINOR "")
set(SeetaFaceTracking_VERSION_SINOR "")
set(SeetaFaceTracking_VERSION "${SeetaFaceTracking_VERSION_MAJOR}.${SeetaFaceTracking_VERSION_MINOR}.${SeetaFaceTracking_VERSION_SINOR}" CACHE STRING "The SeetaFaceTracking library version")
set(NAME_STR ${SeetaFaceTracking_VERSION_MAJOR}${SeetaFaceTracking_VERSION_MINOR}${SeetaFaceTracking_VERSION_SINOR})
set(SeetaFaceTracking_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../")

message(STATUS "SeetaFaceTracking default path: " ${SeetaFaceTracking_MODULE_PATH})
	
if(BUILD_ANDROID)
	# if(SeetaFaceTracking_ROOT_DIR STREQUAL "")
		# message(SEND_ERROR "Set the path to SeetaFaceTracking root folder in the system variable SeetaFaceTracking_ROOT_DIR ")
	# endif()
	set(SeetaFaceTracking_INCLUDE_DIR "${SeetaFaceTracking_MODULE_PATH}/include")
	file(GLOB_RECURSE INCLUDE_FILE
		${SeetaFaceTracking_INCLUDE_DIR}/VIPLFaceRecognizer.h)
	if("${INCLUDE_FILE}" STREQUAL "")
		set(SeetaFaceTracking_INCLUDE_DIR "${SeetaFaceTracking_ROOT_DIR}/include")
	endif()
	message(STATUS "SeetaFaceTracking include dir : ${SeetaFaceTracking_INCLUDE_DIR}")
	file(GLOB LIBRARY_DEBUG
		${SeetaFaceTracking_MODULE_PATH}/${ENV_LIBRARY_DIR}/*${SeetaFaceTracking_NAME}*d.so)
	if("${LIBRARY_DEBUG}" STREQUAL "")
		file(GLOB LIBRARY_DEBUG
		${SeetaFaceTracking_ROOT_DIR}/${ENV_LIBRARY_DIR}/*${SeetaFaceTracking_NAME}*d.so)
	endif()
	file(GLOB LIBRARY_RELEASE
		${SeetaFaceTracking_MODULE_PATH}/${ENV_LIBRARY_DIR}/*${SeetaFaceTracking_NAME}*.so)
	if("${LIBRARY_RELEASE}" STREQUAL "")
		file(GLOB LIBRARY_RELEASE
		${SeetaFaceTracking_ROOT_DIR}/${ENV_LIBRARY_DIR}/*${SeetaFaceTracking_NAME}*.so)
	endif()
else()
	find_path(SeetaFaceTracking_INCLUDE_DIR
	  NAMES
		FaceDetector.h
	  PATHS
		ENV SEETA_LOCAL_INSTALL
		${SeetaFaceTracking_ROOT_DIR}
		${SeetaFaceTracking_MODULE_PATH}
		ENV SeetaFaceTracking_ROOT_DIR
		usr
		usr/local
	  PATH_SUFFIXES
		${ENV_HEADER_DIR}
		${SeetaFaceTracking_NAME}/${ENV_HEADER_DIR})

	find_library(LIBRARY_DEBUG
	  NAMES 
		${SeetaFaceTracking_NAME}${NAME_STR}d
	  PATHS
		ENV SEETA_LOCAL_INSTALL
		${SeetaFaceTracking_ROOT_DIR}
		${SeetaFaceTracking_MODULE_PATH}
		ENV SeetaFaceTracking_ROOT_DIR
		usr
		usr/local
	  PATH_SUFFIXES
		${ENV_LIBRARY_DIR}
		${ENV_LIBRARY_DIR}/${CONFIGURATION}
		${SeetaFaceTracking_NAME}/${ENV_LIBRARY_DIR}
		${SeetaFaceTracking_NAME}/${ENV_LIBRARY_DIR})

	find_library(LIBRARY_RELEASE
	  NAMES 
		${SeetaFaceTracking_NAME}${NAME_STR}
	  PATHS
		ENV SEETA_LOCAL_INSTALL
		${SeetaFaceTracking_ROOT_DIR}
		${SeetaFaceTracking_MODULE_PATH}
		ENV SeetaFaceTracking_ROOT_DIR
		usr
		usr/local
	  PATH_SUFFIXES
		${ENV_LIBRARY_DIR}
		${ENV_LIBRARY_DIR}/${CONFIGURATION}
		${SeetaFaceTracking_NAME}/${ENV_LIBRARY_DIR}
		${SeetaFaceTracking_NAME}/${ENV_LIBRARY_DIR})
endif()

if ("${CONFIGURATION}" STREQUAL "Debug")
	set(SeetaFaceTracking_LIBRARY ${LIBRARY_DEBUG})
else()
	set(SeetaFaceTracking_LIBRARY ${LIBRARY_RELEASE})
endif()

find_package(PackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(SeetaFaceTracking
	FOUND_VAR
		SeetaFaceTracking_FOUND
	REQUIRED_VARS
		SeetaFaceTracking_INCLUDE_DIR
		SeetaFaceTracking_LIBRARY
	VERSION_VAR 
		SeetaFaceTracking_VERSION 
	FAIL_MESSAGE
		"Could not find SeetaFaceTracking!try to set the path to SeetaFaceTracking root folder in the system variable SeetaFaceTracking_ROOT_DIR "
)

if(SeetaFaceTracking_FOUND)
	set(SeetaFaceTracking_LIBRARIES ${SeetaFaceTracking_LIBRARY})
	set(SeetaFaceTracking_INCLUDE_DIRS ${SeetaFaceTracking_INCLUDE_DIR})
endif()

message(STATUS "SeetaFaceTracking Found: " ${SeetaFaceTracking_FOUND})

foreach (inc ${SeetaFaceTracking_INCLUDE_DIRS})
    message(STATUS "SeetaFaceTracking include: " ${inc})
endforeach ()
foreach (lib ${SeetaFaceTracking_LIBRARIES})
    message(STATUS "SeetaFaceTracking library: " ${lib})
endforeach ()
