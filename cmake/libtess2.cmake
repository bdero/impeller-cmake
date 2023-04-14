# Copyright 2013 The Flutter Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set(LIBTESS2_DIR ${THIRD_PARTY_DIR}/libtess2
    CACHE STRING "Location of the libtess2 sources.")

file(GLOB LIBTESS2_SOURCES ${LIBTESS2_DIR}/Source/*.c)

add_library(libtess2 STATIC ${LIBTESS2_SOURCES})

target_include_directories(libtess2
    PUBLIC
        $<BUILD_INTERFACE:${LIBTESS2_DIR}/Include>
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}>) # For includes starting with "flutter/"
