# Copyright 2013 The Flutter Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set(IMPELLER_TYPOGRAPHER_DIR ${FLUTTER_ENGINE_DIR}/impeller/typographer
    CACHE STRING "Location of the Impeller typographer sources.")

file(GLOB TYPOGRAPHER_SOURCES ${IMPELLER_TYPOGRAPHER_DIR}/*.cc)
list(FILTER TYPOGRAPHER_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")
list(FILTER TYPOGRAPHER_SOURCES EXCLUDE REGEX ".*_playground?\\.cc$")

# We always build the STB library, whether it's used or not.
set(IMPELLER_CMAKE_STB_INCLUDE_DIR $<BUILD_INTERFACE:${THIRD_PARTY_DIR}>/stb)
add_library(stb
    STATIC
        ${IMPELLER_CMAKE_SRC_DIR}/typographer_backends/stb/stb_truetype.cc
        ${IMPELLER_CMAKE_SRC_DIR}/typographer_backends/stb/stb_rect_packer.cc)

target_include_directories(stb
    PUBLIC
        ${IMPELLER_CMAKE_STB_INCLUDE_DIR})

if(${IMPELLER_CMAKE_TYPOGRAPHER_BACKEND_STB})
    # STB based glyph atlas support.
    file(GLOB TYPOGRAPHER_BACKEND_SOURCES
        ${IMPELLER_CMAKE_SRC_DIR}/typographer_backends/stb/text_render_context_stb.cc
        ${IMPELLER_CMAKE_SRC_DIR}/typographer_backends/stb/typeface_stb.cc)
else()
    # Dummy NOOP glyph atlas support.
    file(GLOB TYPOGRAPHER_BACKEND_SOURCES
        ${IMPELLER_CMAKE_SRC_DIR}/typographer_backends/noop/*.cc)
endif()

add_library(impeller_typographer
    STATIC
        ${TYPOGRAPHER_SOURCES}
        ${TYPOGRAPHER_BACKEND_SOURCES})

target_include_directories(impeller_typographer
    PUBLIC
        $<BUILD_INTERFACE:${IMPELLER_CMAKE_SRC_DIR}> # For includes starting with "typographer_backends/"
        $<BUILD_INTERFACE:${FLUTTER_INCLUDE_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}> # For includes starting with "impeller/"
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}>/skia # Skia 
        ${IMPELLER_CMAKE_STB_INCLUDE_DIR}) # stb includes.

target_link_libraries(impeller_typographer
    PUBLIC
        fml
        impeller_base
        impeller_geometry
        impeller_renderer)
