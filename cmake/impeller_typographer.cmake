# Copyright 2013 The Flutter Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set(IMPELLER_TYPOGRAPHER_DIR ${FLUTTER_ENGINE_DIR}/impeller/typographer
    CACHE STRING "Location of the Impeller typographer sources.")

file(GLOB TYPOGRAPHER_SOURCES ${IMPELLER_TYPOGRAPHER_DIR}/*.cc)
list(FILTER TYPOGRAPHER_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")
list(FILTER TYPOGRAPHER_SOURCES EXCLUDE REGEX ".*_playground?\\.cc$")

add_library(stb_truetype
    STATIC
        ${IMPELLER_CMAKE_SRC_DIR}/stb_truetype_impl.cc)

target_include_directories(stb_truetype
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>) # For includes starting with "third_party/stb/"

# Build the STB typographer backend by default.
file(GLOB TYPOGRAPHER_BACKEND_SOURCES
    ${IMPELLER_TYPOGRAPHER_DIR}/backends/stb/glyph_atlas_context_stb.cc
    ${IMPELLER_TYPOGRAPHER_DIR}/backends/stb/text_frame_stb.cc
    ${IMPELLER_TYPOGRAPHER_DIR}/backends/stb/typeface_stb.cc
    ${IMPELLER_TYPOGRAPHER_DIR}/backends/stb/typographer_context_stb.cc)

add_library(impeller_typographer
    STATIC
        ${TYPOGRAPHER_SOURCES}
        ${TYPOGRAPHER_BACKEND_SOURCES})

target_include_directories(impeller_typographer
    PUBLIC
        $<BUILD_INTERFACE:${IMPELLER_CMAKE_SRC_DIR}> # For includes starting with "typographer_backends/"
        $<BUILD_INTERFACE:${FLUTTER_INCLUDE_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}> # For includes starting with "impeller/"
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>) # For includes starting with "third_party/stb/"

target_link_libraries(impeller_typographer
    PUBLIC
        fml
        impeller_base
        impeller_geometry
        impeller_renderer
        stb_truetype)
