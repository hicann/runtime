# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(ADUMP_SOURCE_DIR ${TOP_DIR}/abl/adump)
set(MSPROF_SOURCE_DIR ${TOP_DIR}/abl/msprof/collector)

set(profilerSrcFiles
    ${MSPROF_SOURCE_DIR}/dvvp/adda/impl/adx_dsmi.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/adda/impl/ide_common_util.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/adda/impl/ide_daemon_hdc.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/adda/impl/ide_daemon.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/adda/impl/ide_platform_util.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/adda/impl/impl_utils.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/adda/impl/ide_daemon_monitor.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/adda/impl/ide_task_register.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/utils/utils.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/common/cmd_log/cmd_log.cpp
    ${MSPROF_SOURCE_DIR}/basic/osal/osal.c
    ${MSPROF_SOURCE_DIR}/dvvp/profhal/adx/wrapper/hdc_api.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/profhal/adx/wrapper/memory_utils.cpp
    ${MSPROF_SOURCE_DIR}/dvvp/depend/stub/error_manager/msprof_error_manager_stub.cpp
)

set(localSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/ide_daemon_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/ide_platform_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/ide_monitor_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/ide_hdc_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/mmpa_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/stub/sec_stub.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/ide_common_util_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/ide_daemon_common_utils_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/ide_daemon_device_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/ide_daemon_hdc_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/ide_daemon_stest.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/test/ide_handle_stest.cc
    ../stub/error_manager_stub.cpp
)

add_executable(adda_stest
    ${profilerSrcFiles}
    ${localSrcFiles}
)

target_include_directories(adda_stest PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/stub
    ../stub
    ${MSPROF_SOURCE_DIR}/dvvp
    ${MSPROF_SOURCE_DIR}/dvvp/adda/impl
    ${MSPROF_SOURCE_DIR}/dvvp/common
    ${MSPROF_SOURCE_DIR}/dvvp/common/cmd_log
    ${MSPROF_SOURCE_DIR}/dvvp/common/logger
    ${MSPROF_SOURCE_DIR}/basic/osal
    ${MSPROF_SOURCE_DIR}/dvvp/profhal/adx/inc
    ${MSPROF_SOURCE_DIR}/dvvp/depend/include/stub
    ${TOP_DIR}/inc/driver
    ${TOP_DIR}/metadef/inc
    ${TOP_DIR}/metadef/inc/external
)

target_compile_definitions(adda_stest PRIVATE
    __IDE_ST
    IDE_DEBUG
    CFG_BUILD_DEBUG
    IDE_DAEMON_DEVICE
    IDE_DAEMON_RC
)

target_link_libraries(adda_stest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    -Wl,--as-needed
    -lpthread
    c_sec
    ascend_protobuf
)

target_compile_options(adda_stest PRIVATE
    -Werror
)

target_link_options(adda_stest PRIVATE
)

run_llt_test(
    TARGET adda_stest
    TASK_NUM 1
)