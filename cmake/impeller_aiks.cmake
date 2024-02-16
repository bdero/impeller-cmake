# Copyright 2013 The Flutter Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set(IMPELLER_AIKS_DIR ${FLUTTER_ENGINE_DIR}/impeller/aiks
    CACHE STRING "Location of the Impeller aiks sources.")

file(GLOB AIKS_SOURCES ${IMPELLER_AIKS_DIR}/*.cc)
list(FILTER AIKS_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")
list(FILTER AIKS_SOURCES EXCLUDE REGEX ".*_playground.*\\.cc$")
list(FILTER AIKS_SOURCES EXCLUDE REGEX ".*_benchmarks.*\\.cc$")

add_library(impeller_aiks STATIC ${AIKS_SOURCES})

target_include_directories(impeller_aiks
    PUBLIC
        $<BUILD_INTERFACE:${FLUTTER_INCLUDE_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"

target_link_libraries(impeller_aiks
    PUBLIC
        fml
        impeller_entity
        impeller_typographer)
