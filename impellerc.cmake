set(COMPILER_DIR ${FLUTTER_ENGINE_DIR}/impeller/compiler)

file(GLOB COMPILER_SOURCES ${COMPILER_DIR}/*.cc)
list(FILTER COMPILER_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")
list(REMOVE_ITEM COMPILER_SOURCES "${COMPILER_DIR}/compiler_test.cc")

add_executable(impellerc ${COMPILER_SOURCES})

target_link_libraries(impellerc
    PRIVATE
        fml impeller_base impeller_geometry spirv-cross shaderc)
target_include_directories(impellerc
    PRIVATE
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}> # For includes starting with "impeller/"
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}/inja/include>
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}/json/include>) # For "nlohmann/json.hpp"
