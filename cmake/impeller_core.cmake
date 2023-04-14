# Copyright 2013 The Flutter Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set(IMPELLER_CORE_DIR ${FLUTTER_ENGINE_DIR}/impeller/core
    CACHE STRING "Location of the Impeller core sources.")

file(GLOB CORE_SOURCES ${IMPELLER_CORE_DIR}/*.cc)
list(FILTER CORE_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")

add_library(impeller_core STATIC ${CORE_SOURCES})

target_include_directories(impeller_core
    PUBLIC
        $<BUILD_INTERFACE:${FLUTTER_INCLUDE_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"
target_link_libraries(impeller_core PUBLIC fml)
