// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include "flutter/fml/macros.h"
#include "impeller/typographer/text_render_context.h"

namespace impeller {

class TextRenderContextNoOp : public TextRenderContext {
 public:
  TextRenderContextNoOp();

  ~TextRenderContextNoOp() override;

  // |TextRenderContext|
  std::shared_ptr<GlyphAtlas> CreateGlyphAtlas(
      GlyphAtlas::Type type,
      std::shared_ptr<GlyphAtlasContext> atlas_context,
      FrameIterator iterator) const override;

 private:
  FML_DISALLOW_COPY_AND_ASSIGN(TextRenderContextNoOp);
};

}  // namespace impeller
