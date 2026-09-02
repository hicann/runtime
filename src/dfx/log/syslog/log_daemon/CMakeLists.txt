# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
add_subdirectory(config_cmd)
add_subdirectory(hbm_detect)
add_subdirectory(file_dump)
add_subdirectory(sys_monitor)
add_subdirectory(stackcore)
add_subdirectory(cpu_detect)
add_subdirectory(lib_load)

###################################################################
set(logDaemonSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/log_daemon.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_daemon_server.c
    ${CMAKE_CURRENT_SOURCE_DIR}/server_mgr/server_mgr.c
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
    ${CMAKE_CURRENT_SOURCE_DIR}/../common/driver/log_drv.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../common/driver/driver_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils/log_print_syslog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils/log_file_util.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils/log_system_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils/log_common.c
    ${CMAKE_CURRENT_SOURCE_DIR}/event_process/event_process_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/file_monitor/file_monitor_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/file_monitor/file_monitor_common.c
    ${CMAKE_CURRENT_SOURCE_DIR}/file_monitor/file_bbox_monitor.c
    ${CMAKE_CURRENT_SOURCE_DIR}/file_monitor/stackcore_file_monitor.c
    ${CMAKE_CURRENT_SOURCE_DIR}/file_monitor/file_slogdlog_monitor.c
    ${CMAKE_CURRENT_SOURCE_DIR}/file_monitor/file_device_app_monitor.c
)

set(logDaemonHeaderDir
    ${LIBC_SEC_HEADER}
    ${RUNTIME_DIR}/pkg_inc/driver
    ${TOOLAHCIN_LOG_DIR}/utils
    ${TOOLAHCIN_LOG_DIR}/syslog/common
    ${TOOLAHCIN_LOG_DIR}/syslog/common/pm
    ${TOOLAHCIN_LOG_DIR}/syslog/common/config
    ${TOOLAHCIN_LOG_DIR}/syslog/common/driver
    ${TOOLAHCIN_LOG_DIR}/syslog/log_daemon
    ${TOOLAHCIN_LOG_DIR}/syslog/log_daemon/config_cmd
    ${TOOLAHCIN_LOG_DIR}/syslog/log_daemon/file_dump
    ${TOOLAHCIN_LOG_DIR}/syslog/log_daemon/sys_monitor
    ${TOOLAHCIN_LOG_DIR}/syslog/log_daemon/stackcore
    ${TOOLAHCIN_LOG_DIR}/syslog/log_daemon/event_process
    ${TOOLAHCIN_LOG_DIR}/syslog/log_daemon/file_monitor
    ${TOOLAHCIN_LOG_DIR}/syslog/log_daemon/server_mgr
    ${TOOLAHCIN_LOG_DIR}/syslog/log_daemon/lib_load
    ${TOOLAHCIN_LOG_DIR}/syslog/log_daemon/include
    ${RUNTIME_DIR}/src/dfx/adump
    ${RUNTIME_DIR}/src/dfx/adump/external
)

set(logDaemonRcSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/log_daemon.c
    ${CMAKE_CURRENT_SOURCE_DIR}/event_process/event_process_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/file_monitor/file_monitor_common.c
    ${CMAKE_CURRENT_SOURCE_DIR}/file_monitor/stackcore_file_monitor.c
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
    ${CMAKE_CURRENT_SOURCE_DIR}/../common/driver/log_drv.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../common/driver/driver_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils/log_print_syslog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils/log_file_util.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils/log_system_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils/log_common.c
)

set(logDaemonRcHeaderDir
    ${LIBC_SEC_HEADER}
    ${RUNTIME_DIR}/pkg_inc/driver
    ${TOOLAHCIN_LOG_DIR}/utils
    ${TOOLAHCIN_LOG_DIR}/syslog/common
    ${TOOLAHCIN_LOG_DIR}/syslog/common/pm
    ${TOOLAHCIN_LOG_DIR}/syslog/common/config
    ${TOOLAHCIN_LOG_DIR}/syslog/common/driver
    ${TOOLAHCIN_LOG_DIR}/syslog/log_daemon
    ${TOOLAHCIN_LOG_DIR}/syslog/log_daemon/file_dump
    ${TOOLAHCIN_LOG_DIR}/syslog/log_daemon/sys_monitor
    ${TOOLAHCIN_LOG_DIR}/syslog/log_daemon/stackcore
    ${TOOLAHCIN_LOG_DIR}/syslog/log_daemon/event_process
    ${TOOLAHCIN_LOG_DIR}/syslog/log_daemon/file_monitor
    ${RUNTIME_DIR}/src/dfx/adump
    ${RUNTIME_DIR}/src/dfx/adump/external
)

