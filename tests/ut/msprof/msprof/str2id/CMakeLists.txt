# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

# The API and provider both export Msprof* entry points in production. Keep them in
# separate binaries so aclprofStr2Id can execute both implementations without stubs.
# Generate protobuf sources in this directory so a clean build has their generation rules.
generate_cann_protobuf(aclprof_str2id_proto
    str2idProtoSources
    str2idProtoHeaders
    ${MSPROF_SOURCE_DIR}/dvvp/proto/profiler.proto
)

set(str2idProviderSources ${profilerSrcList})
list(REMOVE_ITEM str2idProviderSources
    ${MSPROF_SOURCE_DIR}/dvvp/msprofiler/prof_acl_core.cpp
    ${CMAKE_BINARY_DIR}/proto/msprofiler_utest_proto/proto/profiler.pb.cc
)
list(APPEND str2idProviderSources ${str2idProtoSources})
list(REMOVE_DUPLICATES str2idProviderSources)

add_library(aclprof_str2id_provider SHARED
    ${str2idProviderSources}
    hash_state.cpp
    ../../stub/drv_stub.cpp
    ../../stub/mmpa_stub.cpp
    ../../stub/hdc-log-stub.cpp
    ../../stub/devdrv_runtime_api_stub.cpp
    ../../stub/profile_drv_user_stub.cpp
    ../../stub/hdc-api-stub.cpp
    ../../stub/error_manager_stub2.cpp
)

target_include_directories(aclprof_str2id_provider PRIVATE
    ${CMAKE_BINARY_DIR}/proto/aclprof_str2id_proto
    $<TARGET_PROPERTY:msprofiler_utest,INCLUDE_DIRECTORIES>
)
target_compile_options(aclprof_str2id_provider PRIVATE
    $<TARGET_PROPERTY:msprofiler_utest,COMPILE_OPTIONS>
)
target_compile_definitions(aclprof_str2id_provider PRIVATE
    $<TARGET_PROPERTY:msprofiler_utest,COMPILE_DEFINITIONS>
)
target_link_options(aclprof_str2id_provider PRIVATE -Wl,-Bsymbolic -Wl,--no-undefined)
target_link_libraries(aclprof_str2id_provider PRIVATE msprof_utestonetrack_pub c_sec)
set_target_properties(aclprof_str2id_provider PROPERTIES
    OUTPUT_NAME profimpl
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

add_executable(aclprof_str2id_utest
    ../test/main.cpp
    aclprof_str2id_utest.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/msprofiler/prof_acl_core.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_inner_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_impl_inner_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_acl_inner_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_cann_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_acl_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_compute_injection.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_runtime_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_plugin_manager.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_tx_plugin.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profapi/src/prof_mstx_plugin.cpp
)
target_include_directories(aclprof_str2id_utest PRIVATE
    ${CMAKE_BINARY_DIR}/proto/aclprof_str2id_proto
    $<TARGET_PROPERTY:msprofiler_utest,INCLUDE_DIRECTORIES>
)
target_compile_options(aclprof_str2id_utest PRIVATE -g -Wall -Wextra)
# Keep the test provider ahead of the installed toolkit's libprofimpl.so in LD_LIBRARY_PATH.
target_link_options(aclprof_str2id_utest PRIVATE -Wl,--disable-new-dtags)
target_compile_definitions(aclprof_str2id_utest PRIVATE google=ascend_private)
if(BUILD_PROFILING_OPEN_PROJECT)
    target_compile_definitions(aclprof_str2id_utest PRIVATE BUILD_PROFILING_OPEN_PROJECT)
endif()
target_link_libraries(aclprof_str2id_utest PRIVATE
    aclprof_str2id_provider
    msprof_utestonetrack_pub
    c_sec
)
set_target_properties(aclprof_str2id_utest PROPERTIES
    BUILD_RPATH "$ORIGIN"
    BUILD_RPATH_USE_ORIGIN TRUE
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)
