# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(libhbmDeviceSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/hbm_detect.c
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
    ${CMAKE_CURRENT_SOURCE_DIR}/../server_mgr/server_mgr.c
)

set(libhbmDeviceDir
    ${LIBC_SEC_HEADER}
    ${RUNTIME_DIR}/pkg_inc/driver
    ${TOOLAHCIN_LOG_DIR}/utils
    ${TOOLAHCIN_LOG_DIR}/syslog/common
    ${TOOLAHCIN_LOG_DIR}/syslog/common/driver
    ${TOOLAHCIN_LOG_DIR}/syslog/common/config
    ${TOOLAHCIN_LOG_DIR}/syslog/log_daemon/hbm_detect
    ${TOOLAHCIN_LOG_DIR}/syslog/log_daemon/server_mgr
    ${RUNTIME_DIR}/src/dfx/adump/external
)

###################################################################
add_library(hbm_detect SHARED
    ${libhbmDeviceSrcFiles})

target_include_directories(hbm_detect PRIVATE
    ${libhbmDeviceDir}
    ../include
    ../server_mgr
)

target_compile_definitions(hbm_detect PRIVATE
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:OS_TYPE_DEF=1>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:OS_TYPE_DEF=0>
)

target_compile_options(hbm_detect PRIVATE
    -Wfloat-equal -Wextra
    $<$<CONFIG:Debug>:-g -O0>
    $<$<CONFIG:Release>:-Os>
    -Wunused
    -Wshadow
    -Wundef
    -Werror
    -fPIC
    -fstack-protector-strong
    -fno-common
    -fsigned-char
    -fno-strict-aliasing
    -fdata-sections
    -ffunction-sections
    -std=gnu11
)

target_link_options(hbm_detect PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,--gc-sections
)

target_link_libraries(hbm_detect PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adcore_headers>
    c_sec
    adcore
)

set_target_properties(hbm_detect
    PROPERTIES
    OUTPUT_NAME hbm_detect
)

install(TARGETS hbm_detect OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)
###################################################################
set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR  lib/cmake)

include(CMakePackageConfigHelpers)