###################################################################
if (PRODUCT)
if ((${PRODUCT} STREQUAL "ascend610") OR (${PRODUCT} STREQUAL "ascend610Lite") OR (${PRODUCT} STREQUAL "ascend610Liteesl") OR (${PRODUCT} STREQUAL "as31xm1") OR (${PRODUCT} STREQUAL "mc32dm11a") OR (${PRODUCT} STREQUAL "mc32dm11aesl") OR (${PRODUCT} STREQUAL "ascend310Brc") OR (${PRODUCT} STREQUAL "ascend310Brcesl") OR ${PRODUCT} STREQUAL "helper310p")
    set(logDaemonSrcFiles ${logDaemonRcSrcFiles})
    set(logDaemonHeaderDir ${logDaemonRcHeaderDir})
endif ()
if ((${PRODUCT} STREQUAL "ascend610") OR (${PRODUCT} STREQUAL "ascend610Lite") OR (${PRODUCT} STREQUAL "ascend610Liteesl") OR (${PRODUCT} STREQUAL "as31xm1") OR (${PRODUCT} STREQUAL "mc32dm11a") OR (${PRODUCT} STREQUAL "mc32dm11aesl") OR (${PRODUCT} STREQUAL "ascend310p") OR (${PRODUCT} STREQUAL "ascend310B") OR (${PRODUCT} STREQUAL "ascend310Besl") OR (${PRODUCT} STREQUAL "ascend310Brc") OR (${PRODUCT} STREQUAL "ascend310Brcesl") OR ${PRODUCT} STREQUAL "ascend910" OR ${PRODUCT} STREQUAL "ascend910B" OR ${PRODUCT} STREQUAL "ascend950" OR ${PRODUCT} STREQUAL "ascend950esl" OR ${PRODUCT} STREQUAL "ascend350" OR (${PRODUCT} STREQUAL "ascend910_96") OR (${PRODUCT} STREQUAL "ascend910_96esl") OR (${PRODUCT} STREQUAL "helper310p") OR (${PRODUCT} STREQUAL "mc62cm12a") OR (${PRODUCT} STREQUAL "mc62cm12aesl"))
    list(APPEND logDaemonHeaderDir
        ${IAM_HEADER_DIR}/include
        ${MDC_LINUX_SDK_DIR}/include)
endif ()
endif ()

add_executable(logDaemon
    ${logDaemonSrcFiles})

target_include_directories(logDaemon PRIVATE
    ${logDaemonHeaderDir})

