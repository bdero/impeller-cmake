set(IMPELLER_RUNTIME_STAGE_DIR ${FLUTTER_ENGINE_DIR}/impeller/runtime_stage
    CACHE STRING "Location of the Impeller runtime stage sources.")

flatbuffers_schema(
    INPUT ${IMPELLER_RUNTIME_STAGE_DIR}/runtime_stage.fbs
    OUTPUT_DIR ${IMPELLER_GENERATED_DIR}/impeller/runtime_stage)

file(GLOB RUNTIME_STAGE_SOURCES
    ${IMPELLER_RUNTIME_STAGE_DIR}/*.cc)
list(FILTER RUNTIME_STAGE_SOURCES EXCLUDE REGEX ".*_unittests?\\.cc$")
list(REMOVE_ITEM RUNTIME_STAGE_SOURCES "${IMPELLER_RUNTIME_STAGE_DIR}/runtime_stage_playground.cc")

add_library(impeller_runtime_stage STATIC
    ${RUNTIME_STAGE_SOURCES}
    ${IMPELLER_GENERATED_DIR}/impeller/runtime_stage/runtime_stage_flatbuffers.h)

target_link_libraries(impeller_runtime_stage
    PUBLIC
        fml impeller_base)
target_include_directories(impeller_runtime_stage
    PUBLIC
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}> # For includes starting with "flutter/"
        $<BUILD_INTERFACE:${FLUTTER_ENGINE_DIR}> # For includes starting with "impeller/"
        $<BUILD_INTERFACE:${THIRD_PARTY_DIR}/flatbuffers/include> # For includes starting with "flatbuffers/"
        $<BUILD_INTERFACE:${IMPELLER_GENERATED_DIR}>) # For generated flatbuffer schemas
