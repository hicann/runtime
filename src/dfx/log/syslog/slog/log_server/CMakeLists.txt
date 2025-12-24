# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
if (${PRODUCT_SIDE} STREQUAL "device")
add_subdirectory(log_post_process/app_report)
add_subdirectory(log_post_process/sys_report)
###################################################################
set(slogdSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/../slogd_main.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../slogd_argv.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../trace_server/slogd_trace_server.c
    ${CMAKE_CURRENT_SOURCE_DIR}/slogd_service.c
    ${CMAKE_CURRENT_SOURCE_DIR}/slogd_dev_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/slogd_thread_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_pre_process/log_communication/slogd_communication.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_pre_process/log_communication/slogd_communication_socket.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_pre_process/slogd_recv_msg.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_pre_process/slogd_parse_msg.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_pre_process/slogd_recv_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/sys_log/slogd_syslog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/sys_log/slogd_kernel_log.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/app_log/slogd_applog_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/app_log/slogd_applog_flush.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/app_log/slogd_applog_report.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/app_log/slogd_appnum_watch.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/group_log/slogd_group_log.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/event_log/slogd_eventlog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/firmware_log/log_recv.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/firmware_log/log_recv_interface.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/firmware_log/slogd_firmware_log.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/buffer_mgr/slogd_buffer.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/file_mgr/slogd_compress.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/file_mgr/log_to_file.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/file_mgr/slogd_write_limit.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/level_mgr/operate_loglevel.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/level_mgr/slogd_dynamic_level.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/level_mgr/slogd_firmware_level.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/level_mgr/log_level_parse.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/level_mgr/slogd_shm_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/config_mgr/slogd_config_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_post_process/slogd_flush.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/log_path_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/log_print_selflog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/pm/log_pm.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/pm/log_monitor.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/pm/start_single_process.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/pm/log_pm_sr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/pm/log_pm_sig.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/config/log_config_list.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/config/log_config_block.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/config/log_config_common.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/config/log_config_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/config/log_config_group.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/msg_queue.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_queue.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/share_mem.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_system_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_common.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_compress/log_compress.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_time.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_print_syslog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_file_util.c
)

set(slogdHeaderDir
    ${CMAKE_CURRENT_SOURCE_DIR}/
    ${CMAKE_CURRENT_SOURCE_DIR}/log_pre_process
    ${CMAKE_CURRENT_SOURCE_DIR}/log_pre_process/log_communication
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/sys_log
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/app_log
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/event_log
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/firmware_log
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/group_log
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/config_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/level_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/buffer_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/file_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/log_post_process
    ${CMAKE_CURRENT_SOURCE_DIR}/log_post_process/app_report
    ${CMAKE_CURRENT_SOURCE_DIR}/log_post_process/msn_report
    ${CMAKE_CURRENT_SOURCE_DIR}/log_post_process/session_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/../trace_server
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/pm
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/config
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../inc/stackcore
    ${RUNTIME_DIR}/inc/driver
    ${RUNTIME_DIR}/abl/libc_sec/include
    ${RUNTIME_DIR}/abl/adump/external
    ${RUNTIME_DIR}/abl/atrace/inc/trace_server
    ${RUNTIME_DIR}/abl/atrace/inc/utrace
)

set(iamSlogdSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/../slogd_main.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../slogd_argv.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../trace_server/slogd_trace_server.c
    ${CMAKE_CURRENT_SOURCE_DIR}/slogd_service.c
    ${CMAKE_CURRENT_SOURCE_DIR}/slogd_dev_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/slogd_thread_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_pre_process/log_communication/slogd_communication.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_pre_process/log_communication/slogd_communication_iam.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_pre_process/cmd_process/slogd_collect_log.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_pre_process/slogd_recv_msg.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_pre_process/slogd_parse_msg.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_pre_process/slogd_recv_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/sys_log/slogd_syslog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/sys_log/slogd_kernel_log.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/app_log/slogd_applog_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/app_log/slogd_applog_flush.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/app_log/slogd_applog_report.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/app_log/slogd_appnum_watch.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/event_log/slogd_eventlog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/group_log/slogd_group_log.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/firmware_log/log_recv.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/firmware_log/log_recv_interface.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/firmware_log/slogd_firmware_log.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/buffer_mgr/slogd_buffer.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/file_mgr/slogd_compress.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/file_mgr/log_to_file.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/file_mgr/slogd_write_limit.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/level_mgr/operate_loglevel.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/level_mgr/slogd_dynamic_level.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/level_mgr/slogd_firmware_level.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/level_mgr/log_level_parse.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/level_mgr/slogd_shm_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/config_mgr/slogd_config_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/log_post_process/slogd_flush.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/log_path_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/log_print_selflog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/pm/log_pm.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/pm/log_monitor.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/pm/start_single_process.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/pm/log_pm_sr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/pm/log_pm_sig.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/config/log_config_list.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/config/log_config_block.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/config/log_config_common.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/config/log_config_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/config/log_config_group.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_system_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/msg_queue.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_queue.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/share_mem.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_common.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_buffer/log_ring_buffer.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_compress/log_compress.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_compress/log_software_zip.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_compress/log_hardware_zip.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_time.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_print_syslog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_file_util.c
)

