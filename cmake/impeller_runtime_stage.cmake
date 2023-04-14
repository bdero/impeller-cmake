# Copyright 2013 The Flutter Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set(IMPELLER_RUNTIME_STAGE_DIR ${FLUTTER_ENGINE_DIR}/impeller/runtime_stage
    CACHE STRING "Location of the Impeller runtime stage sources.")

file(GLOB RUNTIME_STAGE_SOURCES
    ${IMPELLER_RUNTIME_STAGE_DIR}/*.cc)
list(FILTER RUNTIME_STAGE_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")
list(REMOVE_ITEM RUNTIME_STAGE_SOURCES "${IMPELLER_RUNTIME_STAGE_DIR}/runtime_stage_playground.cc")

add_library(impeller_runtime_stage STATIC
    ${RUNTIME_STAGE_SOURCES})

flatbuffers_schema(
    TARGET impeller_runtime_stage
    INPUT ${IMPELLER_RUNTIME_STAGE_DIR}/runtime_stage.fbs
    OUTPUT_DIR ${IMPELLER_GENERATED_DIR}/impeller/runtime_stage)

target_link_libraries(impeller_runtime_stage
    PUBLIC
        fml impeller_base)
target_include_directories(impeller_runtime_stage
    PUBLIC
        $<BUILD_INTERFACE:${FLUTTER_INCLUDE_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}> # For includes starting with "impeller/"
        $<BUILD_INTERFACE:${FLATBUFFERS_INCLUDE_DIR}> # For includes starting with "flatbuffers/"
        $<BUILD_INTERFACE:${IMPELLER_GENERATED_DIR}>) # For generated flatbuffer schemas
