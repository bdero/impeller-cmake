#!/usr/bin/env bash
# Copyright 2013 The Flutter Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set -e

echo "Fetching impeller-cmake git submodules..."
git submodule update --init --recursive
echo "Done fetching impeller-cmake git submodules."
echo

ROOT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}"); pwd -P)

echo "Fetching shaderc dependencies..."
pushd $ROOT_DIR/third_party/shaderc > /dev/null
  ./utils/git-sync-deps
popd > /dev/null
echo "Done fetching shaderc dependencies."