set(iamSlogdIncFiles
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/log_pre_process
    ${CMAKE_CURRENT_SOURCE_DIR}/log_pre_process/log_communication
    ${CMAKE_CURRENT_SOURCE_DIR}/log_pre_process/cmd_process
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/sys_log
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/app_log
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/event_log
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/firmware_log
    ${CMAKE_CURRENT_SOURCE_DIR}/log_classify/group_log
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/level_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/file_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/config_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/log_mgr/buffer_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/log_post_process
    ${CMAKE_CURRENT_SOURCE_DIR}/log_post_process/session_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/../trace_server
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/pm
    ${CMAKE_CURRENT_SOURCE_DIR}/../../common/config
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_buffer
    ${RUNTIME_DIR}/abl/libc_sec/include
    ${RUNTIME_DIR}/kernel/vendor/nve/inlcude/linux/mtd
    ${RUNTIME_DIR}/inc/driver
    ${RUNTIME_DIR}/abl/adump/external
    ${MDC_LINUX_SDK_DIR}/include
    ${IAM_HEADER_DIR}/include
    ${RUNTIME_DIR}/manager/resmgr/secmgr/include/
)

if (PRODUCT)
if (${PRODUCT} STREQUAL "ascend310")
    list(APPEND slogdSrcFiles ${CMAKE_CURRENT_SOURCE_DIR}/../../common/driver/log_drv.c
                              ${CMAKE_CURRENT_SOURCE_DIR}/../../common/driver/driver_api.c
    )
    list(APPEND slogdHeaderDir ${CMAKE_CURRENT_SOURCE_DIR}/../../common/driver)
elseif ((${PRODUCT} STREQUAL "ascend610") OR (${PRODUCT} STREQUAL "ascend610Lite") OR (${PRODUCT} STREQUAL "ascend610Liteesl") OR (${PRODUCT} STREQUAL "as31xm1"))
    set(slogdSrcFiles ${iamSlogdSrcFiles})
    set(slogdHeaderDir ${iamSlogdIncFiles})
elseif ((${PRODUCT} STREQUAL "ascend310B") OR (${PRODUCT} STREQUAL "ascend310Besl") OR (${PRODUCT} STREQUAL "ascend310Brc") OR (${PRODUCT} STREQUAL "ascend310Brcesl") OR (${PRODUCT} STREQUAL "ascend910") OR (${PRODUCT} STREQUAL "ascend310p") OR(${PRODUCT} STREQUAL "ascend910B") OR(${PRODUCT} STREQUAL "ascend910_95") OR(${PRODUCT} STREQUAL "ascend910_95esl") OR(${PRODUCT} STREQUAL "ascend910_96") OR(${PRODUCT} STREQUAL "ascend910_96esl") OR (${PRODUCT} STREQUAL "helper310p"))
    list(APPEND slogdSrcFiles ${CMAKE_CURRENT_SOURCE_DIR}/../../common/driver/log_drv.c
                              ${CMAKE_CURRENT_SOURCE_DIR}/../../common/driver/driver_api.c
    )
    list(APPEND slogdHeaderDir ${CMAKE_CURRENT_SOURCE_DIR}/../../common/driver)
    list(APPEND slogdHeaderDir ${IAM_HEADER_DIR}/include)
endif ()
endif ()

add_executable(slogd
    ${slogdSrcFiles})

