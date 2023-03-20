
# NOT COMPLETE -- needs flatbuffers and shader compilation


set(IMPELLER_SCENE_DIR ${FLUTTER_ENGINE_DIR}/impeller/scene
    CACHE STRING "Location of the Impeller scene sources.")

file(GLOB SCENE_SOURCES ${IMPELLER_SCENE_DIR}/*.cc ${IMPELLER_SCENE_DIR}/animation/*.cc)
list(FILTER SCENE_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")

add_library(impeller_scene STATIC ${SCENE_SOURCES})

target_include_directories(impeller_scene
    PUBLIC
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"

target_link_libraries(impeller_scene
    PUBLIC
        fml
        impeller_renderer)
