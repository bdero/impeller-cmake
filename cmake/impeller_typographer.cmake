# Copyright 2013 The Flutter Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set(IMPELLER_TYPOGRAPHER_DIR ${FLUTTER_ENGINE_DIR}/impeller/typographer
    CACHE STRING "Location of the Impeller typographer sources.")

file(GLOB TYPOGRAPHER_SOURCES ${IMPELLER_TYPOGRAPHER_DIR}/*.cc)
list(FILTER TYPOGRAPHER_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")
list(FILTER TYPOGRAPHER_SOURCES EXCLUDE REGEX ".*_playground?\\.cc$")

# Build a placeholder "no-op" backend which renders nothing.
# TODO(bdero): Build a lightweight backend powered by stb_truetype or freetype by default.
file(GLOB TYPOGRAPHER_NOOP_BACKEND_SOURCES
    ${IMPELLER_CMAKE_SRC_DIR}/typographer_backends/noop/*.cc)

add_library(impeller_typographer
    STATIC
        ${TYPOGRAPHER_SOURCES}
        ${TYPOGRAPHER_NOOP_BACKEND_SOURCES})

target_include_directories(impeller_typographer
    PUBLIC
        $<BUILD_INTERFACE:${IMPELLER_CMAKE_SRC_DIR}> # For includes starting with "typographer_backends/"
        $<BUILD_INTERFACE:${FLUTTER_INCLUDE_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}> # For includes starting with "impeller/"
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}>/skia) # Skia 

target_link_libraries(impeller_typographer
    PUBLIC
        fml
        impeller_base
        impeller_geometry
        impeller_renderer)