target_include_directories(slogd PRIVATE
    ${slogdHeaderDir})

target_compile_definitions(slogd PRIVATE
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:OS_TYPE_DEF=0>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:OS_TYPE_DEF=1>
    $<$<STREQUAL:${PRODUCT},ascend310>:SCRIPT_MONITOR APP_LOG_REPORT EP_MODE STATIC_BUFFER APP_LOG_PID_RECORD>
    $<$<STREQUAL:${PRODUCT},ascend310B>: APP_LOG_REPORT EP_MODE IAM_MONITOR LINUX_ETC_CONF STATIC_BUFFER DRV_EVENT_LOG APP_LOG_PID_RECORD>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>: APP_LOG_REPORT EP_MODE IAM_MONITOR LINUX_ETC_CONF STATIC_BUFFER DRV_EVENT_LOG APP_LOG_PID_RECORD>
    $<$<STREQUAL:${PRODUCT},ascend310rc>:APP_LOG_WATCH RC_MODE APP_LOG_PID_RECORD>
    $<$<STREQUAL:${PRODUCT},ascend310Brc>: APP_LOG_WATCH RC_MODE IAM_MONITOR LINUX_ETC_CONF DRV_EVENT_LOG APP_LOG_PID_RECORD>
    $<$<STREQUAL:${PRODUCT},ascend310Brcesl>: APP_LOG_WATCH RC_MODE IAM_MONITOR LINUX_ETC_CONF DRV_EVENT_LOG APP_LOG_PID_RECORD>
    $<$<STREQUAL:${PRODUCT},ascend910>: APP_LOG_REPORT EP_MODE IAM_MONITOR STATIC_BUFFER DRV_EVENT_LOG APP_LOG_PID_RECORD>
    $<$<STREQUAL:${PRODUCT},ascend910B>: APP_LOG_REPORT EP_MODE IAM_MONITOR STATIC_BUFFER DRIVER_STATIC_BUFFER DRV_EVENT_LOG APP_LOG_PID_RECORD>
    $<$<STREQUAL:${PRODUCT},ascend910_95>: APP_LOG_REPORT EP_MODE IAM_MONITOR APP_LOG_PID_RECORD KERNEL_LOG DRV_EVENT_LOG OS_SLOG>
    $<$<STREQUAL:${PRODUCT},ascend910_95esl>: APP_LOG_REPORT EP_MODE IAM_MONITOR APP_LOG_PID_RECORD KERNEL_LOG DRV_EVENT_LOG OS_SLOG>
    $<$<STREQUAL:${PRODUCT},ascend910_96>: APP_LOG_REPORT EP_MODE IAM_MONITOR APP_LOG_PID_RECORD KERNEL_LOG DRV_EVENT_LOG OS_SLOG>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>: APP_LOG_REPORT EP_MODE IAM_MONITOR APP_LOG_PID_RECORD KERNEL_LOG DRV_EVENT_LOG OS_SLOG>
    $<$<STREQUAL:${PRODUCT},ascend610>:HARDWARE_ZIP SR_MONITOR GETCLOCK_VIRTUAL APP_LOG_WATCH RC_MODE IAM LINUX_ETC_CONF GROUP_LOG IAM_MONITOR SLOGD_COLLECT>
    $<$<STREQUAL:${PRODUCT},ascend610Lite>:HARDWARE_ZIP SR_MONITOR GETCLOCK_VIRTUAL APP_LOG_WATCH RC_MODE IAM LINUX_ETC_CONF GROUP_LOG IAM_MONITOR SLOGD_COLLECT>
    $<$<STREQUAL:${PRODUCT},ascend610Liteesl>:HARDWARE_ZIP SR_MONITOR GETCLOCK_VIRTUAL APP_LOG_WATCH RC_MODE IAM LINUX_ETC_CONF GROUP_LOG IAM_MONITOR SLOGD_COLLECT>
    $<$<STREQUAL:${PRODUCT},as31xm1>:SOFTWARE_ZIP GETCLOCK_VIRTUAL APP_LOG_WATCH RC_MODE IAM LINUX_ETC_CONF GROUP_LOG IAM_MONITOR SLOGD_COLLECT>
    $<$<STREQUAL:${PRODUCT},ascend310p>: APP_LOG_REPORT EP_MODE IAM_MONITOR STATIC_BUFFER DRV_EVENT_LOG APP_LOG_PID_RECORD>
    $<$<STREQUAL:${PRODUCT},helper310p>:IAM_MONITOR APP_LOG_WATCH RC_MODE LINUX_ETC_CONF DRV_EVENT_LOG APP_LOG_PID_RECORD>
)