target_compile_definitions(logDaemon PRIVATE
    $<$<STREQUAL:${PRODUCT},ascend310rc>:RC_MODE>
    $<$<STREQUAL:${PRODUCT},ascend310Brc>:RC_MODE IAM_MONITOR LINUX_ETC_CONF LOG_COREDUMP>
    $<$<STREQUAL:${PRODUCT},ascend310Brcesl>:RC_MODE IAM_MONITOR LINUX_ETC_CONF LOG_COREDUMP>
    $<$<STREQUAL:${PRODUCT},ascend310>:EP_MODE SCRIPT_MONITOR LOG_COREDUMP>
    $<$<STREQUAL:${PRODUCT},ascend310B>:EP_MODE IAM_MONITOR LINUX_ETC_CONF LOG_COREDUMP>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:EP_MODE IAM_MONITOR LINUX_ETC_CONF LOG_COREDUMP>
    $<$<STREQUAL:${PRODUCT},ascend310p>:EP_MODE IAM_MONITOR LOG_COREDUMP>
    $<$<STREQUAL:${PRODUCT},helper310p>:IAM_MONITOR RC_MODE LINUX_ETC_CONF LOG_COREDUMP>
    $<$<STREQUAL:${PRODUCT},ascend610>:IAM IAM_MONITOR RC_MODE LINUX_ETC_CONF>
    $<$<STREQUAL:${PRODUCT},ascend610Lite>:IAM IAM_MONITOR RC_MODE LINUX_ETC_CONF>
    $<$<STREQUAL:${PRODUCT},ascend610Liteesl>:IAM IAM_MONITOR RC_MODE LINUX_ETC_CONF>
    $<$<STREQUAL:${PRODUCT},mc62cm12a>:IAM IAM_MONITOR RC_MODE LINUX_ETC_CONF>
    $<$<STREQUAL:${PRODUCT},mc62cm12aesl>:IAM IAM_MONITOR RC_MODE LINUX_ETC_CONF>
    $<$<STREQUAL:${PRODUCT},mc32dm11a>:IAM IAM_MONITOR RC_MODE LINUX_ETC_CONF>
    $<$<STREQUAL:${PRODUCT},mc32dm11aesl>:IAM IAM_MONITOR RC_MODE LINUX_ETC_CONF>
    $<$<STREQUAL:${PRODUCT},as31xm1>:IAM IAM_MONITOR RC_MODE LINUX_ETC_CONF>
    $<$<STREQUAL:${PRODUCT},ascend910>:IAM_MONITOR EP_MODE LOG_COREDUMP>
    $<$<STREQUAL:${PRODUCT},ascend910B>:IAM_MONITOR EP_MODE LOG_COREDUMP>
    $<$<AND:$<STREQUAL:${PRODUCT},ascend950>,$<NOT:$<BOOL:${ENABLE_RC}>>>:IAM_MONITOR EP_MODE LOG_COREDUMP LOG_CORETRACE>
    $<$<AND:$<STREQUAL:${PRODUCT},ascend950>,$<BOOL:${ENABLE_RC}>>:IAM_MONITOR RC_MODE LOG_COREDUMP LOG_CORETRACE>
    $<$<STREQUAL:${PRODUCT},ascend950esl>:IAM_MONITOR EP_MODE LOG_COREDUMP LOG_CORETRACE>
    $<$<AND:$<STREQUAL:${PRODUCT},ascend350>,$<NOT:$<BOOL:${ENABLE_RC}>>>:IAM_MONITOR EP_MODE LOG_COREDUMP LOG_CORETRACE>
    $<$<AND:$<STREQUAL:${PRODUCT},ascend350>,$<BOOL:${ENABLE_RC}>>:IAM_MONITOR RC_MODE LOG_COREDUMP LOG_CORETRACE>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:IAM_MONITOR EP_MODE LOG_COREDUMP LOG_CORETRACE>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:IAM_MONITOR EP_MODE LOG_COREDUMP LOG_CORETRACE>
    OS_TYPE_DEF=0
    IDE_DAEMON_HOST
)

target_compile_options(logDaemon PRIVATE
    -Wfloat-equal -Wextra
    $<$<CONFIG:Debug>:-g -O0>
    $<$<CONFIG:Release>:-Os -D_FORTIFY_SOURCE=2>
    -Wunused
    -Wshadow
    -Wundef
    -Werror
    -fPIE
    -fstack-protector-strong
    -fno-common
    -fsigned-char
    -fno-strict-aliasing
    -fvisibility=hidden
    -fdata-sections
    -ffunction-sections
    -std=gnu11
)

target_link_options(logDaemon PRIVATE
    $<$<STREQUAL:${PRODUCT},ascend310p>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310B>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310Brc>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310Brcesl>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},helper310p>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend910>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend910B>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend950>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend950esl>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend350>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,--gc-sections
)

