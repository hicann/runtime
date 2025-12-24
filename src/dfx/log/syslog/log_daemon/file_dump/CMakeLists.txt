# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
#########libfile_dump.a
set(fileDumpSrcList
    ${CMAKE_CURRENT_LIST_DIR}/log_get_file.cpp
    ${CMAKE_CURRENT_LIST_DIR}/log_process_util.cpp
    ${CMAKE_CURRENT_LIST_DIR}/log_dsmi_drv.cpp
    ${CMAKE_CURRENT_LIST_DIR}/log_file_utils.cpp
    ${CMAKE_CURRENT_LIST_DIR}/log_file_dump_c.cpp
)

set(fileDumpHeaderDir
    ${RUNTIME_DIR}/abl/adump/inc/adump
    ${RUNTIME_DIR}/abl/adump/external
    ${TOOLAHCIN_LOG_DIR}/utils
    ${TOOLAHCIN_LOG_DIR}/shared
    ${TOOLAHCIN_LOG_DIR}/../../include/log/msnpureport
)

add_library(file_dump STATIC
    ${fileDumpSrcList}
)

target_include_directories(file_dump PRIVATE
    ${fileDumpHeaderDir})

target_compile_options(file_dump PRIVATE
    -Werror
    $<$<CONFIG:Debug>:-g -O0>
    $<$<CONFIG:Release>:-Os>
    -std=c++11
    -fstack-protector-strong
    -fno-common
    -fno-strict-aliasing
    -Wfloat-equal -Wextra
    -fdata-sections
    -ffunction-sections
)

target_link_options(file_dump PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,--gc-sections
)

target_compile_definitions(file_dump PRIVATE
    ADX_LIB
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:OS_TYPE=0>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:OS_TYPE=1>
)

target_link_libraries(file_dump PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adcore_headers>
    -Wl,--no-as-needed
    c_sec
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:mmpa>
    $<$<STREQUAL:${PRODUCT_SIDE},device>:slog>
    adcore
    hdclog_device
    hbm_detect
    cpu_detect_server
    -Wl,--as-needed
)

if (PRODUCT)
install(PROGRAMS
    ${CMAKE_CURRENT_SOURCE_DIR}/../scripts/log_daemon_collect.sh
    DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)
endif ()