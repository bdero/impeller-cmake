set(BLOBCAT_DIR ${FLUTTER_ENGINE_DIR}/impeller/blobcat)

file(GLOB BLOBCAT_SOURCES ${BLOBCAT_DIR}/*.cc)
list(FILTER BLOBCAT_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")
list(REMOVE_ITEM BLOBCAT_SOURCES "${BLOBCAT_DIR}/blobcat_main.cc")

add_library(impeller_blobcat_lib STATIC ${BLOBCAT_SOURCES})

target_include_directories(impeller_blobcat_lib
    PUBLIC
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"
target_link_libraries(impeller_blobcat_lib PUBLIC fml impeller_base)

add_executable(blobcat "${BLOBCAT_DIR}/blobcat_main.cc")
target_include_directories(blobcat
    PUBLIC
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"
target_link_libraries(blobcat PUBLIC impeller_blobcat_lib)

# blobcat(OUTPUT filename INPUTS filename;filename ...)
function(blobcat)
    cmake_parse_arguments(ARG "" "OUTPUT" "INPUTS" ${ARGN})
    blobcat_parse(CLI OUTPUT ${ARG_OUTPUT} INPUTS ${ARG_INPUTS} ${ARG_UNPARSED_ARGUMENTS})
    get_filename_component(OUTDIR "${ARG_OUTPUT}" ABSOLUTE)
    get_filename_component(OUTDIR "${OUTDIR}" DIRECTORY)
    add_custom_command(OUTPUT ${ARG_OUTPUT}
        COMMAND ${CMAKE_COMMAND} -E make_directory "${OUTDIR}"
        COMMAND "$<TARGET_FILE:blobcat>" ${CLI}
        DEPENDS ${ARG_INPUTS}
        COMMENT "Building blob ${ARG_OUTPUT}"
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")
endfunction()

# blobcat_parse(
#    OUTPUT filename
#    INPUTS filename;filename
# )
function(blobcat_parse CLI_OUT)
    cmake_parse_arguments(ARG "" "OUTPUT" "INPUTS" ${ARGN})
    set(CLI "")

    # --output
    if(ARG_OUTPUT)
        list(APPEND CLI "--output" "${ARG_OUTPUT}")
    endif()

    # --input
    if(ARG_INPUTS)
        foreach(INPUT ${ARG_INPUTS})
            list(APPEND CLI "--input" "${INPUT}")
        endforeach()
    endif()

    set(${CLI_OUT} ${CLI} PARENT_SCOPE)
endfunction()
