// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#pragma once

#include "flutter/fml/macros.h"
#include "impeller/base/backend_cast.h"
#include "impeller/typographer/typeface.h"

namespace impeller {

class TypefaceNoOp final : public Typeface,
                           public BackendCast<TypefaceNoOp, Typeface> {
 public:
  TypefaceNoOp();

  ~TypefaceNoOp() override;

  // |Typeface|
  bool IsValid() const override;

  // |Comparable<Typeface>|
  std::size_t GetHash() const override;

  // |Comparable<Typeface>|
  bool IsEqual(const Typeface& other) const override;

 private:
  FML_DISALLOW_COPY_AND_ASSIGN(TypefaceNoOp);
};

}  // namespace impeller
