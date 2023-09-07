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
        "${IMPELLER_ENTITY_DIR}/shaders/blending/advanced_blend_color.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/advanced_blend_colorburn.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/advanced_blend_colordodge.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/advanced_blend_darken.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/advanced_blend_difference.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/advanced_blend_exclusion.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/advanced_blend_hardlight.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/advanced_blend_hue.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/advanced_blend_lighten.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/advanced_blend_luminosity.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/advanced_blend_multiply.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/advanced_blend_overlay.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/advanced_blend_saturation.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/advanced_blend_screen.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/advanced_blend_softlight.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/blend.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/blend.vert"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/porter_duff_blend.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/porter_duff_blend.vert"
        "${IMPELLER_ENTITY_DIR}/shaders/border_mask_blur.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/border_mask_blur.vert"
        "${IMPELLER_ENTITY_DIR}/shaders/debug/checkerboard.frag",
        "${IMPELLER_ENTITY_DIR}/shaders/debug/checkerboard.vert",
        "${IMPELLER_ENTITY_DIR}/shaders/clip.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/clip.vert"
        "${IMPELLER_ENTITY_DIR}/shaders/color_matrix_color_filter.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/color_matrix_color_filter.vert"
        "${IMPELLER_ENTITY_DIR}/shaders/conical_gradient_fill.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/gaussian_blur/gaussian_blur.vert"
        "${IMPELLER_ENTITY_DIR}/shaders/gaussian_blur/gaussian_blur_noalpha_decal.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/gaussian_blur/gaussian_blur_noalpha_nodecal.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/glyph_atlas.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/glyph_atlas_color.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/glyph_atlas.vert"
        "${IMPELLER_ENTITY_DIR}/shaders/gradient_fill.vert"
        "${IMPELLER_ENTITY_DIR}/shaders/linear_to_srgb_filter.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/linear_to_srgb_filter.vert"
        "${IMPELLER_ENTITY_DIR}/shaders/linear_gradient_fill.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/morphology_filter.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/morphology_filter.vert"
        "${IMPELLER_ENTITY_DIR}/shaders/position_color.vert"
        "${IMPELLER_ENTITY_DIR}/shaders/radial_gradient_fill.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/rrect_blur.vert"
        "${IMPELLER_ENTITY_DIR}/shaders/rrect_blur.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/runtime_effect.vert"
        "${IMPELLER_ENTITY_DIR}/shaders/solid_fill.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/solid_fill.vert"
        "${IMPELLER_ENTITY_DIR}/shaders/srgb_to_linear_filter.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/srgb_to_linear_filter.vert"
        "${IMPELLER_ENTITY_DIR}/shaders/sweep_gradient_fill.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/texture_fill.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/texture_fill.vert"
        "${IMPELLER_ENTITY_DIR}/shaders/texture_fill_external.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/tiled_texture_fill.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/vertices.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/yuv_to_rgb_filter.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/yuv_to_rgb_filter.vert"
    OUTPUT_DIR ${IMPELLER_GENERATED_DIR}/impeller/entity)

add_library(entity_shaders_lib STATIC
    "${IMPELLER_GENERATED_DIR}/impeller/entity/advanced_blend.vert.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/advanced_blend_color.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/advanced_blend_colorburn.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/advanced_blend_colordodge.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/advanced_blend_darken.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/advanced_blend_difference.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/advanced_blend_exclusion.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/advanced_blend_hardlight.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/advanced_blend_hue.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/advanced_blend_lighten.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/advanced_blend_luminosity.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/advanced_blend_multiply.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/advanced_blend_overlay.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/advanced_blend_saturation.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/advanced_blend_screen.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/advanced_blend_softlight.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/blend.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/blend.vert.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/porter_duff_blend.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/porter_duff_blend.vert.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/border_mask_blur.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/border_mask_blur.vert.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/checkerboard.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/checkerboard.vert.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/clip.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/clip.vert.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/color_matrix_color_filter.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/color_matrix_color_filter.vert.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/conical_gradient_fill.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/gaussian_blur.vert.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/gaussian_blur_noalpha_decal.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/gaussian_blur_noalpha_nodecal.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/glyph_atlas.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/glyph_atlas_color.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/glyph_atlas.vert.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/gradient_fill.vert.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/linear_to_srgb_filter.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/linear_to_srgb_filter.vert.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/linear_gradient_fill.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/morphology_filter.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/morphology_filter.vert.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/position_color.vert.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/radial_gradient_fill.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/rrect_blur.vert.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/rrect_blur.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/runtime_effect.vert.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/solid_fill.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/solid_fill.vert.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/srgb_to_linear_filter.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/srgb_to_linear_filter.vert.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/sweep_gradient_fill.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/texture_fill.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/texture_fill.vert.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/texture_fill_external.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/tiled_texture_fill.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/vertices.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/yuv_to_rgb_filter.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/yuv_to_rgb_filter.vert.cc")

