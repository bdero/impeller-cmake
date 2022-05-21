set(COMPILER_DIR ${FLUTTER_ENGINE_DIR}/impeller/compiler)

file(GLOB COMPILER_SOURCES ${COMPILER_DIR}/*.cc)
list(FILTER COMPILER_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")
list(REMOVE_ITEM COMPILER_SOURCES "${COMPILER_DIR}/compiler_test.cc")

add_executable(impellerc ${COMPILER_SOURCES})

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
        fml impeller_base impeller_geometry spirv-cross-glsl spirv-cross-msl shaderc)
target_include_directories(impellerc
    PRIVATE
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}> # For includes starting with "impeller/"
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}/inja/include> # For "inja/inja.hpp"
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}/json/include> # For "nlohmann/json.hpp"
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}/shaderc/libshaderc/include>) # For "shaderc/shaderc.hpp"

# impellerc(
#    INPUT glsl_filename
#    SL sl_output_filename
#    [REFLECTION_JSON reflection_json_file]
#    [REFLECTION_HEADER reflection_header_file]
#    [REFLECTION_CC reflection_cc_file]
#    ...
# )
# See `impellerc_parse` below for the full set of inputs.
function(impellerc)
    cmake_parse_arguments(ARG
        "" "INPUT;SL;REFLECTION_JSON;REFLECTION_HEADER;REFLECTION_CC" ""
        ${ARGN})
    shaderc_parse(CLI INPUT ${ARG_INPUT} SL ${ARG_SL} ${ARG_UNPARSED_ARGUMENTS})
    get_filename_component(OUTDIR "${ARG_SL}" ABSOLUTE)
    get_filename_component(OUTDIR "${OUTDIR}" DIRECTORY)
    add_custom_command(OUTPUT ${ARG_SL}
        COMMAND ${CMAKE_COMMAND} -E make_directory "${OUTDIR}"
        COMMAND "$<TARGET_FILE:impellerc>" ${CLI}
        MAIN_DEPENDENCY ${ARG_INPUT}
        BYPRODUCTS ${ARG_SL}
            ${ARG_REFLECTION_JSON} ${ARG_REFLECTION_HEADER} ${ARG_REFLECTION_CC}
        COMMENT "Compiling shader ${ARG_INPUT}"
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")
endfunction()

# impellerc_parse(
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
        list(APPEND CLI "--input" "${ARG_INPUT}")
    endif()

    # --sl
    if(ARG_SL)
        list(APPEND CLI "--sl" "${ARG_SL}")
    endif()

    # --spirv
    if(ARG_SPIRV)
        list(APPEND CLI "--spirv" "${ARG_SPIRV}")
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
        list(APPEND CLI "--reflection-json" "${ARG_REFLECTION_JSON}")
    endif()

    # --reflection-header
    if(ARG_REFLECTION_HEADER)
        list(APPEND CLI "--reflection-header" "${ARG_REFLECTION_HEADER}")
    endif()

    # --reflection-cc
    if(ARG_REFLECTION_CC)
        list(APPEND CLI "--reflection-cc" "${ARG_REFLECTION_CC}")
    endif()

    # --include
    if(ARG_INCLUDES)
        foreach(INCLUDE ${ARG_INCLUDES})
            list(APPEND CLI "--include" "${INCLUDE}")
        endforeach()
    endif()

    # --define
    if(ARG_DEFINES)
        foreach(DEFINE ${ARG_DEFINES})
            list(APPEND CLI "--define" "${DEFINE}")
        endforeach()
    endif()

    # --depfile
    if(ARG_DEPFILE)
        list(APPEND CLI "--depfile" "${ARG_DEPFILE}")
    endif()

    set(${CLI_OUT} ${CLI} PARENT_SCOPE)
endfunction()
