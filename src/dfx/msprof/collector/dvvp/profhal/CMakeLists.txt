# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
####################### libascendprofhal.so ###########################

add_library(ascendprof_fwk_share SHARED
    ../common/memory/chunk_pool.cpp
    ../common/statistics/perf_count.cpp
    ../common/thread/thread.cpp
    ../common/thread/thread_pool.cpp
    ../common/utils/utils.cpp
    ../common/cmd_log/cmd_log.cpp
    ../common/json/json.cpp
    ${PROF_BASIC_DIR}/osal/osal.c
    ../depend/stub/error_manager/msprof_error_manager_stub.cpp
    halimpl/prof_hal_api.cpp
    halimpl/prof_server_manager.cpp
    ${CppPath}
)

target_include_directories(ascendprof_fwk_share PRIVATE
    ${RUNTIME_DIR}/src/inc/
    ${RUNTIME_DIR}/src/dfx/msprof/inc/toolchain
    ${RUNTIME_DIR}/src/dfx/msprof/inc
    ${LIBC_SEC_HEADER}
    ${RUNTIME_DIR}/pkg_inc/driver
    ${RUNTIME_DIR}/include/external
    ../
    ../msprof/
    ../msprof/common/include
    ../msprof/platform/include
    ../msprof/engine/include
    ../common
    ../common/validation
    ../common/errno
    ../common/logger
    ../common/queue
    ../common/singleton
    ../common/utils
    ../common/cmd_log
    ../common/json
    ${PROF_BASIC_DIR}/osal
    ../depend/include/stub
    ../message
    ../transport
    ../streamio/client/include
    ../streamio/common/include
    ../driver/inc
    ../profimpl/report
    ../profhal/halinc
    adx/inc
    halimpl
    halinc
    ${CMAKE_CURRENT_SOURCE_DIR}
)

set_target_properties(ascendprof_fwk_share
    PROPERTIES
    OUTPUT_NAME ascendprofhal
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

target_compile_definitions(ascendprof_fwk_share PRIVATE
    google=ascend_private
    $<$<STREQUAL:${CMAKE_BUILD_TYPE},Debug>:MSPROF_DEBUG>
)

target_compile_options(ascendprof_fwk_share PRIVATE
    -fPIC
    -shared
    -fstack-protector-all
    -fno-strict-aliasing
    -fno-common
    -Wall
    -Wextra
    -Wfloat-equal
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Debug>>:/MTd>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Release>>:/MT>
)

target_link_options(ascendprof_fwk_share PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
    -Wl,--exclude-libs=ALL
)

# msprof 通用服务器场景：ascendprof_fwk_share 源码不直接引用任何驱动符号（driver 调用
# 均经 MsprofDrvApi 间接 dlopen/dlsym），链接期不需要 ascend_hal_stub，避免 NEEDED 表
# 带上 libascend_hal.so（无驱动包环境下会导致本 so 加载期失败）。

target_link_libraries(ascendprof_fwk_share PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
    alog
    mmpa
    error_manager
)

install(TARGETS ascendprof_fwk_share OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)
####################### libascendprofhal.so ###########################