target_link_directories(logDaemon PRIVATE
    $<$<STREQUAL:${PRODUCT},ascend610>:${MDC_LINUX_SDK_DIR}/lib64>
    $<$<STREQUAL:${PRODUCT},ascend610>:${MDC_LINUX_SDK_DIR}/lib64/mdc/base-plat>
    $<$<STREQUAL:${PRODUCT},ascend610Lite>:${MDC_LINUX_SDK_DIR}/lib64>
    $<$<STREQUAL:${PRODUCT},ascend610Lite>:${MDC_LINUX_SDK_DIR}/lib64/mdc/base-plat>
    $<$<STREQUAL:${PRODUCT},ascend610Liteesl>:${MDC_LINUX_SDK_DIR}/lib64>
    $<$<STREQUAL:${PRODUCT},ascend610Liteesl>:${MDC_LINUX_SDK_DIR}/lib64/mdc/base-plat>
    $<$<STREQUAL:${PRODUCT},mc62cm12a>:${MDC_LINUX_SDK_DIR}/lib64>
    $<$<STREQUAL:${PRODUCT},mc62cm12a>:${MDC_LINUX_SDK_DIR}/lib64/mdc/base-plat>
    $<$<STREQUAL:${PRODUCT},mc62cm12aesl>:${MDC_LINUX_SDK_DIR}/lib64>
    $<$<STREQUAL:${PRODUCT},mc62cm12aesl>:${MDC_LINUX_SDK_DIR}/lib64/mdc/base-plat>
    $<$<STREQUAL:${PRODUCT},mc32dm11a>:${MDC_LINUX_SDK_DIR}/lib64>
    $<$<STREQUAL:${PRODUCT},mc32dm11aesl>:${MDC_LINUX_SDK_DIR}/lib64/mdc/base-plat>
    $<$<STREQUAL:${PRODUCT},as31xm1>:${MDC_LINUX_SDK_DIR}/lib64>
    $<$<STREQUAL:${PRODUCT},as31xm1>:${MDC_LINUX_SDK_DIR}/lib64/mdc/base-plat>
    $<$<STREQUAL:${PRODUCT},ascend310p>:${MDC_LINUX_SDK_DIR}/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310B>:${MDC_LINUX_SDK_DIR}/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310Brc>:${MDC_LINUX_SDK_DIR}/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:${MDC_LINUX_SDK_DIR}/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310Brcesl>:${MDC_LINUX_SDK_DIR}/lib64>
    $<$<STREQUAL:${PRODUCT},helper310p>:${MDC_LINUX_SDK_DIR}/lib64>
    $<$<STREQUAL:${PRODUCT},ascend910B>:${MDC_LINUX_SDK_DIR}/lib64>
    $<$<STREQUAL:${PRODUCT},ascend910>:${MDC_LINUX_SDK_DIR}/lib64/mdc/base-plat>
    $<$<STREQUAL:${PRODUCT},ascend950>:${CMAKE_INSTALL_PREFIX}/lib>
    $<$<STREQUAL:${PRODUCT},ascend950esl>:${CMAKE_INSTALL_PREFIX}/lib>
    $<$<STREQUAL:${PRODUCT},ascend350>:${CMAKE_INSTALL_PREFIX}/lib>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:${CMAKE_INSTALL_PREFIX}/lib>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:${CMAKE_INSTALL_PREFIX}/lib>
)

