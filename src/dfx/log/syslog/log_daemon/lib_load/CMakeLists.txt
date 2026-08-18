# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(libLoadSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/lib_load.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/log_path_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/log_print_selflog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/config/log_config_list.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/config/log_config_block.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/config/log_config_common.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/config/log_config_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/driver/log_drv.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/driver/driver_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_file_util.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_system_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_print_syslog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_common.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/library_load.c
)

set(libLoadDir
    ${LIBC_SEC_HEADER}
    ${RUNTIME_DIR}/pkg_inc/driver
    ${TOOLAHCIN_LOG_DIR}/utils
    ${TOOLAHCIN_LOG_DIR}/syslog/common
    ${TOOLAHCIN_LOG_DIR}/syslog/common/driver
    ${TOOLAHCIN_LOG_DIR}/syslog/common/config
    ${TOOLAHCIN_LOG_DIR}/syslog/log_daemon/lib_load
    ${RUNTIME_DIR}/src/dfx/adump/external
)

###################################################################
add_library(lib_load STATIC
    ${libLoadSrcFiles})

target_include_directories(lib_load PRIVATE
    ${libLoadDir}
    ../include
    ../server_mgr
)

target_compile_definitions(lib_load PRIVATE
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:OS_TYPE_DEF=1>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:OS_TYPE_DEF=0>
)

target_compile_options(lib_load PRIVATE
    -Wfloat-equal -Wextra
    $<$<CONFIG:Debug>:-g -O0>
    $<$<CONFIG:Release>:-Os>
    -Wunused
    -Wshadow
    -Wundef
    -Werror
    -fPIE
    -fstack-protector-strong
    -fno-common
    -fsigned-char
    -fno-strict-aliasing
    -fdata-sections
    -ffunction-sections
    -std=gnu11
)

target_link_options(lib_load PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,--gc-sections
)

target_link_libraries(lib_load PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
    ascend_hal
)

set_target_properties(lib_load
    PROPERTIES
    OUTPUT_NAME lib_load
)