target_compile_options(slogd PRIVATE
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wfloat-equal -Wextra>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wunused>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wshadow>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wundef>
    $<$<CONFIG:Debug>:-g -O0>
    $<$<CONFIG:Release>:-Os -D_FORTIFY_SOURCE=2>
    -std=gnu11
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

target_link_options(slogd PRIVATE
    $<$<STREQUAL:${PRODUCT},ascend310p>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310B>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310Brc>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310Brcesl>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},helper310p>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend910>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend910B>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend910_95>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend910_95esl>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,--gc-sections
)

target_link_directories(slogd PRIVATE
    $<$<STREQUAL:${PRODUCT},ascend610>:${MDC_LINUX_SDK_DIR}/lib64>
    $<$<STREQUAL:${PRODUCT},ascend610>:${MDC_LINUX_SDK_DIR}/lib64/mdc/base-plat>
    $<$<STREQUAL:${PRODUCT},ascend610Lite>:${MDC_LINUX_SDK_DIR}/lib64>
    $<$<STREQUAL:${PRODUCT},ascend610Lite>:${MDC_LINUX_SDK_DIR}/lib64/mdc/base-plat>
    $<$<STREQUAL:${PRODUCT},ascend610Liteesl>:${MDC_LINUX_SDK_DIR}/lib64>
    $<$<STREQUAL:${PRODUCT},ascend610Liteesl>:${MDC_LINUX_SDK_DIR}/lib64/mdc/base-plat>
    $<$<STREQUAL:${PRODUCT},as31xm1>:${MDC_LINUX_SDK_DIR}/lib64>
    $<$<STREQUAL:${PRODUCT},as31xm1>:${MDC_LINUX_SDK_DIR}/lib64/mdc/base-plat>
    $<$<STREQUAL:${PRODUCT},ascend910_95>:${CMAKE_INSTALL_PREFIX}/lib>
    $<$<STREQUAL:${PRODUCT},ascend910_95esl>:${CMAKE_INSTALL_PREFIX}/lib>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:${CMAKE_INSTALL_PREFIX}/lib>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:${CMAKE_INSTALL_PREFIX}/lib>
)