if (PRODUCT)
target_link_libraries(logDaemon PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adcore_headers>
    $<BUILD_INTERFACE:intf_pub_optimization>
    $<$<STREQUAL:${PRODUCT},ascend910>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend910>:iam>
    $<$<STREQUAL:${PRODUCT},ascend910>:file_dump>
    $<$<STREQUAL:${PRODUCT},ascend910>:sys_monitor>
    $<$<STREQUAL:${PRODUCT},ascend910>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend910B>:iam>
    $<$<STREQUAL:${PRODUCT},ascend910B>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend910B>:file_dump>
    $<$<STREQUAL:${PRODUCT},ascend910B>:sys_monitor>
    $<$<STREQUAL:${PRODUCT},ascend910B>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend950>:iam>
    $<$<STREQUAL:${PRODUCT},ascend950>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend950>:file_dump>
    $<$<STREQUAL:${PRODUCT},ascend950>:sys_monitor>
    $<$<STREQUAL:${PRODUCT},ascend950>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend950>:urma>
    $<$<STREQUAL:${PRODUCT},ascend950>:urma_common>
    $<$<STREQUAL:${PRODUCT},ascend950esl>:iam>
    $<$<STREQUAL:${PRODUCT},ascend950esl>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend950esl>:file_dump>
    $<$<STREQUAL:${PRODUCT},ascend950esl>:sys_monitor>
    $<$<STREQUAL:${PRODUCT},ascend950esl>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend950esl>:urma>
    $<$<STREQUAL:${PRODUCT},ascend950esl>:urma_common>
    $<$<STREQUAL:${PRODUCT},ascend350>:iam>
    $<$<STREQUAL:${PRODUCT},ascend350>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend350>:file_dump>
    $<$<STREQUAL:${PRODUCT},ascend350>:sys_monitor>
    $<$<STREQUAL:${PRODUCT},ascend350>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend350>:urma>
    $<$<STREQUAL:${PRODUCT},ascend350>:urma_common>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:iam>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:file_dump>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:sys_monitor>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:urma>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:urma_common>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:iam>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:file_dump>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:sys_monitor>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:urma>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:urma_common>
    $<$<STREQUAL:${PRODUCT},ascend310>:ascend_monitor>
    $<$<STREQUAL:${PRODUCT},ascend310>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend310>:file_dump>
    $<$<STREQUAL:${PRODUCT},ascend310>:sys_monitor>
    $<$<STREQUAL:${PRODUCT},ascend310>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend310B>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend310B>:iam>
    $<$<STREQUAL:${PRODUCT},ascend310B>:file_dump>
    $<$<STREQUAL:${PRODUCT},ascend310B>:sys_monitor>
    $<$<STREQUAL:${PRODUCT},ascend310B>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:iam>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:file_dump>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:sys_monitor>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend310Brc>:iam>
    $<$<STREQUAL:${PRODUCT},ascend310Brc>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend310Brcesl>:iam>
    $<$<STREQUAL:${PRODUCT},ascend310Brcesl>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend310p>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend310p>:iam>
    $<$<STREQUAL:${PRODUCT},ascend310p>:file_dump>
    $<$<STREQUAL:${PRODUCT},ascend310p>:sys_monitor>
    $<$<STREQUAL:${PRODUCT},ascend310p>:stackcore>
    $<$<STREQUAL:${PRODUCT},helper310p>:iam>
    $<$<STREQUAL:${PRODUCT},helper310p>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},helper310p>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend610>:iam>
    $<$<STREQUAL:${PRODUCT},ascend610>:-lrt>
    $<$<STREQUAL:${PRODUCT},ascend610>:easy_comm>
    $<$<STREQUAL:${PRODUCT},ascend610>:wd>
    $<$<STREQUAL:${PRODUCT},ascend610>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend610Lite>:iam>
    $<$<STREQUAL:${PRODUCT},ascend610Lite>:-lrt>
    $<$<STREQUAL:${PRODUCT},ascend610Lite>:easy_comm>
    $<$<STREQUAL:${PRODUCT},ascend610Lite>:wd>
    $<$<STREQUAL:${PRODUCT},ascend610Lite>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend610Liteesl>:iam>
    $<$<STREQUAL:${PRODUCT},ascend610Liteesl>:-lrt>
    $<$<STREQUAL:${PRODUCT},ascend610Liteesl>:easy_comm>
    $<$<STREQUAL:${PRODUCT},ascend610Liteesl>:wd>
    $<$<STREQUAL:${PRODUCT},ascend610Liteesl>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},mc62cm12a>:iam>
    $<$<STREQUAL:${PRODUCT},mc62cm12a>:-lrt>
    $<$<STREQUAL:${PRODUCT},mc62cm12a>:easy_comm>
    $<$<STREQUAL:${PRODUCT},mc62cm12a>:wd>
    $<$<STREQUAL:${PRODUCT},mc62cm12a>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},mc62cm12aesl>:iam>
    $<$<STREQUAL:${PRODUCT},mc62cm12aesl>:-lrt>
    $<$<STREQUAL:${PRODUCT},mc62cm12aesl>:easy_comm>
    $<$<STREQUAL:${PRODUCT},mc62cm12aesl>:wd>
    $<$<STREQUAL:${PRODUCT},mc62cm12aesl>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},as31xm1>:iam>
    $<$<STREQUAL:${PRODUCT},as31xm1>:-lrt>
    $<$<STREQUAL:${PRODUCT},as31xm1>:easy_comm>
    $<$<STREQUAL:${PRODUCT},as31xm1>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},mc32dm11a>:iam>
    $<$<STREQUAL:${PRODUCT},mc32dm11a>:-lrt>
    $<$<STREQUAL:${PRODUCT},mc32dm11a>:easy_comm>
    $<$<STREQUAL:${PRODUCT},mc32dm11a>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},mc32dm11aesl>:iam>
    $<$<STREQUAL:${PRODUCT},mc32dm11aesl>:-lrt>
    $<$<STREQUAL:${PRODUCT},mc32dm11aesl>:easy_comm>
    $<$<STREQUAL:${PRODUCT},mc32dm11aesl>:ascend_hal>
    c_sec
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:mmpa>
    lib_load
)
endif ()

