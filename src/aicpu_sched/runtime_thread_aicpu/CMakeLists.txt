# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set(RUNTIME_THREAD_AICPU_RUNTIME_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../../..)
set(RUNTIME_THREAD_AICPU_CONTEXT_SOURCE ${CMAKE_CURRENT_SOURCE_DIR}/../aicpu_sharder/aicpu_context.cc)

add_library(runtime_thread_aicpu SHARED
    runtime_thread_aicpu_plugin.cc
    runtime_thread_aicpu_service.cc
    runtime_thread_aicpu_so_manager.cc
    ${RUNTIME_THREAD_AICPU_CONTEXT_SOURCE}
)

target_compile_options(runtime_thread_aicpu PRIVATE
    -O2
    -std=c++11
    -fno-common
    -fvisibility=hidden
    -Werror
    -Wextra
)

# Operator libraries resolve the public AICPU context symbols from this process-level plugin.
set_source_files_properties(${RUNTIME_THREAD_AICPU_CONTEXT_SOURCE}
    PROPERTIES COMPILE_OPTIONS "-fvisibility=default"
)

target_include_directories(runtime_thread_aicpu PRIVATE
    ${RUNTIME_THREAD_AICPU_RUNTIME_DIR}/include
    ${RUNTIME_THREAD_AICPU_RUNTIME_DIR}/pkg_inc
    ${RUNTIME_THREAD_AICPU_RUNTIME_DIR}/pkg_inc/base
    ${RUNTIME_THREAD_AICPU_RUNTIME_DIR}/pkg_inc/driver
    ${RUNTIME_THREAD_AICPU_RUNTIME_DIR}/pkg_inc/aicpu_sched
    ${RUNTIME_THREAD_AICPU_RUNTIME_DIR}/pkg_inc/aicpu_sched/aicpu_schedule
    ${RUNTIME_THREAD_AICPU_RUNTIME_DIR}/src
    ${RUNTIME_THREAD_AICPU_RUNTIME_DIR}/src/inc
    ${CMAKE_CURRENT_SOURCE_DIR}/../aicpu_schedule/common
    ${CMAKE_CURRENT_SOURCE_DIR}/../aicpu_sharder
)

target_link_libraries(runtime_thread_aicpu PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    ascend_hal_stub
    dl
    pthread
)

set_target_properties(runtime_thread_aicpu PROPERTIES OUTPUT_NAME runtime_thread_aicpu)

install(TARGETS runtime_thread_aicpu OPTIONAL LIBRARY DESTINATION lib)
