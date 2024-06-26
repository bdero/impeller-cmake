# Copyright 2013 The Flutter Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set(IMPELLER_ENTITY_DIR ${FLUTTER_ENGINE_DIR}/impeller/entity
    CACHE STRING "Location of the Impeller entity sources.")

# Entity shaders

add_gles_shader_library(
    NAME entity
    SHADERS
    "${IMPELLER_ENTITY_DIR}/shaders/blending/advanced_blend.vert"
    "${IMPELLER_ENTITY_DIR}/shaders/blending/advanced_blend.frag"
    "${IMPELLER_ENTITY_DIR}/shaders/clip.frag"
    "${IMPELLER_ENTITY_DIR}/shaders/clip.vert"
    "${IMPELLER_ENTITY_DIR}/shaders/gradients/conical_gradient_fill.frag"
    "${IMPELLER_ENTITY_DIR}/shaders/glyph_atlas.frag"
    "${IMPELLER_ENTITY_DIR}/shaders/glyph_atlas.vert"
    "${IMPELLER_ENTITY_DIR}/shaders/gradients/gradient_fill.vert"
    "${IMPELLER_ENTITY_DIR}/shaders/gradients/linear_gradient_fill.frag"
    "${IMPELLER_ENTITY_DIR}/shaders/gradients/radial_gradient_fill.frag"
    "${IMPELLER_ENTITY_DIR}/shaders/rrect_blur.vert"
    "${IMPELLER_ENTITY_DIR}/shaders/rrect_blur.frag"
    "${IMPELLER_ENTITY_DIR}/shaders/runtime_effect.vert"
    "${IMPELLER_ENTITY_DIR}/shaders/solid_fill.frag"
    "${IMPELLER_ENTITY_DIR}/shaders/solid_fill.vert"
    "${IMPELLER_ENTITY_DIR}/shaders/gradients/sweep_gradient_fill.frag"
    "${IMPELLER_ENTITY_DIR}/shaders/texture_fill.frag"
    "${IMPELLER_ENTITY_DIR}/shaders/texture_fill.vert"
    "${IMPELLER_ENTITY_DIR}/shaders/texture_uv_fill.vert"
    "${IMPELLER_ENTITY_DIR}/shaders/tiled_texture_fill.frag"
    "${IMPELLER_ENTITY_DIR}/shaders/tiled_texture_fill_external.frag"
    "${IMPELLER_ENTITY_DIR}/shaders/texture_fill_strict_src.frag"
    "${IMPELLER_ENTITY_DIR}/shaders/blending/porter_duff_blend.frag"
    "${IMPELLER_ENTITY_DIR}/shaders/blending/porter_duff_blend.vert"
    "${IMPELLER_ENTITY_DIR}/shaders/filters/border_mask_blur.frag"
    "${IMPELLER_ENTITY_DIR}/shaders/filters/color_matrix_color_filter.frag"
    "${IMPELLER_ENTITY_DIR}/shaders/filters/filter_position.vert"
    "${IMPELLER_ENTITY_DIR}/shaders/filters/filter_position_uv.vert"
    "${IMPELLER_ENTITY_DIR}/shaders/filters/gaussian.frag"
    "${IMPELLER_ENTITY_DIR}/shaders/filters/yuv_to_rgb_filter.frag"
    "${IMPELLER_ENTITY_DIR}/shaders/filters/srgb_to_linear_filter.frag"
    "${IMPELLER_ENTITY_DIR}/shaders/filters/linear_to_srgb_filter.frag"
    "${IMPELLER_ENTITY_DIR}/shaders/filters/morphology_filter.frag"
    "${IMPELLER_ENTITY_DIR}/shaders/blending/vertices_uber.frag"
    "${IMPELLER_ENTITY_DIR}/shaders/gradients/fast_gradient.vert"
    "${IMPELLER_ENTITY_DIR}/shaders/gradients/fast_gradient.frag"
    OUTPUT_DIR ${IMPELLER_GENERATED_DIR}/impeller/entity)

