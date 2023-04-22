# Copyright 2013 The Flutter Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set(IMPELLER_SCENE_DIR ${FLUTTER_ENGINE_DIR}/impeller/scene
    CACHE STRING "Location of the Impeller scene sources.")

add_gles_shader_library(
    NAME scene
    SHADERS
      ${IMPELLER_SCENE_DIR}/shaders/skinned.vert
      ${IMPELLER_SCENE_DIR}/shaders/unlit.frag
      ${IMPELLER_SCENE_DIR}/shaders/unskinned.vert
    OUTPUT_DIR ${IMPELLER_GENERATED_DIR}/impeller/scene/shaders
)

add_library(scene_shaders_lib STATIC
    "${IMPELLER_GENERATED_DIR}/impeller/scene/shaders/gles/scene_shaders_gles.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/scene/shaders/skinned.vert.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/scene/shaders/unlit.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/scene/shaders/unskinned.vert.cc")

target_include_directories(scene_shaders_lib
    PUBLIC
        $<BUILD_INTERFACE:${FLUTTER_INCLUDE_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"

file(GLOB SCENE_SOURCES ${IMPELLER_SCENE_DIR}/*.cc ${IMPELLER_SCENE_DIR}/animation/*.cc ${IMPELLER_SCENE_DIR}/importer/conversions.cc)
list(FILTER SCENE_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")

add_library(impeller_scene STATIC ${SCENE_SOURCES})

target_include_directories(impeller_scene
    PUBLIC
        ${IMPELLER_GENERATED_DIR}
        $<BUILD_INTERFACE:${FLUTTER_INCLUDE_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"

target_link_libraries(impeller_scene
    PUBLIC
        fml
        scene_shaders_lib
        impeller_renderer)

flatbuffers_schema(
    TARGET impeller_scene
    INPUT ${IMPELLER_SCENE_DIR}/importer/scene.fbs
    OUTPUT_DIR ${IMPELLER_GENERATED_DIR}/impeller/scene/importer
)
