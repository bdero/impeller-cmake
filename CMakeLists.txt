cmake_minimum_required(VERSION 3.17)
project(impeller)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(THIRD_PARTY_DIR "${CMAKE_CURRENT_SOURCE_DIR}/third_party")

if(NOT FLUTTER_ENGINE_DIR)
    set(FLUTTER_ENGINE_DIR "${THIRD_PARTY_DIR}/flutter" CACHE STRING "Location of Flutter Engine.")
elseif(NOT IS_ABSOLUTE "${FLUTTER_ENGINE_DIR}")
    get_filename_component(FLUTTER_ENGINE_DIR "${FLUTTER_ENGINE_DIR}" REALPATH BASE_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
endif()

if(NOT GLES_INCLUDE_DIR)
    set(GLES_INCLUDE_DIR "${THIRD_PARTY_DIR}/angle/include" CACHE STRING "Location of the GLES headers.")
elseif(NOT IS_ABSOLUTE "${GLES_INCLUDE_DIR}")
    get_filename_component(GLES_INCLUDE_DIR "${GLES_INCLUDE_DIR}" REALPATH BASE_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
endif()

if(NOT IS_DIRECTORY ${FLUTTER_ENGINE_DIR})
    message(SEND_ERROR "Unable to configure any targets because the Flutter Engine directory (FLUTTER_ENGINE_DIR) couldn't be found: ${FLUTTER_ENGINE_DIR}")
    return()
endif()

if(WIN32)
    add_compile_definitions(
        WIN32_LEAN_AND_MEAN
        NOMINMAX
        UNICODE)

endif()

if(APPLE AND NOT XCODE)
    set(CMAKE_CXX_FLAGS "-ObjC++")
endif()

set(IMPELLER_LIBRARY_TYPE STATIC CACHE STRING "Linking type for library")

set_property(CACHE IMPELLER_LIBRARY_TYPE PROPERTY STRINGS STATIC SHARED)

if(IMPELLER_LIBRARY_TYPE MATCHES "SHARED")
    set(CMAKE_POSITION_INDEPENDENT_CODE ON)
endif()

add_subdirectory(third_party/abseil-cpp)

include(${CMAKE_CURRENT_SOURCE_DIR}/fml.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/impeller_geometry.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/impeller_renderer.cmake)
