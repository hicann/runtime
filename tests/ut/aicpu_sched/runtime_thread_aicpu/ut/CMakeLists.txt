# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set(RUNTIME_THREAD_AICPU_SRC_PATH ${AICPU_SCHED_PATH}/runtime_thread_aicpu)

add_executable(runtime_thread_aicpu_utest
    main_ut.cc
    runtime_thread_aicpu_ut.cc
    ${RUNTIME_THREAD_AICPU_SRC_PATH}/runtime_thread_aicpu_plugin.cc
    ${RUNTIME_THREAD_AICPU_SRC_PATH}/runtime_thread_aicpu_service.cc
    ${RUNTIME_THREAD_AICPU_SRC_PATH}/runtime_thread_aicpu_so_manager.cc
    ${RUNTIME_DIR}/tests/ut/aicpu_sched/aicpu_schedule/stub/slog_stub.cpp
)

target_include_directories(runtime_thread_aicpu_utest PRIVATE
    ${RUNTIME_THREAD_AICPU_SRC_PATH}
    ${RUNTIME_DIR}/include
    ${RUNTIME_DIR}/pkg_inc
    ${RUNTIME_DIR}/pkg_inc/base
    ${RUNTIME_DIR}/pkg_inc/driver
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/aicpu_schedule
    ${RUNTIME_DIR}/src
)

target_link_libraries(runtime_thread_aicpu_utest PRIVATE
    $<BUILD_INTERFACE:intf_aicpu_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
    dl
    pthread
)
