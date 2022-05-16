set(FML_DIR ${FLUTTER_ENGINE_DIR}/fml)

file(GLOB FML_SOURCES ${FML_DIR}/*.cc)
list(FILTER FML_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")
list(REMOVE_ITEM FML_SOURCES "${FML_DIR}/message_loop_task_queues_benchmark.cc")
list(REMOVE_ITEM FML_SOURCES "${FML_DIR}/icu_util.cc")

# Add platform-specific FML backend sources.
if(WIN32)
    file(GLOB FML_PLATFORM_SOURCES
        ${FML_DIR}/platform/win/*.cc)
    list(REMOVE_ITEM FML_SOURCES "${FML_DIR}/backtrace.cc")
    list(APPEND FML_SOURCES "${FML_DIR}/backtrace_stub.cc")

    # https://github.com/flutter/flutter/issues/50053
    add_compile_definitions(_SILENCE_CXX17_CODECVT_HEADER_DEPRECATION_WARNING)
elseif(APPLE)
    file(GLOB FML_PLATFORM_SOURCES
        ${FML_DIR}/platform/darwin/*.mm ${FML_DIR}/platform/darwin/*.cc)
elseif(UNIX)
    file(GLOB FML_PLATFORM_SOURCES
        ${FML_DIR}/platform/linux/*.cc)
endif()
list(FILTER FML_PLATFORM_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")

add_library(fml STATIC ${FML_SOURCES} ${FML_PLATFORM_SOURCES})

if (WIN32)
    target_link_libraries(fml PRIVATE shlwapi rpcrt4)
endif()

target_include_directories(fml
    PUBLIC
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}> # For includes starting with "third_party/" (abseil-cpp)
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}>/abseil-cpp) # For includes starting with "absl/" (in the abseil headers)

target_link_libraries(fml PRIVATE absl_symbolize)
