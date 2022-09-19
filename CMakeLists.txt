cmake_minimum_required(VERSION 3.21)
if(APPLE)
    project(impeller LANGUAGES C CXX OBJC OBJCXX)
else()
    project(impeller LANGUAGES C CXX)
endif()

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

if(NOT SHADERC_DIR)
    set(SHADERC_DIR "${THIRD_PARTY_DIR}/shaderc" CACHE STRING "Location of the shaderc repository.")
elseif(NOT IS_ABSOLUTE "${SHADERC_DIR}")
    get_filename_component(SHADERC_DIR "${SHADERC_DIR}" REALPATH BASE_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
endif()

if(NOT IS_DIRECTORY ${FLUTTER_ENGINE_DIR})
    message(SEND_ERROR
        "Unable to configure any targets because the Flutter Engine directory "
        "(FLUTTER_ENGINE_DIR) couldn't be found: "
        "    ${FLUTTER_ENGINE_DIR}\n"
        "Run `deps.sh` to fetch dependencies.")
    return()
endif()

set(IMPELLER_GENERATED_DIR ${CMAKE_CURRENT_BINARY_DIR}/generated)

if(WIN32)
    add_compile_definitions(
        WIN32_LEAN_AND_MEAN
        NOMINMAX
        UNICODE)
    # Use the static MSVC runtime library everywhere because:
    #   1. the dynamic runtime doesn't work with FML, and
    #   2. the same runtime needs to be used everywhere.
    # Set compile options directly instead of using the `MSVC_RUNTIME_LIBRARY`
    # CMake property because setting said property in the GLOBAL scope doesn't
    # work for some reason.
    add_compile_options(
        $<$<CONFIG:>:/MT>
        $<$<CONFIG:Debug>:/MTd>
        $<$<CONFIG:Release>:/MT>)

    # Ignore MSVC runtime warnings.
    add_definitions(-D_CRT_SECURE_NO_WARNINGS)
elseif(UNIX)
    set(CXX_STANDARD_LIBRARY libc++)
endif()

set(IMPELLER_LIBRARY_TYPE STATIC CACHE STRING "Linking type for library")

set_property(CACHE IMPELLER_LIBRARY_TYPE PROPERTY STRINGS STATIC SHARED)

if(IMPELLER_LIBRARY_TYPE MATCHES "SHARED")
    set(CMAKE_POSITION_INDEPENDENT_CODE ON)
endif()

if(APPLE)
elseif(UNIX)
    set(CMAKE_THREAD_LIBS_INIT "-lpthread")
endif()
add_subdirectory(third_party/abseil-cpp)

option(SPIRV_CROSS_CLI "" OFF)
option(SPIRV_CROSS_ENABLE_TESTS "" OFF)
option(SPIRV_CROSS_ENABLE_GLSL "" ON)
option(SPIRV_CROSS_ENABLE_HLSL "" OFF)
option(SPIRV_CROSS_ENABLE_MSL "" ON)
option(SPIRV_CROSS_ENABLE_CPP "" OFF)
option(SPIRV_CROSS_ENABLE_REFLECT "" ON)
option(SPIRV_CROSS_SKIP_INSTALL "" ON)
add_subdirectory(third_party/spirv_cross)

option(SHADERC_SKIP_INSTALL "" ON)
option(SHADERC_SKIP_TESTS "" ON)
option(SHADERC_SKIP_EXAMPLES "" ON)
option(SHADERC_SKIP_COPYRIGHT_CHECK "" ON)
option(SHADERC_ENABLE_WERROR_COMPILE "" OFF)
add_subdirectory(third_party/shaderc)

include(${CMAKE_CURRENT_SOURCE_DIR}/flatbuffers.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/fml.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/impeller_tools.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/impeller_base.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/impeller_blobcat.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/impeller_geometry.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/impeller_renderer.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/impeller_runtime_stage.cmake)

include(${CMAKE_CURRENT_SOURCE_DIR}/impellerc.cmake)