add_library(entity_shaders_lib STATIC
    "${IMPELLER_GENERATED_DIR}/impeller/entity/gles/entity_shaders_gles.cc"

    "${IMPELLER_GENERATED_DIR}/impeller/entity/advanced_blend.vert"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/advanced_blend.frag"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/clip.frag"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/clip.vert"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/conical_gradient_fill.frag"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/glyph_atlas.frag"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/glyph_atlas.vert"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/gradient_fill.vert"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/linear_gradient_fill.frag"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/radial_gradient_fill.frag"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/rrect_blur.vert"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/rrect_blur.frag"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/runtime_effect.vert"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/solid_fill.frag"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/solid_fill.vert"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/sweep_gradient_fill.frag"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/texture_fill.frag"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/texture_fill.vert"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/texture_uv_fill.vert"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/tiled_texture_fill.frag"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/tiled_texture_fill_external.frag"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/texture_fill_strict_src.frag"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/porter_duff_blend.frag"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/porter_duff_blend.vert"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/border_mask_blur.frag"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/color_matrix_color_filter.frag"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/filter_position.vert"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/filter_position_uv.vert"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/gaussian.frag"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/yuv_to_rgb_filter.frag"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/srgb_to_linear_filter.frag"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/linear_to_srgb_filter.frag"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/morphology_filter.frag"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/vertices_uber.frag"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/fast_gradient.vert"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/fast_gradient.frag")

target_include_directories(entity_shaders_lib
    PUBLIC
        $<BUILD_INTERFACE:${FLUTTER_INCLUDE_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"


# "Modern" shaders

add_gles_shader_library(
    NAME modern
    GLES_LANGUAGE_VERSION 460
    SHADERS
        "${IMPELLER_ENTITY_DIR}/shaders/gradients/conical_gradient_ssbo_fill.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/gradients/linear_gradient_ssbo_fill.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/gradients/radial_gradient_ssbo_fill.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/gradients/sweep_gradient_ssbo_fill.frag"
    OUTPUT_DIR ${IMPELLER_GENERATED_DIR}/impeller/entity)

add_library(modern_shaders_lib
    "${IMPELLER_GENERATED_DIR}/impeller/entity/gles/modern_shaders_gles.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/conical_gradient_ssbo_fill.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/linear_gradient_ssbo_fill.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/radial_gradient_ssbo_fill.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/sweep_gradient_ssbo_fill.frag.cc")

target_include_directories(modern_shaders_lib
    PUBLIC
        $<BUILD_INTERFACE:${FLUTTER_INCLUDE_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"

# Framebuffer blend shaders (iOS only, but the headers need to be built regardless of the backend).

add_gles_shader_library(
    NAME framebuffer_blend
    GLES_LANGUAGE_VERSION 460
    SHADERS
        "${IMPELLER_ENTITY_DIR}/shaders/blending/framebuffer_blend.vert"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/framebuffer_blend.frag"
    OUTPUT_DIR ${IMPELLER_GENERATED_DIR}/impeller/entity)

add_library(framebuffer_blend_shaders_lib
    "${IMPELLER_GENERATED_DIR}/impeller/entity/gles/framebuffer_blend_shaders_gles.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/framebuffer_blend.vert.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/framebuffer_blend.frag.cc")

target_include_directories(framebuffer_blend_shaders_lib
    PUBLIC
        $<BUILD_INTERFACE:${FLUTTER_INCLUDE_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"

# Build entity sources

file(GLOB ENTITY_SOURCES
    ${IMPELLER_ENTITY_DIR}/*.cc
    ${IMPELLER_ENTITY_DIR}/contents/*.cc
    ${IMPELLER_ENTITY_DIR}/contents/filters/*.cc
    ${IMPELLER_ENTITY_DIR}/contents/filters/inputs/*.cc
    ${IMPELLER_ENTITY_DIR}/geometry/*.cc)

list(FILTER ENTITY_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")
list(FILTER ENTITY_SOURCES EXCLUDE REGEX ".*_benchmarks?\\.cc$")

# TODO(bdero): Move to separate debug directory.
if(NOT ${CMAKE_BUILD_TYPE} MATCHES Debug)
    list(REMOVE_ITEM ENTITY_SOURCES ${IMPELLER_ENTITY_DIR}/contents/checkerboard_contents.cc)
endif()

# No playground (no gtest)
list(FILTER ENTITY_SOURCES EXCLUDE REGEX ".*_playground\\.cc$")

add_library(impeller_entity STATIC ${ENTITY_SOURCES})

target_include_directories(impeller_entity
    PUBLIC
        ${IMPELLER_GENERATED_DIR}
        $<BUILD_INTERFACE:${FLUTTER_INCLUDE_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"

# TODO(bdero): Replace M_PI with kPi upstream.
# target_compile_definitions(impeller_entity PRIVATE M_PI=kPi)

target_link_libraries(impeller_entity
    PUBLIC
        fml
        entity_shaders_lib
        modern_shaders_lib
        framebuffer_blend_shaders_lib
        impeller_renderer
        impeller_runtime_stage
        impeller_geometry
        impeller_tessellator
        impeller_scene)
