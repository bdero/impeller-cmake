set(IMPELLER_TOOLS_DIR ${FLUTTER_ENGINE_DIR}/impeller/tools
    CACHE STRING "Location of the Impeller tools.")

find_package(PythonInterp REQUIRED)

# xxd(
#    SYMBOL_NAME name
#    OUTPUT_HEADER filename
#    OUTPUT_SOURCE filename
#    SOURCE filename
# )
function(xxd)
    cmake_parse_arguments(ARG
        "" "OUTPUT_HEADER;OUTPUT_SOURCE;SOURCE" "" ${ARGN})
    xxd_parse(CLI
        OUTPUT_HEADER ${ARG_OUTPUT_HEADER}
        OUTPUT_SOURCE ${ARG_OUTPUT_SOURCE}
        SOURCE ${ARG_SOURCE}
        ${ARG_UNPARSED_ARGUMENTS})

    get_filename_component(OUTPUT_HEADER_DIR "${ARG_OUTPUT_HEADER}" ABSOLUTE)
    get_filename_component(OUTPUT_HEADER_DIR "${OUTPUT_HEADER_DIR}" DIRECTORY)
    get_filename_component(OUTPUT_SOURCE_DIR "${ARG_OUTPUT_SOURCE}" ABSOLUTE)
    get_filename_component(OUTPUT_SOURCE_DIR "${OUTPUT_SOURCE_DIR}" DIRECTORY)

    add_custom_command(
        COMMAND ${CMAKE_COMMAND} -E make_directory "${OUTPUT_HEADER_DIR}"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${OUTPUT_SOURCE_DIR}"
        COMMAND ${PYTHON_EXECUTABLE} ${IMPELLER_TOOLS_DIR}/xxd.py ${CLI}
        MAIN_DEPENDENCY ${ARG_SOURCE}
        OUTPUT ${ARG_OUTPUT_HEADER} ${ARG_OUTPUT_SOURCE}
        COMMENT "Dumping translation unit ${ARG_OUTPUT_SOURCE}"
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")
endfunction()

# xxd_parse(
#    cli_out
#    SYMBOL_NAME name
#    OUTPUT_HEADER filename
#    OUTPUT_SOURCE filename
#    SOURCE filename
# )
function(xxd_parse CLI_OUT)
    cmake_parse_arguments(ARG
        "" "SYMBOL_NAME;OUTPUT_HEADER;OUTPUT_SOURCE;SOURCE" "" ${ARGN})
    set(CLI "")

    # --symbol-name
    if(ARG_SYMBOL_NAME)
        list(APPEND CLI "--symbol-name" "${ARG_SYMBOL_NAME}")
    endif()

    # --output-header
    if(ARG_OUTPUT_HEADER)
        list(APPEND CLI "--output-header" "${ARG_OUTPUT_HEADER}")
    endif()

    # --output-source
    if(ARG_OUTPUT_SOURCE)
        list(APPEND CLI "--output-source" "${ARG_OUTPUT_SOURCE}")
    endif()

    # --source
    if(ARG_SOURCE)
        list(APPEND CLI "--source" "${ARG_SOURCE}")
    endif()

    set(${CLI_OUT} ${CLI} PARENT_SCOPE)
endfunction()
