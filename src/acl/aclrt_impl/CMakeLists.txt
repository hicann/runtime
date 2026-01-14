# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

############ libacl_rt_impl.so ############
add_library(acl_rt_impl SHARED
    ../common/log_inner.cpp
    ../common/prof_reporter.cpp
    ../common/resource_statistics.cpp
    acl.cpp
    log.cpp
    device.cpp
    dfx.cpp
    event.cpp
    stream.cpp
    memory.cpp
    context.cpp
    callback.cpp
    group.cpp
    kernel.cpp
    notify.cpp
    label.cpp
    acl_rt_impl_base.cpp
    model_ri.cpp
    data_buffer.cpp
    allocator.cpp
    callback_api.cpp
    init_callback_manager.cpp
    snapshot.cpp
    types/fp16.cpp
    types/fp16_impl.cpp
    ../common/json_parser.cpp
    ../utils/string_utils.cpp
    ../utils/cann_info_utils.cpp
    ../utils/hash_utils.cpp
    ../utils/file_utils.cpp
    toolchain/dump.cpp
    toolchain/profiling.cpp
    toolchain/profiling_manager.cpp
)

set(ACL_INC_EXTERNAL_DIR ${CMAKE_CURRENT_LIST_DIR}/../../../include/external)

target_include_directories(acl_rt_impl PRIVATE
    ${ACL_INC_EXTERNAL_DIR}
    ${CMAKE_CURRENT_LIST_DIR}
    ${CMAKE_CURRENT_LIST_DIR}/..
    ${CMAKE_CURRENT_LIST_DIR}/../aclrt_impl
    ${RUNTIME_DIR}/pkg_inc
    ${RUNTIME_DIR}/pkg_inc/dump
    ${RUNTIME_DIR}/src
    ${RUNTIME_DIR}/src/dfx/error_manager
    ${RUNTIME_DIR}/src/dfx/adump/inc/metadef/external
    ${RUNTIME_DIR}/include/dfx
)

target_compile_options(acl_rt_impl PRIVATE
    -fvisibility=hidden -O2 -Werror -fno-common
    -ftrapv
)

target_compile_definitions(acl_rt_impl PRIVATE
    OS_TYPE=0
    FUNC_VISIBILITY
)

target_link_options(acl_rt_impl PRIVATE
    -rdynamic
    -Wl,-Bsymbolic
    -Wl,--exclude-libs,ALL
    -Wl,--no-undefined
)

target_link_libraries(acl_rt_impl PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:c_sec_headers>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:msprof_headers>
    $<BUILD_INTERFACE:platform_headers>
    mmpa
    runtime
    c_sec
    unified_dlog
    profapi_share
    platform
    ascend_dump
    json
    error_manager
    -Wl,--as-needed
    -ldl
    -lpthread
)
