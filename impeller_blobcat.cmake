set(BLOBCAT_DIR ${FLUTTER_ENGINE_DIR}/impeller/blobcat)

file(GLOB BLOBCAT_SOURCES ${BLOBCAT_DIR}/*.cc)
list(FILTER BLOBCAT_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")
list(REMOVE_ITEM BLOBCAT_SOURCES "${BLOBCAT_DIR}/blobcat_main.cc")

add_library(impeller_blobcat_lib STATIC ${BLOBCAT_SOURCES})

target_include_directories(impeller_blobcat_lib
    PUBLIC
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"
target_link_libraries(impeller_blobcat_lib PUBLIC fml impeller_base)

add_executable(blobcat "${BLOBCAT_DIR}/blobcat_main.cc")
target_include_directories(blobcat
    PUBLIC
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}>) # For includes starting with "impeller/"
target_link_libraries(blobcat PUBLIC impeller_blobcat_lib)