target_include_directories(entity_shaders_lib
    PUBLIC
        $<BUILD_INTERFACE:${FLUTTER_INCLUDE_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"


# "Modern" shaders

add_gles_shader_library(
    NAME modern
    GLES_LANGUAGE_VERSION 460
    SHADERS
        "${IMPELLER_ENTITY_DIR}/shaders/conical_gradient_ssbo_fill.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/linear_gradient_ssbo_fill.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/radial_gradient_ssbo_fill.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/sweep_gradient_ssbo_fill.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/geometry/points.comp"
        "${IMPELLER_ENTITY_DIR}/shaders/geometry/uv.comp"
    OUTPUT_DIR ${IMPELLER_GENERATED_DIR}/impeller/entity)

add_library(modern_shaders_lib
    "${IMPELLER_GENERATED_DIR}/impeller/entity/gles/modern_shaders_gles.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/conical_gradient_ssbo_fill.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/linear_gradient_ssbo_fill.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/radial_gradient_ssbo_fill.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/sweep_gradient_ssbo_fill.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/points.comp"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/uv.comp")

target_include_directories(modern_shaders_lib
    PUBLIC
        $<BUILD_INTERFACE:${FLUTTER_INCLUDE_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"

# Framebuffer blend shaders (iOS only, but the headers need to be built regardless of the backend).

add_gles_shader_library(
    NAME framebuffer_blend
    GLES_LANGUAGE_VERSION 460
    SHADERS
        "${IMPELLER_ENTITY_DIR}/shaders/blending/ios/framebuffer_blend.vert"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/ios/framebuffer_blend_color.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/ios/framebuffer_blend_colorburn.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/ios/framebuffer_blend_colordodge.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/ios/framebuffer_blend_darken.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/ios/framebuffer_blend_difference.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/ios/framebuffer_blend_exclusion.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/ios/framebuffer_blend_hardlight.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/ios/framebuffer_blend_hue.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/ios/framebuffer_blend_lighten.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/ios/framebuffer_blend_luminosity.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/ios/framebuffer_blend_multiply.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/ios/framebuffer_blend_overlay.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/ios/framebuffer_blend_saturation.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/ios/framebuffer_blend_screen.frag"
        "${IMPELLER_ENTITY_DIR}/shaders/blending/ios/framebuffer_blend_softlight.frag"
    OUTPUT_DIR ${IMPELLER_GENERATED_DIR}/impeller/entity)

add_library(framebuffer_blend_shaders_lib
    "${IMPELLER_GENERATED_DIR}/impeller/entity/gles/framebuffer_blend_shaders_gles.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/framebuffer_blend.vert.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/framebuffer_blend_color.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/framebuffer_blend_colorburn.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/framebuffer_blend_colordodge.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/framebuffer_blend_darken.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/framebuffer_blend_difference.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/framebuffer_blend_exclusion.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/framebuffer_blend_hardlight.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/framebuffer_blend_hue.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/framebuffer_blend_lighten.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/framebuffer_blend_luminosity.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/framebuffer_blend_multiply.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/framebuffer_blend_overlay.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/framebuffer_blend_saturation.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/framebuffer_blend_screen.frag.cc"
    "${IMPELLER_GENERATED_DIR}/impeller/entity/framebuffer_blend_softlight.frag.cc")

target_include_directories(framebuffer_blend_shaders_lib
    PUBLIC
        $<BUILD_INTERFACE:${FLUTTER_INCLUDE_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"

# Build entity sources

file(GLOB ENTITY_SOURCES
    ${IMPELLER_ENTITY_DIR}/*.cc
    ${IMPELLER_ENTITY_DIR}/contents/*.cc
    ${IMPELLER_ENTITY_DIR}/contents/filters/*.cc
    ${IMPELLER_ENTITY_DIR}/contents/filters/inputs/*.cc)

list(FILTER ENTITY_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")
list(FILTER ENTITY_SOURCES EXCLUDE REGEX ".*_benchmarks?\\.cc$")

# TODO(bdero): Move to separate debug directory.
if(NOT ${CMAKE_BUILD_TYPE} MATCHES Debug)
    list(REMOVE_ITEM ${IMPELLER_ENTITY_DIR}/contents/checkerboard_contents.cc)
    list(REMOVE_ITEM ${IMPELLER_ENTITY_DIR}/contents/checkerboard_contents.h)
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
        impeller_geometry
        impeller_tessellator
        impeller_scene)
