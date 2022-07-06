option(FLATBUFFERS_BUILD_TESTS "" OFF)
add_subdirectory(third_party/flatbuffers)

# flatbuffers_schema(
#    INPUT filename
#    OUTPUT_DIR path
# )
function(flatbuffers_schema)
    cmake_parse_arguments(ARG "" "INPUT;OUTPUT_DIR" "" ${ARGN})

    get_filename_component(INPUT_FILENAME ${ARG_INPUT} NAME_WE)

    message(STATUS "ARG_OUTPUT_DIR ${ARG_OUTPUT_DIR}")

    set(OUTPUT_HEADER "${ARG_OUTPUT_DIR}/${INPUT_FILENAME}_flatbuffers.h")
    message(STATUS "OUTPUT_HEADER ${OUTPUT_HEADER}")
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
endfunction()