target_link_libraries(slogd PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:intf_pub_optimization>
    $<$<STREQUAL:${PRODUCT},ascend910>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend910>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend910>:log_server>
    $<$<STREQUAL:${PRODUCT},ascend910>:msn_report>
    $<$<STREQUAL:${PRODUCT},ascend910>:iam>
    $<$<STREQUAL:${PRODUCT},ascend910>:utrace_server_share>
    $<$<STREQUAL:${PRODUCT},ascend910B>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend910B>:iam>
    $<$<STREQUAL:${PRODUCT},ascend910B>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend910B>:log_server>
    $<$<STREQUAL:${PRODUCT},ascend910B>:msn_report>
    $<$<STREQUAL:${PRODUCT},ascend910B>:utrace_server_share>
    $<$<STREQUAL:${PRODUCT},ascend910_95>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend910_95>:iam>
    $<$<STREQUAL:${PRODUCT},ascend910_95>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend910_95>:log_server>
    $<$<STREQUAL:${PRODUCT},ascend910_95>:urma>
    $<$<STREQUAL:${PRODUCT},ascend910_95>:urma_common>
    $<$<STREQUAL:${PRODUCT},ascend910_95>:utrace_server_share>
    $<$<STREQUAL:${PRODUCT},ascend910_95esl>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend910_95esl>:iam>
    $<$<STREQUAL:${PRODUCT},ascend910_95esl>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend910_95esl>:log_server>
    $<$<STREQUAL:${PRODUCT},ascend910_95esl>:urma>
    $<$<STREQUAL:${PRODUCT},ascend910_95esl>:urma_common>
    $<$<STREQUAL:${PRODUCT},ascend910_95esl>:utrace_server_share>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:iam>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:log_server>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:urma>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:urma_common>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:utrace_server_share>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:iam>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:log_server>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:urma>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:urma_common>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:utrace_server_share>
    $<$<STREQUAL:${PRODUCT},ascend310p>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend310p>:log_server>
    $<$<STREQUAL:${PRODUCT},ascend310p>:msn_report>
    $<$<STREQUAL:${PRODUCT},helper310p>:iam>
    $<$<STREQUAL:${PRODUCT},helper310p>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},helper310p>:stackcore>
    $<$<STREQUAL:${PRODUCT},helper310p>:log_server>
    $<$<STREQUAL:${PRODUCT},helper310p>:msn_report>
    $<$<STREQUAL:${PRODUCT},ascend310p>:iam>
    $<$<STREQUAL:${PRODUCT},ascend310p>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend310p>:utrace_server_share>
    $<$<STREQUAL:${PRODUCT},ascend610>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend610>:kms>
    $<$<STREQUAL:${PRODUCT},ascend610>:iam>
    $<$<STREQUAL:${PRODUCT},ascend610>:-lrt>
    $<$<STREQUAL:${PRODUCT},ascend610>:easy_comm>
    $<$<STREQUAL:${PRODUCT},ascend610Lite>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend610Lite>:kms>
    $<$<STREQUAL:${PRODUCT},ascend610Lite>:iam>
    $<$<STREQUAL:${PRODUCT},ascend610Lite>:-lrt>
    $<$<STREQUAL:${PRODUCT},ascend610Lite>:easy_comm>
    $<$<STREQUAL:${PRODUCT},ascend610Liteesl>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend610Liteesl>:kms>
    $<$<STREQUAL:${PRODUCT},ascend610Liteesl>:iam>
    $<$<STREQUAL:${PRODUCT},ascend610Liteesl>:-lrt>
    $<$<STREQUAL:${PRODUCT},ascend610Liteesl>:easy_comm>
    $<$<STREQUAL:${PRODUCT},as31xm1>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},as31xm1>:iam>
    $<$<STREQUAL:${PRODUCT},as31xm1>:-lrt>
    $<$<STREQUAL:${PRODUCT},as31xm1>:easy_comm>
    $<$<STREQUAL:${PRODUCT},as31xm1>:-lz>
    $<$<STREQUAL:${PRODUCT},ascend310>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend310>:ascend_monitor>
    $<$<STREQUAL:${PRODUCT},ascend310>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend310>:log_server>
    $<$<STREQUAL:${PRODUCT},ascend310>:msn_report>
    $<$<STREQUAL:${PRODUCT},ascend310>:utrace_server_share>
    $<$<STREQUAL:${PRODUCT},ascend310B>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend310B>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend310B>:log_server>
    $<$<STREQUAL:${PRODUCT},ascend310B>:msn_report>
    $<$<STREQUAL:${PRODUCT},ascend310B>:iam>
    $<$<STREQUAL:${PRODUCT},ascend310B>:utrace_server_share>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:log_server>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:msn_report>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:iam>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:utrace_server_share>
    $<$<STREQUAL:${PRODUCT},ascend310rc>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend310Brc>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend310Brc>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend310Brc>:iam>
    $<$<STREQUAL:${PRODUCT},ascend310Brcesl>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend310Brcesl>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend310Brcesl>:iam>
    c_sec
)

