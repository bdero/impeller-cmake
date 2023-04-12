set(IMPELLER_IMAGE_DIR ${FLUTTER_ENGINE_DIR}/impeller/image
    CACHE STRING "Location of the Impeller image sources.")

file(GLOB IMAGE_SOURCES ${IMPELLER_IMAGE_DIR}/decompressed_image.cc)
list(FILTER IMAGE_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")

add_library(impeller_image STATIC ${IMAGE_SOURCES})

target_include_directories(impeller_image
    PUBLIC
        $<BUILD_INTERFACE:${FLUTTER_INCLUDE_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"

target_link_libraries(impeller_image
    PUBLIC
        fml)
