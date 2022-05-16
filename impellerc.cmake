set(COMPILER_DIR ${FLUTTER_ENGINE_DIR}/impeller/compiler)

file(GLOB COMPILER_SOURCES ${COMPILER_DIR}/*.cc)
list(FILTER COMPILER_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")
list(REMOVE_ITEM COMPILER_SOURCES "${COMPILER_DIR}/compiler_test.cc")

add_executable(impellerc ${COMPILER_SOURCES})

if (WIN32)
    # TODO(bdero): Everything needs to link the same standard library, but this
    #              property does nothing in the GLOBAL scope for some reason.
    #              Figure out a better way to do this.
    set_property(TARGET impellerc PROPERTY
         MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
    set_property(TARGET spirv-cross-core PROPERTY
         MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
    set_property(TARGET spirv-cross-glsl PROPERTY
         MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
    set_property(TARGET spirv-cross-msl PROPERTY
         MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
    set_property(TARGET shaderc PROPERTY
         MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
    set_property(TARGET shaderc_util PROPERTY
         MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
endif()

if(NOT IS_DIRECTORY ${SHADERC_DIR})
    message(SEND_ERROR
      "Unable to configure the impellerc target because the shaderc install "
      "directory (SHADERC_DIR) couldn't be found:"
      "    ${SHADERC_DIR}\n"
      "Run `deps.sh` to fetch dependencies.\n"
      "The shaderc build artifacts can also be downloaded here:"
      "    https://github.com/google/shaderc/blob/main/downloads.md")
    return()
endif()

#target_link_directories(impellerc PRIVATE ${SHADERC_INSTALL_DIR}/lib)
#target_include_directories(impellerc PRIVATE ${SHADERC_INSTALL_DIR}/include)

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
