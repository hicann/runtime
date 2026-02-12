# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

############ libacl_tdt_queue.so ############
add_library(acl_tdt_queue SHARED
    queue.cpp
    queue_manager.cpp
    queue_process.cpp
    queue_process_host.cpp
    queue_process_sp.cpp
    queue_process_ccpu.cpp
    toolchain/prof_api_reg.cpp
)

target_include_directories(acl_tdt_queue PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}
    ${CMAKE_CURRENT_LIST_DIR}/..
    ${CMAKE_CURRENT_LIST_DIR}/../common
    ${CMAKE_CURRENT_LIST_DIR}/../aclrt_impl
    ${RUNTIME_DIR}/include/external
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime
 	${RUNTIME_DIR}/src/inc
    ${RUNTIME_DIR}/src/inc/tdt
)

target_compile_options(acl_tdt_queue PRIVATE
    -fvisibility=hidden -O2 -Werror -fno-common
    -ftrapv
)

target_compile_definitions(acl_tdt_queue PRIVATE
    OS_TYPE=0
    FUNC_VISIBILITY
)

target_link_options(acl_tdt_queue PRIVATE
    -rdynamic
    -Wl,-Bsymbolic
    -Wl,--exclude-libs,ALL
    -Wl,--no-undefined
)

target_link_libraries(acl_tdt_queue PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:c_sec_headers>
    $<BUILD_INTERFACE:msprof_headers>
    acl_rt
    acl_rt_impl
    mmpa
    runtime
    c_sec
    unified_dlog
    profapi_share
    -Wl,--as-needed
    -ldl
    -lpthread
)
