# Copyright 2013 The Flutter Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set(IMPELLER_TESSELLATOR_DIR ${FLUTTER_ENGINE_DIR}/impeller/tessellator
    CACHE STRING "Location of the Impeller tessellator sources.")

file(GLOB TESSELLATOR_SOURCES ${IMPELLER_TESSELLATOR_DIR}/*.cc)
list(FILTER TESSELLATOR_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")

add_library(impeller_tessellator STATIC ${TESSELLATOR_SOURCES})

target_include_directories(impeller_tessellator
    PUBLIC
        $<BUILD_INTERFACE:${FLUTTER_INCLUDE_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"

target_link_libraries(impeller_tessellator
    PUBLIC
        fml
        libtess2)
