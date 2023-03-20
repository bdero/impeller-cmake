set(IMPELLER_TYPOGRAPHER_DIR ${FLUTTER_ENGINE_DIR}/impeller/typographer
    CACHE STRING "Location of the Impeller typographer sources.")

file(GLOB TYPOGRAPHER_SOURCES ${IMPELLER_TYPOGRAPHER_DIR}/*.cc ${IMPELLER_TYPOGRAPHER_DIR}/backends/skia/*.cc)
list(FILTER TYPOGRAPHER_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")
list(FILTER TYPOGRAPHER_SOURCES EXCLUDE REGEX ".*_playground?\\.cc$")

add_library(impeller_typographer STATIC ${TYPOGRAPHER_SOURCES})

target_include_directories(impeller_typographer
    PUBLIC
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}> # For includes starting with "impeller/"
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}>/skia) # Skia 

# Take the static Skia, bc we need Rectanizer which isn't exported in the DSO.
find_library(FOUND_LIB_SKIA_A NAMES libskia.a PATHS ${THIRD_PARTY_DIR}/skia/out/Static/ NO_DEFAULT_PATH)

target_link_libraries(impeller_typographer
    PUBLIC
        fml
        impeller_base
        impeller_geometry
        impeller_renderer
        ${FOUND_LIB_SKIA_A}
        freetype fontconfig z)
