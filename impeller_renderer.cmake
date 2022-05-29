set(IMPELLER_RENDERER_DIR ${FLUTTER_ENGINE_DIR}/impeller/renderer
    CACHE STRING "Location of the Impeller renderer sources.")

file(GLOB RENDERER_SOURCES
    ${IMPELLER_RENDERER_DIR}/*.cc
    ${IMPELLER_RENDERER_DIR}/backend/gles/*.cc)
list(FILTER RENDERER_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")

if(IMPELLER_LIBRARY_TYPE STREQUAL STATIC)
    add_library(impeller_renderer STATIC ${RENDERER_SOURCES})
else()
    add_library(impeller_renderer SHARED ${RENDERER_SOURCES})
endif()

if(APPLE)
    find_library(COREVIDEO_LIBRARY CoreVideo)
    find_library(IOKIT_LIBRARY IOKit)
    find_library(COCOA_LIBRARY Cocoa)
    find_library(CARBON_LIBRARY Carbon)
    target_link_libraries(fml
        PUBLIC
            ${COREVIDEO_LIBRARY}
            ${IOKIT_LIBRARY}
            ${COCOA_LIBRARY}
            ${CARBON_LIBRARY})
endif()

# Setup OpenGLES.
if(NOT IS_DIRECTORY ${GLES_INCLUDE_DIR})
message(SEND_ERROR
    "Unable to configure the Impeller GLES backend because the GLES include"
    "directory (GLES_INCLUDE_DIR) couldn't be found: "
    "    ${GLES_INCLUDE_DIR}\n"
    "Run `deps.sh` to fetch dependencies.")
    return()
endif()

find_package(OpenGL REQUIRED)
target_link_libraries(impeller_renderer PUBLIC ${OPENGL_LIBRARIES})
target_include_directories(impeller_renderer
    PUBLIC
        $<BUILD_INTERFACE:${GLES_INCLUDE_DIR}>) # For includes starting with "GLES/"

target_link_libraries(impeller_renderer
    PUBLIC
        fml impeller_base impeller_blobcat impeller_geometry)
target_include_directories(impeller_renderer
    PUBLIC
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"