set_target_properties(slogd
    PROPERTIES
    OUTPUT_NAME slogd
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

###################################################################
if (PRODUCT)
if (${PRODUCT} STREQUAL "ascend310")
add_custom_target(slogDeviceFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/mini/slog.conf ${CMAKE_CURRENT_BINARY_DIR}
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../scripts/slogd_daemon_monitor.sh ${CMAKE_CURRENT_BINARY_DIR}
)
elseif (${PRODUCT} STREQUAL "ascend310B" OR ${PRODUCT} STREQUAL "ascend310Besl")
add_custom_target(slogDeviceFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/milan_310/slog.conf ${CMAKE_CURRENT_BINARY_DIR}
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/milan_310/log.yaml ${CMAKE_CURRENT_BINARY_DIR}
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/milan_310/slogd.yaml ${CMAKE_CURRENT_BINARY_DIR}
)
elseif (${PRODUCT} STREQUAL "ascend310Brc" OR ${PRODUCT} STREQUAL "ascend310Brcesl")
add_custom_target(slogDeviceFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/milan_310rc/slog.conf ${CMAKE_CURRENT_BINARY_DIR}
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/milan_310rc/log.yaml ${CMAKE_CURRENT_BINARY_DIR}
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/milan_310rc/slogd.yaml ${CMAKE_CURRENT_BINARY_DIR}
)
elseif (${PRODUCT} STREQUAL "ascend310rc")
add_custom_target(slogDeviceFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/mini_rc/slog.conf ${CMAKE_CURRENT_BINARY_DIR}
)
elseif (${PRODUCT} STREQUAL "ascend910")
add_custom_target(slogDeviceFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/cloud/slog.conf ${CMAKE_CURRENT_BINARY_DIR}/slog.conf
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/dc/log.yaml ${CMAKE_CURRENT_BINARY_DIR}
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/dc/slogd.yaml ${CMAKE_CURRENT_BINARY_DIR}
)
elseif (${PRODUCT} STREQUAL "ascend910B")
add_custom_target(slogDeviceFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/milan_910/slog.conf ${CMAKE_CURRENT_BINARY_DIR}/slog.conf
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/milan_910/log.yaml ${CMAKE_CURRENT_BINARY_DIR}
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/milan_910/slogd.yaml ${CMAKE_CURRENT_BINARY_DIR}
)
elseif ((${PRODUCT} STREQUAL "ascend910_95") OR (${PRODUCT} STREQUAL "ascend910_95esl") OR (${PRODUCT} STREQUAL "ascend910_96") OR (${PRODUCT} STREQUAL "ascend910_96esl"))
add_custom_target(slogDeviceFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/david_910_95/slog.conf ${CMAKE_CURRENT_BINARY_DIR}/slog.conf
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/david_910_95/log.yaml ${CMAKE_CURRENT_BINARY_DIR}
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/david_910_95/slogd.yaml ${CMAKE_CURRENT_BINARY_DIR}
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/david_910_95/rsyslog_proc.conf ${CMAKE_CURRENT_BINARY_DIR}/rsyslog_proc.conf
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/david_910_95/rsyslog_socket.conf ${CMAKE_CURRENT_BINARY_DIR}/rsyslog_socket.conf
)
elseif (${PRODUCT} STREQUAL "ascend310p")
add_custom_target(slogDeviceFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/dc/slog.conf ${CMAKE_CURRENT_BINARY_DIR}/slog.conf
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/dc/log.yaml ${CMAKE_CURRENT_BINARY_DIR}
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/dc/slogd.yaml ${CMAKE_CURRENT_BINARY_DIR}

)
elseif (${PRODUCT} STREQUAL "helper310p")
add_custom_target(slogDeviceFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/helper_310p/slog.conf ${CMAKE_CURRENT_BINARY_DIR}/slog.conf
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/helper_310p/log.yaml ${CMAKE_CURRENT_BINARY_DIR}
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/helper_310p/slogd.yaml ${CMAKE_CURRENT_BINARY_DIR}
)
elseif (${PRODUCT} STREQUAL "ascend610")
add_custom_target(slogDeviceFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/mdc/slog.conf ${CMAKE_CURRENT_BINARY_DIR}/slog.conf
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/mdc/log.yaml ${CMAKE_CURRENT_BINARY_DIR}
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/mdc/slogd.yaml ${CMAKE_CURRENT_BINARY_DIR}
)
elseif ((${PRODUCT} STREQUAL "ascend610Lite") OR (${PRODUCT} STREQUAL "ascend610Liteesl"))
add_custom_target(slogDeviceFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/mdc_610lite/slog.conf ${CMAKE_CURRENT_BINARY_DIR}/slog.conf
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/mdc/log.yaml ${CMAKE_CURRENT_BINARY_DIR}
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/mdc/slogd.yaml ${CMAKE_CURRENT_BINARY_DIR}
)
elseif (${PRODUCT} STREQUAL "as31xm1")
add_custom_target(slogDeviceFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/mdc_310/slog.conf ${CMAKE_CURRENT_BINARY_DIR}/slog.conf
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/mdc_310/log.yaml ${CMAKE_CURRENT_BINARY_DIR}
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/mdc_310/slogd.yaml ${CMAKE_CURRENT_BINARY_DIR}
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

install(TARGETS slogd
    RUNTIME DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)

if (PRODUCT)
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/slog.conf
    ${CMAKE_CURRENT_BINARY_DIR}/rsyslog_proc.conf
    ${CMAKE_CURRENT_BINARY_DIR}/rsyslog_socket.conf
    DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)

if (${PRODUCT} STREQUAL "ascend310")
install(PROGRAMS
    ${CMAKE_CURRENT_BINARY_DIR}/slogd_daemon_monitor.sh
    DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)
elseif ((${PRODUCT} STREQUAL "ascend610") OR (${PRODUCT} STREQUAL "ascend610Lite") OR (${PRODUCT} STREQUAL "ascend610Liteesl") OR (${PRODUCT} STREQUAL "as31xm1"))
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/log.yaml
    ${CMAKE_CURRENT_BINARY_DIR}/slogd.yaml
    DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)
