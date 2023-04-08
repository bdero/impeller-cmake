set(IMPELLER_BLOBCAT_DIR ${FLUTTER_ENGINE_DIR}/impeller/blobcat
    CACHE STRING "Location of the Impeller blobcat sources.")

file(GLOB BLOBCAT_SOURCES ${IMPELLER_BLOBCAT_DIR}/*.cc)
list(FILTER BLOBCAT_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")
list(REMOVE_ITEM BLOBCAT_SOURCES "${IMPELLER_BLOBCAT_DIR}/blobcat_main.cc")

add_library(impeller_blobcat STATIC ${BLOBCAT_SOURCES})

flatbuffers_schema(
    TARGET impeller_blobcat
    INPUT ${IMPELLER_BLOBCAT_DIR}/blob.fbs
    OUTPUT_DIR ${IMPELLER_GENERATED_DIR}/impeller/blobcat)

target_include_directories(impeller_blobcat
    PUBLIC
        $<BUILD_INTERFACE:${FLUTTER_INCLUDE_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}> # For includes starting with "impeller/"
        $<BUILD_INTERFACE:${IMPELLER_GENERATED_DIR}>) # For generated flatbuffer schemas
target_link_libraries(impeller_blobcat PUBLIC fml impeller_base)

add_executable(blobcat "${IMPELLER_BLOBCAT_DIR}/blobcat_main.cc")
target_include_directories(blobcat
    PUBLIC
        $<BUILD_INTERFACE:${FLUTTER_INCLUDE_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"
target_link_libraries(blobcat PUBLIC impeller_blobcat)

# blobcat(OUTPUT filename INPUTS filename;filename)
function(blobcat)
    cmake_parse_arguments(ARG "" "OUTPUT" "INPUTS" ${ARGN})
    blobcat_parse(CLI
        OUTPUT ${ARG_OUTPUT} INPUTS ${ARG_INPUTS} ${ARG_UNPARSED_ARGUMENTS})

    get_filename_component(OUTPUT_DIR "${ARG_OUTPUT}" ABSOLUTE)
    get_filename_component(OUTPUT_DIR "${OUTPUT_DIR}" DIRECTORY)

    add_custom_command(
        COMMAND ${CMAKE_COMMAND} -E make_directory "${OUTPUT_DIR}"
        COMMAND "$<TARGET_FILE:blobcat>" ${CLI}
        DEPENDS ${ARG_INPUTS}
        OUTPUT ${ARG_OUTPUT}
        COMMENT "Building blob ${ARG_OUTPUT}"
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")
endfunction()

# blobcat_parse(
#    cli_out
#    OUTPUT filename
#    INPUTS filename;filename
# )
function(blobcat_parse CLI_OUT)
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
