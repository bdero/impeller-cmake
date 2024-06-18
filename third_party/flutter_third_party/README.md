# flutter_third_party

This directory exists for the sole purpose of supporting includes that begin
with `flutter/third_party`.

`third_party/flutter_third_party/flutter/third_party` is a symlink that
redirects to `third_party/flutter_third_party`.

And so CMake libraries can simply add
`${CMAKE_CURRENT_SOURCE_DIR}/third_party/flutter_third_party` to the includes
list alongside `${CMAKE_CURRENT_SOURCE_DIR}` to support both includes starting
with `flutter/third_party/` and `third_party/` respectively.

## Why?

When building Flutter Engine via the GN build, gclient clones many
dependencies into the `flutter/third_party` directory. And source files in
Flutter Engine may begin includes with either `flutter/third_party/` or
`third_party/` to access the headers in this directory.
