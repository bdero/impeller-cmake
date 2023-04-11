// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "typographer_backends/noop/text_render_context_noop.h"

namespace impeller {

std::unique_ptr<TextRenderContext> TextRenderContext::Create(
    std::shared_ptr<Context> context) {
  return std::make_unique<TextRenderContextNoOp>();
}

TextRenderContextNoOp::TextRenderContextNoOp() = default;

TextRenderContextNoOp::~TextRenderContextNoOp() = default;

std::shared_ptr<GlyphAtlas> TextRenderContextNoOp::CreateGlyphAtlas(
    GlyphAtlas::Type type,
    std::shared_ptr<GlyphAtlasContext> atlas_context,
    FrameIterator frame_iterator) const {
  return nullptr;
}

}  // namespace impeller
