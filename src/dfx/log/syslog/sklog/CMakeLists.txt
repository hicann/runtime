# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(sklogdSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/klogd.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../common/pm/log_pm.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../common/pm/log_monitor.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../common/pm/start_single_process.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../common/pm/log_pm_sr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../common/pm/log_pm_sig.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../common/log_path_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../common/log_print_selflog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../common/config/log_config_list.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../common/config/log_config_block.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../common/config/log_config_common.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../common/config/log_config_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils/log_system_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils/log_common.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils/log_file_util.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils/log_print_syslog.c)

set(sklogdHeaderDir
    ${RUNTIME_DIR}/abl/libc_sec/include
    ${RUNTIME_DIR}/inc/driver
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils
    ${CMAKE_CURRENT_SOURCE_DIR}/../../shared
    ${TOOLAHCIN_LOG_DIR}/syslog/common
    ${TOOLAHCIN_LOG_DIR}/syslog/common/pm
    ${TOOLAHCIN_LOG_DIR}/syslog/common/config
    ${CMAKE_CURRENT_SOURCE_DIR}/../slog/src)
if (PRODUCT)
if (${PRODUCT} STREQUAL "ascend310p" OR (${PRODUCT} STREQUAL "ascend310B") OR (${PRODUCT} STREQUAL "ascend310Besl") OR (${PRODUCT} STREQUAL "ascend310Brc") OR (${PRODUCT} STREQUAL "helper310p") OR (${PRODUCT} STREQUAL "ascend310Brcesl") OR ${PRODUCT} STREQUAL "ascend910" OR ${PRODUCT} STREQUAL "ascend910B")
    list(APPEND sklogdHeaderDir
        ${IAM_HEADER_DIR}/include
        ${MDC_LINUX_SDK_DIR}/include)
endif ()
endif ()

add_executable(sklogd
    ${sklogdSrcFiles})

target_include_directories(sklogd PRIVATE
    ${sklogdHeaderDir})

target_compile_definitions(sklogd PRIVATE
    OS_TYPE_DEF=0
    $<$<STREQUAL:${PRODUCT},ascend310>:SCRIPT_MONITOR>
    $<$<STREQUAL:${PRODUCT},ascend310p>: IAM_MONITOR>
    $<$<STREQUAL:${PRODUCT},ascend310B>: IAM_MONITOR LINUX_ETC_CONF>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>: IAM_MONITOR LINUX_ETC_CONF>
    $<$<STREQUAL:${PRODUCT},ascend310Brc>: IAM_MONITOR LINUX_ETC_CONF>
    $<$<STREQUAL:${PRODUCT},ascend310Brcesl>: IAM_MONITOR LINUX_ETC_CONF>
    $<$<STREQUAL:${PRODUCT},ascend910>: IAM_MONITOR>
    $<$<STREQUAL:${PRODUCT},ascend910B>:IAM_MONITOR>
    $<$<STREQUAL:${PRODUCT},helper310p>:IAM_MONITOR LINUX_ETC_CONF>
)

target_compile_options(sklogd PRIVATE
    -Wfloat-equal -Wextra
    -Wunused
    -Wshadow
    -Wstrict-prototypes
    -Wundef
    -std=gnu11
    $<$<CONFIG:Debug>:-g -O0>
    $<$<CONFIG:Release>:-Os -D_FORTIFY_SOURCE=2>
    -Werror
    -fPIE
    -fstack-protector-strong
    -fno-common
    -fsigned-char
    -fno-strict-aliasing
    -fvisibility=hidden
    -fdata-sections
    -ffunction-sections
)

target_link_options(sklogd PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,--gc-sections
    $<$<STREQUAL:${PRODUCT},ascend310p>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310B>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310Brc>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310Brcesl>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},helper310p>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend910>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend910B>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
)

target_link_libraries(sklogd PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:slog_headers>
    $<$<STREQUAL:${PRODUCT},ascend310>:ascend_monitor>
    $<$<STREQUAL:${PRODUCT},ascend310p>:iam>
    $<$<STREQUAL:${PRODUCT},ascend310B>:iam>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:iam>
    $<$<STREQUAL:${PRODUCT},ascend310Brc>:iam>
    $<$<STREQUAL:${PRODUCT},ascend310Brcesl>:iam>
    $<$<STREQUAL:${PRODUCT},ascend910>:iam>
    $<$<STREQUAL:${PRODUCT},ascend910B>:iam>
    $<$<STREQUAL:${PRODUCT},helper310p>:iam>
    c_sec
    slog
)

set_target_properties(sklogd
    PROPERTIES
    OUTPUT_NAME sklogd
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

###################################################################
if (PRODUCT)
if (${PRODUCT} STREQUAL "ascend310")
add_custom_target(sklogDeviceFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../scripts/sklogd_daemon_monitor.sh ${CMAKE_CURRENT_BINARY_DIR}
)
endif ()
endif ()

###################################################################
set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR  lib/cmake)

include(CMakePackageConfigHelpers)

install(TARGETS sklogd
    RUNTIME DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)

if (PRODUCT)
if (${PRODUCT} STREQUAL "ascend310")
install(PROGRAMS
    ${CMAKE_CURRENT_BINARY_DIR}/sklogd_daemon_monitor.sh
    DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)
endif ()
endif ()
