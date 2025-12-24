# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(STACKCORE_SOURCE_PATH ${TOP_DIR}/abl/slog/syslog/log_daemon/stackcore)

############ stackcore ###########
set(stackcoreSrcList
    ${STACKCORE_SOURCE_PATH}/stackcore.c
    ${STACKCORE_SOURCE_PATH}/stackcore_common.c
)

set(stackcoreUtSrcList
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase/stackcore_utest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/stackcore_stub.cc
    ${stackcoreSrcList}
)

set(stackcoreHeaders
    ${TOP_DIR}/abl/libc_sec/include
    ${TOP_DIR}/abl/slog/inc/stackcore
    ${STACKCORE_SOURCE_PATH}
)

add_executable(stackcore_utest
    ${stackcoreUtSrcList}
)

target_include_directories(stackcore_utest PRIVATE
    ${stackcoreHeaders}
)

target_compile_definitions(stackcore_utest PRIVATE
    __IDE_UT
    IDE_DEBUG
    CFG_BUILD_DEBUG
    IDE_DAEMON_DEVICE
    IDE_DAEMON_RC
    _GNU_SOURCE
    LLT_TEST
    STACKCORE_DEBUG
)

target_link_libraries(stackcore_utest PRIVATE
    $<BUILD_INTERFACE:stackcore_utestonetrack_pub>
    $<BUILD_INTERFACE:intf_llt_pub>
    c_sec
    -Wl,-rpath,${TOP_DIR}/output/llt/c_sec/lib
)

target_compile_options(stackcore_utest PRIVATE
    -Werror
    -std=c99
    -std=c++11
)

target_link_options(stackcore_utest PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
)

add_library(stackcore_utestonetrack_pub INTERFACE)

target_link_libraries(stackcore_utestonetrack_pub INTERFACE
    $<BUILD_INTERFACE:intf_llt_pub>
    -Wl,--as-needed
    -lpthread
)

run_llt_test(
    TARGET stackcore_utest
    TASK_NUM 1
)