set_target_properties(logDaemon
    PROPERTIES
    OUTPUT_NAME log-daemon
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

###################################################################
if (PRODUCT)
if (${PRODUCT} STREQUAL "ascend310")
add_custom_target(logdaemonDeviceFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../scripts/log_daemon_monitor.sh ${CMAKE_CURRENT_BINARY_DIR}
)
elseif ((${PRODUCT} STREQUAL "ascend610") OR (${PRODUCT} STREQUAL "ascend610Lite") OR (${PRODUCT} STREQUAL "ascend610Liteesl"))
add_custom_target(logdaemonDeviceFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../slog/etc/mdc/log-daemon.yaml ${CMAKE_CURRENT_BINARY_DIR}
)
elseif (${PRODUCT} STREQUAL "as31xm1")
add_custom_target(logdaemonDeviceFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../slog/etc/mdc_310/log-daemon.yaml ${CMAKE_CURRENT_BINARY_DIR}
)
elseif ((${PRODUCT} STREQUAL "ascend310p") OR (${PRODUCT} STREQUAL "ascend910"))
add_custom_target(logdaemonDeviceFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../slog/etc/dc/log-daemon.yaml ${CMAKE_CURRENT_BINARY_DIR}
)
elseif (${PRODUCT} STREQUAL "ascend910B")
add_custom_target(logdaemonDeviceFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../slog/etc/milan_910/log-daemon.yaml ${CMAKE_CURRENT_BINARY_DIR}
)
elseif ((${PRODUCT} STREQUAL "ascend950") OR (${PRODUCT} STREQUAL "ascend950esl") OR (${PRODUCT} STREQUAL "ascend350") OR (${PRODUCT} STREQUAL "ascend910_96") OR (${PRODUCT} STREQUAL "ascend910_96esl"))
add_custom_target(logdaemonDeviceFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../slog/etc/david_910_95/log-daemon.yaml ${CMAKE_CURRENT_BINARY_DIR}
)
elseif ((${PRODUCT} STREQUAL "ascend310B") OR (${PRODUCT} STREQUAL "ascend310Besl"))
add_custom_target(logdaemonDeviceFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../slog/etc/milan_310/log-daemon.yaml ${CMAKE_CURRENT_BINARY_DIR}
)
elseif ((${PRODUCT} STREQUAL "ascend310Brc") OR (${PRODUCT} STREQUAL "ascend310Brcesl"))
add_custom_target(logdaemonDeviceFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../slog/etc/milan_310rc/log-daemon.yaml ${CMAKE_CURRENT_BINARY_DIR}
)
elseif (${PRODUCT} STREQUAL "helper310p")
add_custom_target(logdaemonDeviceFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../slog/etc/helper_310p/log-daemon.yaml ${CMAKE_CURRENT_BINARY_DIR}
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

if (PRODUCT)
if (${PRODUCT} STREQUAL "ascend310")
install(TARGETS logDaemon
    RUNTIME DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)
install(PROGRAMS
    ${CMAKE_CURRENT_BINARY_DIR}/log_daemon_monitor.sh
    DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)
elseif ((${PRODUCT} STREQUAL "ascend310p") OR (${PRODUCT} STREQUAL "ascend310B") OR (${PRODUCT} STREQUAL "ascend310Besl") OR (${PRODUCT} STREQUAL "ascend310rc") OR (${PRODUCT} STREQUAL "ascend310Brc") OR (${PRODUCT} STREQUAL "ascend310Brcesl") OR (${PRODUCT} STREQUAL "ascend610") OR (${PRODUCT} STREQUAL "ascend610Lite") OR (${PRODUCT} STREQUAL "ascend610Liteesl") OR (${PRODUCT} STREQUAL "as31xm1") OR (${PRODUCT} STREQUAL "ascend910") OR (${PRODUCT} STREQUAL "ascend910B") OR (${PRODUCT} STREQUAL "ascend950") OR (${PRODUCT} STREQUAL "ascend950esl") OR (${PRODUCT} STREQUAL "ascend350") OR (${PRODUCT} STREQUAL "ascend910_96") OR (${PRODUCT} STREQUAL "ascend910_96esl") OR (${PRODUCT} STREQUAL "helper310p") OR (${PRODUCT} STREQUAL "mc62cm12a") OR (${PRODUCT} STREQUAL "mc62cm12aesl") OR (${PRODUCT} STREQUAL "mc32dm11a")  OR (${PRODUCT} STREQUAL "mc32dm11aesl"))
install(TARGETS logDaemon
    RUNTIME DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/log-daemon.yaml
    DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)
endif ()
endif ()
