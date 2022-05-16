set(BASE_DIR ${FLUTTER_ENGINE_DIR}/impeller/base)

file(GLOB BASE_SOURCES ${BASE_DIR}/*.cc)
list(FILTER BASE_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")

add_library(impeller_base STATIC ${BASE_SOURCES})

target_include_directories(impeller_base
    PUBLIC
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"