elseif ((${PRODUCT} STREQUAL "ascend310p") OR (${PRODUCT} STREQUAL "ascend310B") OR (${PRODUCT} STREQUAL "ascend310Besl") OR (${PRODUCT} STREQUAL "ascend310Brc") OR (${PRODUCT} STREQUAL "ascend310Brcesl") OR (${PRODUCT} STREQUAL "ascend910") OR (${PRODUCT} STREQUAL "ascend910B") OR (${PRODUCT} STREQUAL "ascend910_95") OR (${PRODUCT} STREQUAL "ascend910_95esl") OR (${PRODUCT} STREQUAL "ascend910_96") OR (${PRODUCT} STREQUAL "ascend910_96esl") OR (${PRODUCT} STREQUAL "helper310p"))
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/log.yaml
    ${CMAKE_CURRENT_BINARY_DIR}/slogd.yaml
    DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)
endif ()
endif ()

elseif (${PRODUCT_SIDE} STREQUAL "host")

###################################################################
if (${TARGET_SYSTEM_NAME} STREQUAL "Windows")
add_custom_target(slogHostFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../winconf/slog.conf ${CMAKE_CURRENT_BINARY_DIR}
)
else()
if (PRODUCT)
if (${PRODUCT} STREQUAL "ascend310")
add_custom_target(slogHostFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/mini/slog.conf ${CMAKE_CURRENT_BINARY_DIR}
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../scripts/slogd_daemon_monitor.sh ${CMAKE_CURRENT_BINARY_DIR}
)
elseif ((${PRODUCT} STREQUAL "ascend310B") OR (${PRODUCT} STREQUAL "ascend310Besl"))
add_custom_target(slogHostFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/milan_310/slog.conf ${CMAKE_CURRENT_BINARY_DIR}
)
elseif ((${PRODUCT} STREQUAL "ascend310Brc") OR (${PRODUCT} STREQUAL "ascend310Brcesl"))
add_custom_target(slogHostFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/milan_310rc/slog.conf ${CMAKE_CURRENT_BINARY_DIR}
)
elseif (${PRODUCT} STREQUAL "ascend910" OR ${PRODUCT} STREQUAL "ascend910B")
add_custom_target(slogHostFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/cloud/slog.conf ${CMAKE_CURRENT_BINARY_DIR}
)
elseif ((${PRODUCT} STREQUAL "ascend910_95") OR (${PRODUCT} STREQUAL "ascend910_95esl") OR (${PRODUCT} STREQUAL "ascend910_96") OR (${PRODUCT} STREQUAL "ascend910_96esl"))
add_custom_target(slogHostFiles
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/david_910_95/slog.conf ${CMAKE_CURRENT_BINARY_DIR}
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/david_910_95/rsyslog_proc.conf ${CMAKE_CURRENT_BINARY_DIR}
     COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../etc/david_910_95/rsyslog_socket.conf ${CMAKE_CURRENT_BINARY_DIR}
)
endif ()
endif ()
endif ()


###################################################################
set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR lib/cmake)

include(CMakePackageConfigHelpers)

install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/slog.conf
    DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)

if (PRODUCT)
if (${PRODUCT} STREQUAL "ascend310")
install(PROGRAMS
    ${CMAKE_CURRENT_BINARY_DIR}/slogd_daemon_monitor.sh
    DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)
endif ()
endif ()

endif ()
