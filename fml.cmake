set(FML_DIR ${FLUTTER_ENGINE_DIR}/fml)

file(GLOB FML_SOURCES ${FML_DIR}/*.cc)
list(FILTER FML_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")

if(WIN32)
    file(GLOB FML_PLATFORM_SOURCES
        ${FML_DIR}/platform/win/*.cc)
elseif(APPLE)
    file(GLOB FML_PLATFORM_SOURCES
        ${FML_DIR}/platform/darwin/*.mm ${FML_DIR}/platform/win/*.cc)
elseif(UNIX)
    file(GLOB FML_PLATFORM_SOURCES
        ${FML_DIR}/platform/linux/*.cc)
endif()
list(FILTER FML_PLATFORM_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")

add_library(fml STATIC ${FML_SOURCES} ${FML_PLATFORM_SOURCES})

if (WIN32)
    # `backtrace.cc` includes headers that expect `windows.h` to be included
    # prior, but it's not. So define the needed `windows.h` architecture macros.
    if(CMAKE_SIZEOF_VOID_P EQUAL 8)
        target_compile_definitions(fml PRIVATE _AMD64_)
    elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
        target_compile_definitions(fml PRIVATE _X86_)
    endif()
endif()

target_include_directories(fml
    PUBLIC
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}> # For includes starting with "third_party/" (abseil-cpp)
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}>/abseil-cpp) # For includes starting with "absl/" (in the abseil headers)

target_link_libraries(fml PUBLIC absl)
