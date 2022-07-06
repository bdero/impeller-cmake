set(IMPELLER_COMPILER_DIR ${FLUTTER_ENGINE_DIR}/impeller/compiler
    CACHE STRING "Location of the Impeller compiler sources.")

file(GLOB COMPILER_SOURCES ${IMPELLER_COMPILER_DIR}/*.cc)
list(FILTER COMPILER_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")
list(REMOVE_ITEM COMPILER_SOURCES "${IMPELLER_COMPILER_DIR}/compiler_test.cc")

add_executable(impellerc
    ${COMPILER_SOURCES}
    ${IMPELLER_GENERATED_DIR}/impeller/runtime_stage/runtime_stage_flatbuffers.h)

if(NOT IS_DIRECTORY ${SHADERC_DIR})
    message(SEND_ERROR
      "Unable to configure the impellerc target because the shaderc install "
      "directory (SHADERC_DIR) couldn't be found:"
      "    ${SHADERC_DIR}\n"
      "Run `deps.sh` to fetch dependencies.\n"
      "Alternatively, the shaderc build artifacts can be downloaded here:"
      "    https://github.com/google/shaderc/blob/main/downloads.md")
    return()
endif()

target_link_libraries(impellerc
    PRIVATE
        fml impeller_base impeller_geometry impeller_runtime_stage
        spirv-cross-glsl spirv-cross-msl shaderc)
target_include_directories(impellerc
    PRIVATE
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}> # For includes starting with "impeller/"
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}/inja/include> # For "inja/inja.hpp"
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}/json/include> # For "nlohmann/json.hpp"
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}/shaderc/libshaderc/include> # For "shaderc/shaderc.hpp"
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}/flatbuffers/include> # For includes starting with "flatbuffers/"
        $<BUILD_INTERFACE:${IMPELLER_GENERATED_DIR}>) # For generated flatbuffer schemas

# add_gles_shader_library(
#    NAME library_name
#    SHADERS shader_files
#    OUTPUT_DIR path
# )
function(add_gles_shader_library)
    cmake_parse_arguments(ARG "" "NAME;OUTPUT_DIR" "SHADERS" ${ARGN})

    set(BLOB_FILES "")
    if(APPLE)
        set(SHADER_TYPE OPENGL_DESKTOP)
    else()
        set(SHADER_TYPE OPENGL_ES)
    endif()
    foreach(SHADER ${ARG_SHADERS})
        add_shader(
            ${SHADER_TYPE}
            INPUT ${SHADER}
            OUTPUT_DIR ${ARG_OUTPUT_DIR}
            SL_EXTENSION gles)

        get_filename_component(INPUT_FILENAME ${SHADER} NAME)
        list(APPEND BLOB_FILES ${ARG_OUTPUT_DIR}/${INPUT_FILENAME}.gles)
    endforeach()

    blobcat(
        OUTPUT ${ARG_OUTPUT_DIR}/${ARG_NAME}_gles.blob
        INPUTS ${BLOB_FILES})

    xxd(
        SYMBOL_NAME ${ARG_NAME}_shaders_gles
        OUTPUT_HEADER ${ARG_OUTPUT_DIR}/gles/${ARG_NAME}_shaders_gles.h
        OUTPUT_SOURCE ${ARG_OUTPUT_DIR}/gles/${ARG_NAME}_shaders_gles.c
        SOURCE ${ARG_OUTPUT_DIR}/${ARG_NAME}_gles.blob)
endfunction()

# add_shader(
#    FLUTTER_SPIRV|METAL_DESKTOP|METAL_IOS|OPENGL_DESKTOP|OPENGL_ES
#    INPUT filename
#    OUTPUT_DIR path
#    SL_EXTENSION extension
#    [DEFINES define;define]
#    ...
# )
# See `impellerc_parse` below for the full set of inputs.
function(add_shader)
    cmake_parse_arguments(ARG "" "INPUT;OUTPUT_DIR;SL_EXTENSION" "DEFINES" ${ARGN})
    get_filename_component(INPUT_FILENAME ${ARG_INPUT} NAME)
    if(ARG_SL_EXTENSION STREQUAL "gles")
        list(APPEND ARG_DEFINES "IMPELLER_TARGET_OPENGLES")
    endif()
    impellerc(
        INPUT ${ARG_INPUT}
        SL ${ARG_OUTPUT_DIR}/${INPUT_FILENAME}.${ARG_SL_EXTENSION}
        SPIRV ${ARG_OUTPUT_DIR}/${INPUT_FILENAME}.spirv
        REFLECTION_JSON ${ARG_OUTPUT_DIR}/${INPUT_FILENAME}.json
        REFLECTION_HEADER ${ARG_OUTPUT_DIR}/${INPUT_FILENAME}.h
        REFLECTION_CC ${ARG_OUTPUT_DIR}/${INPUT_FILENAME}.cc
        DEFINES ${ARG_DEFINES}
        ${ARG_UNPARSED_ARGUMENTS})
endfunction()

# impellerc(
#    INPUT glsl_filename
#    SL sl_output_filename
#    SPIRV spirv_output_file
#    [REFLECTION_JSON reflection_json_file]
#    [REFLECTION_HEADER reflection_header_file]
#    [REFLECTION_CC reflection_cc_file]
#    ...
# )
# See `impellerc_parse` below for the full set of inputs.
function(impellerc)
    cmake_parse_arguments(ARG
        "" "INPUT;SL;SPIRV;REFLECTION_JSON;REFLECTION_HEADER;REFLECTION_CC" ""
        ${ARGN})
    impellerc_parse(CLI
        INPUT ${ARG_INPUT}
        SL ${ARG_SL}
        SPIRV ${ARG_SPIRV}
        REFLECTION_JSON ${ARG_REFLECTION_JSON}
        REFLECTION_HEADER ${ARG_REFLECTION_HEADER}
        REFLECTION_CC ${ARG_REFLECTION_CC}
        ${ARG_UNPARSED_ARGUMENTS})

    get_filename_component(SL_DIR "${ARG_SL}" ABSOLUTE)
    get_filename_component(SL_DIR "${SL_DIR}" DIRECTORY)
    get_filename_component(SPIRV_DIR "${ARG_SPIRV}" ABSOLUTE)
    get_filename_component(SPIRV_DIR "${SPIRV_DIR}" DIRECTORY)
    get_filename_component(REFLECTION_JSON_DIR "${ARG_REFLECTION_JSON}" ABSOLUTE)
    get_filename_component(REFLECTION_JSON_DIR "${REFLECTION_JSON_DIR}" DIRECTORY)
    get_filename_component(REFLECTION_HEADER_DIR "${ARG_REFLECTION_HEADER}" ABSOLUTE)
    get_filename_component(REFLECTION_HEADER_DIR "${REFLECTION_HEADER_DIR}" DIRECTORY)
    get_filename_component(REFLECTION_CC_DIR "${ARG_REFLECTION_CC}" ABSOLUTE)
    get_filename_component(REFLECTION_CC_DIR "${REFLECTION_CC_DIR}" DIRECTORY)

    add_custom_command(
        COMMAND ${CMAKE_COMMAND} -E make_directory "${SL_DIR}"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${SPIRV_DIR}"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${REFLECTION_JSON_DIR}"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${REFLECTION_HEADER_DIR}"
        COMMAND ${CMAKE_COMMAND} -E make_directory "${REFLECTION_CC_DIR}"
        COMMAND "$<TARGET_FILE:impellerc>" ${CLI}
        MAIN_DEPENDENCY ${ARG_INPUT}
        OUTPUT ${ARG_SL} ${ARG_SPIRV}
            ${ARG_REFLECTION_JSON} ${ARG_REFLECTION_HEADER} ${ARG_REFLECTION_CC}
        COMMENT "Compiling shader ${ARG_INPUT}"
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")
endfunction()

# impellerc_parse(
#    cli_out
#    INPUT glsl_filename
#    SL sl_output_filename
#    SPIRV spirv_output_file
#    FLUTTER_SPIRV|METAL_DESKTOP|METAL_IOS|OPENGL_DESKTOP|OPENGL_ES
#    [REFLECTION_JSON reflection_json_file]
#    [REFLECTION_HEADER reflection_header_file]
#    [REFLECTION_CC reflection_cc_file]
#    [INCLUDES include;include]
#    [DEFINES define;define]
#    [DEPFILE depfile_path]
# )
function(impellerc_parse CLI_OUT)
    cmake_parse_arguments(ARG
        "FLUTTER_SPIRV;METAL_DESKTOP;METAL_IOS;OPENGL_DESKTOP;OPENGL_ES"
        "INPUT;SL;SPIRV;REFLECTION_JSON;REFLECTION_HEADER;REFLECTION_CC;DEPFILE"
        "INCLUDES;DEFINES" ${ARGN})
    set(CLI "")

    # --input
    if(ARG_INPUT)
        list(APPEND CLI "--input=${ARG_INPUT}")
    endif()

    # --sl
    if(ARG_SL)
        list(APPEND CLI "--sl=${ARG_SL}")
    endif()

    # --spirv
    if(ARG_SPIRV)
        list(APPEND CLI "--spirv=${ARG_SPIRV}")
    endif()

    # --[flutter-spirv|metal-desktop|metal-ios|opengl-desktop|opengl-es]
    set(PLATFORM "")
    set(PLATFORMS "FLUTTER_SPIRV;METAL_DESKTOP;METAL_IOS;OPENGL_DESKTOP;OPENGL_ES")
    foreach(P ${PLATFORMS})
        if(ARG_${P})
            if(PLATFORM)
                message(SEND_ERROR
                    "Calls to `impellerc_parse` can't have more than one platform flag, "
                    "but both ${PLATFORM} and ${P} were supplied.")
                return()
            endif()
            set(PLATFORM "${P}")
        endif()
    endforeach()
    if("${PLATFORM}" STREQUAL "")
        message(SEND_ERROR "Calls to `impellerc_parse` must have one platform flag: ${PLATFORMS}")
        return()
    elseif("${PLATFORM}" STREQUAL "FLUTTER_SPIRV")
        list(APPEND CLI "--flutter-spirv")
    elseif("${PLATFORM}" STREQUAL "METAL_DESKTOP")
        list(APPEND CLI "--metal-desktop")
    elseif("${PLATFORM}" STREQUAL "METAL_IOS")
        list(APPEND CLI "--metal-ios")
    elseif("${PLATFORM}" STREQUAL "OPENGL_DESKTOP")
        list(APPEND CLI "--opengl-desktop")
    elseif("${PLATFORM}" STREQUAL "OPENGL_ES")
        list(APPEND CLI "--opengl-es")
    endif()

    # --reflection-json
    if(ARG_REFLECTION_JSON)
        list(APPEND CLI "--reflection-json=${ARG_REFLECTION_JSON}")
    endif()

    # --reflection-header
    if(ARG_REFLECTION_HEADER)
        list(APPEND CLI "--reflection-header=${ARG_REFLECTION_HEADER}")
    endif()

    # --reflection-cc
    if(ARG_REFLECTION_CC)
        list(APPEND CLI "--reflection-cc=${ARG_REFLECTION_CC}")
    endif()

    # --include
    if(ARG_INCLUDES)
        foreach(INCLUDE ${ARG_INCLUDES})
            list(APPEND CLI "--include=${INCLUDE}")
        endforeach()
    endif()

    # --define
    if(ARG_DEFINES)
        foreach(DEFINE ${ARG_DEFINES})
            list(APPEND CLI "--define=${DEFINE}")
        endforeach()
    endif()

    # --depfile
    if(ARG_DEPFILE)
        list(APPEND CLI "--depfile=${ARG_DEPFILE}")
    endif()

    set(${CLI_OUT} ${CLI} PARENT_SCOPE)
endfunction()
