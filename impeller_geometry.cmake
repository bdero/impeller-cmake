set(GEOMETRY_DIR ${FLUTTER_ENGINE_DIR}/impeller/geometry)

file(GLOB GEOMETRY_SOURCES ${GEOMETRY_DIR}/*.cc)
list(FILTER GEOMETRY_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")

add_library(impeller_geometry STATIC ${GEOMETRY_SOURCES})

if (WIN32)
    set_property(TARGET impeller_geometry PROPERTY
         MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
endif()

target_include_directories(impeller_geometry
    PUBLIC
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"

# TODO(bdero): Replace M_PI with kPi upstream.
target_compile_definitions(impeller_geometry PRIVATE M_PI=kPi)
