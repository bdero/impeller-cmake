set(IMPELLER_GEOMETRY_DIR ${FLUTTER_ENGINE_DIR}/impeller/geometry
    CACHE STRING "Location of the Impeller geometry sources.")

file(GLOB GEOMETRY_SOURCES ${IMPELLER_GEOMETRY_DIR}/*.cc)
list(FILTER GEOMETRY_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")
list(FILTER GEOMETRY_SOURCES EXCLUDE REGEX ".*_benchmarks?\\.cc$")

add_library(impeller_geometry STATIC ${GEOMETRY_SOURCES})

target_include_directories(impeller_geometry
    PUBLIC
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"

# TODO(bdero): Replace M_PI with kPi upstream.
target_compile_definitions(impeller_geometry PRIVATE M_PI=kPi)

target_link_libraries(impeller_geometry
    PUBLIC
        fml)
