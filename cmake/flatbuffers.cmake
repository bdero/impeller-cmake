# Copyright 2013 The Flutter Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

option(FLATBUFFERS_BUILD_TESTS "" OFF)
add_subdirectory(third_party/flatbuffers)

set(FLATBUFFERS_INCLUDE_DIR ${THIRD_PARTY_DIR}/flatbuffers/include)

# flatbuffers_schema(
#    TARGET dependent
#    INPUT filename
#    OUTPUT_DIR path
# )
function(flatbuffers_schema)
    cmake_parse_arguments(ARG "" "TARGET;INPUT;OUTPUT_DIR" "" ${ARGN})

    get_filename_component(INPUT_FILENAME ${ARG_INPUT} NAME_WE)

    set(OUTPUT_HEADER "${ARG_OUTPUT_DIR}/${INPUT_FILENAME}_flatbuffers.h")
    add_custom_command(
        COMMAND ${CMAKE_COMMAND} -E make_directory "${ARG_OUTPUT_DIR}"
        COMMAND "$<TARGET_FILE:flatc>"
            --warnings-as-errors
            --cpp
            --cpp-std c++17
            --cpp-static-reflection
            --gen-object-api
            --filename-suffix _flatbuffers
            -o "${ARG_OUTPUT_DIR}"
            "${ARG_INPUT}"
        MAIN_DEPENDENCY ${ARG_INPUT}
        OUTPUT "${OUTPUT_HEADER}"
        COMMENT "Generating flatbuffer schema ${ARG_INPUT}"
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")

    target_sources(${ARG_TARGET} PUBLIC "${OUTPUT_HEADER}")
    target_include_directories(${ARG_TARGET}
        PUBLIC
            $<BUILD_INTERFACE:${FLATBUFFERS_INCLUDE_DIR}>) # For includes starting with "flatbuffers/"
endfunction()
