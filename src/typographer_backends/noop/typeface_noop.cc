// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "typographer_backends/noop/typeface_noop.h"

namespace impeller {

TypefaceNoOp::TypefaceNoOp() = default;

TypefaceNoOp::~TypefaceNoOp() = default;

bool TypefaceNoOp::IsValid() const {
  return true;
}

std::size_t TypefaceNoOp::GetHash() const {
  if (!IsValid()) {
    return 0u;
  }

  return reinterpret_cast<size_t>(typeface_.get());
}

bool TypefaceNoOp::IsEqual(const Typeface& other) const {
  return true;
}

}  // namespace impeller
