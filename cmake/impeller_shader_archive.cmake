# Copyright 2013 The Flutter Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set(IMPELLER_SHADER_ARCHIVE_DIR ${FLUTTER_ENGINE_DIR}/impeller/shader_archive
    CACHE STRING "Location of the Impeller shader_archive sources.")

file(GLOB SHADER_ARCHIVE_SOURCES ${IMPELLER_SHADER_ARCHIVE_DIR}/*.cc)
list(FILTER SHADER_ARCHIVE_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")
list(REMOVE_ITEM SHADER_ARCHIVE_SOURCES "${IMPELLER_SHADER_ARCHIVE_DIR}/shader_archive_main.cc")

add_library(impeller_shader_archive STATIC ${SHADER_ARCHIVE_SOURCES})

flatbuffers_schema(
    TARGET impeller_shader_archive
    INPUT ${IMPELLER_SHADER_ARCHIVE_DIR}/shader_archive.fbs
    OUTPUT_DIR ${IMPELLER_GENERATED_DIR}/impeller/shader_archive)

flatbuffers_schema(
    TARGET impeller_shader_archive
    INPUT ${IMPELLER_SHADER_ARCHIVE_DIR}/multi_arch_shader_archive.fbs
    OUTPUT_DIR ${IMPELLER_GENERATED_DIR}/impeller/shader_archive)

target_include_directories(impeller_shader_archive
    PUBLIC
        $<BUILD_INTERFACE:${FLUTTER_INCLUDE_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}> # For includes starting with "impeller/"
        $<BUILD_INTERFACE:${IMPELLER_GENERATED_DIR}>) # For generated flatbuffer schemas
target_link_libraries(impeller_shader_archive PUBLIC fml impeller_base)

set(IMPELLER_SHADER_ARCHIVE_EXECUTABLE "$<TARGET_FILE:shader_archive>" CACHE STRING "Location of the shader_archive executable to use for building shader archives. If not overridden, shader_archive will be built.")

if(IMPELLER_SHADER_ARCHIVE_EXECUTABLE STREQUAL "$<TARGET_FILE:shader_archive>")
    message(NOTICE "Using the project to build `shader_archive`, but this will not work during cross compilation.")
    add_executable(shader_archive "${IMPELLER_SHADER_ARCHIVE_DIR}/shader_archive_main.cc")
    target_include_directories(shader_archive
        PUBLIC
            $<BUILD_INTERFACE:${FLUTTER_INCLUDE_DIR}> # For includes starting with "flutter/"
            $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"
    target_link_libraries(shader_archive PUBLIC impeller_shader_archive)
    set(IMPELLER_SHADER_ARCHIVE_EXECUTABLE "$<TARGET_FILE:shader_archive>")
endif()

# shader_archive(OUTPUT filename INPUTS filename;filename)
function(shader_archive)
    cmake_parse_arguments(ARG "" "OUTPUT" "INPUTS" ${ARGN})
    shader_archive_parse(CLI
        OUTPUT ${ARG_OUTPUT} INPUTS ${ARG_INPUTS} ${ARG_UNPARSED_ARGUMENTS})

    get_filename_component(OUTPUT_DIR "${ARG_OUTPUT}" ABSOLUTE)
    get_filename_component(OUTPUT_DIR "${OUTPUT_DIR}" DIRECTORY)

    add_custom_command(
        COMMAND ${CMAKE_COMMAND} -E make_directory "${OUTPUT_DIR}"
        COMMAND ${IMPELLER_SHADER_ARCHIVE_EXECUTABLE} ${CLI}
        DEPENDS ${ARG_INPUTS}
        OUTPUT ${ARG_OUTPUT}
        COMMENT "Building blob ${ARG_OUTPUT}"
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")
endfunction()

# shader_archive_parse(
#    cli_out
#    OUTPUT filename
#    INPUTS filename;filename
# )
function(shader_archive_parse CLI_OUT)
    cmake_parse_arguments(ARG "" "OUTPUT" "INPUTS" ${ARGN})
    set(CLI "")

    # --output
    if(ARG_OUTPUT)
        list(APPEND CLI "--output=${ARG_OUTPUT}")
    endif()

    # --input
    if(ARG_INPUTS)
        foreach(INPUT ${ARG_INPUTS})
            list(APPEND CLI "--input=${INPUT}")
        endforeach()
    endif()

    set(${CLI_OUT} ${CLI} PARENT_SCOPE)
endfunction()
