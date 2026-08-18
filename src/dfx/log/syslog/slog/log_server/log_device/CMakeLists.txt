# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
add_subdirectory(../log_post_process/app_report ${CMAKE_CURRENT_BINARY_DIR}/app_report)
add_subdirectory(../log_post_process/sys_report ${CMAKE_CURRENT_BINARY_DIR}/sys_report)

# ------------------------------------------------------------------------------
# Standard Device Source Files
# ------------------------------------------------------------------------------
set(slogdSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/../../slogd_main.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../slogd_argv.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../trace_server/slogd_trace_server.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../bbox_server/slogd_bbox_server.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../slogd_service.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../slogd_dev_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../slogd_thread_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_pre_process/log_communication/slogd_communication.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_pre_process/log_communication/slogd_communication_socket.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_pre_process/slogd_recv_msg.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_pre_process/slogd_parse_msg.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_pre_process/slogd_recv_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/sys_log/slogd_syslog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/sys_log/slogd_kernel_log.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/app_log/slogd_applog_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/app_log/slogd_applog_flush.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/app_log/slogd_applog_report.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/app_log/slogd_appnum_watch.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/group_log/slogd_group_log.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/event_log/slogd_eventlog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/firmware_log/log_recv.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/firmware_log/log_recv_interface.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/firmware_log/slogd_firmware_log.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_mgr/buffer_mgr/slogd_buffer.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_mgr/file_mgr/slogd_compress.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_mgr/file_mgr/log_to_file.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_mgr/file_mgr/slogd_write_limit.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_mgr/level_mgr/operate_loglevel.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_mgr/level_mgr/slogd_dynamic_level.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_mgr/level_mgr/slogd_firmware_level.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_mgr/level_mgr/log_level_parse.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_mgr/level_mgr/slogd_shm_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_mgr/config_mgr/slogd_config_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_post_process/slogd_flush.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/log_path_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/log_print_selflog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/pm/log_pm.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/pm/log_monitor.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/pm/start_single_process.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/pm/log_pm_sr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/pm/log_pm_sig.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/config/log_config_list.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/config/log_config_block.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/config/log_config_common.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/config/log_config_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/config/log_config_group.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/driver/log_drv.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/driver/driver_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils/msg_queue.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils/log_queue.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils/share_mem.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils/log_system_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils/log_common.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils/log_compress/log_compress.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils/log_time.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils/log_print_syslog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils/log_file_util.c
)

# ------------------------------------------------------------------------------
# Standard Device Include Directories
# ------------------------------------------------------------------------------
set(slogdHeaderDir
    ${CMAKE_CURRENT_SOURCE_DIR}/../
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_pre_process
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_pre_process/log_communication
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/sys_log
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/app_log
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/event_log
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/firmware_log
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/group_log
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_mgr/config_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_mgr/level_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_mgr/buffer_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_mgr/file_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_post_process
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_post_process/app_report
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_post_process/msn_report
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_post_process/session_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/../../trace_server
    ${CMAKE_CURRENT_SOURCE_DIR}/../../bbox_server
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../common
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/pm
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/config
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/driver
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../inc/stackcore
    ${LIBC_SEC_HEADER}
    ${RUNTIME_DIR}/pkg_inc/driver
    ${RUNTIME_DIR}/src/dfx/adump/external
    ${RUNTIME_DIR}/src/dfx/trace/inc/toolchain
)

# ------------------------------------------------------------------------------
# Selects appropriate source files and includes based on PRODUCT variable
# ------------------------------------------------------------------------------
# ascend310: Add driver source files only
if (PRODUCT)
if (${PRODUCT} STREQUAL "ascend310")
    list(APPEND slogdSrcFiles 
        ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/driver/log_drv.c
        ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/driver/driver_api.c
    )
    list(APPEND slogdHeaderDir ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/driver)

# A2/A3: Add driver source files and IAM headers
elseif ((${PRODUCT} STREQUAL "ascend310B") OR 
        (${PRODUCT} STREQUAL "ascend310Besl") OR 
        (${PRODUCT} STREQUAL "ascend310Brc") OR 
        (${PRODUCT} STREQUAL "ascend310Brcesl") OR 
        (${PRODUCT} STREQUAL "ascend910") OR 
        (${PRODUCT} STREQUAL "ascend310p") OR 
        (${PRODUCT} STREQUAL "ascend910B") OR 
        (${PRODUCT} STREQUAL "helper310p"))
    list(APPEND slogdSrcFiles 
        ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/driver/log_drv.c
        ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/driver/driver_api.c
    )
    list(APPEND slogdHeaderDir 
        ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/driver
        ${IAM_HEADER_DIR}/include
    )
endif ()
endif ()

### INTERNAL START ###
if (PRODUCT)
if ((${PRODUCT} STREQUAL "ascend950") OR 
        (${PRODUCT} STREQUAL "ascend950esl") OR 
        (${PRODUCT} STREQUAL "ascend350") OR 
        (${PRODUCT} STREQUAL "ascend910_96") OR 
        (${PRODUCT} STREQUAL "ascend910_96esl"))
    list(APPEND slogdSrcFiles 
        ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/driver/log_drv.c
        ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/driver/driver_api.c
    )
    list(APPEND slogdHeaderDir 
        ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/driver
        ${IAM_HEADER_DIR}/include
    )
endif ()
endif ()
### INTERNAL END ###

# ==============================================================================
# Target Definition
# ==============================================================================
add_executable(slogd ${slogdSrcFiles})

# ------------------------------------------------------------------------------
# Include Directories
# ------------------------------------------------------------------------------
target_include_directories(slogd PRIVATE ${slogdHeaderDir})

# ------------------------------------------------------------------------------
# Compile Definitions (Product-Specific Features)
# ------------------------------------------------------------------------------
target_compile_definitions(slogd PRIVATE
    # OS Type: 0=Linux/Unix, 1=Windows
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:OS_TYPE_DEF=0>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:OS_TYPE_DEF=1>
    # ascend310: Script monitoring, EP mode, static buffer
    $<$<STREQUAL:${PRODUCT},ascend310>:SCRIPT_MONITOR APP_LOG_REPORT EP_MODE STATIC_BUFFER APP_LOG_PID_RECORD>
    # ascend310B/Besl: EP mode with IAM monitoring, driver event log
    $<$<STREQUAL:${PRODUCT},ascend310B>:APP_LOG_REPORT EP_MODE IAM_MONITOR LINUX_ETC_CONF STATIC_BUFFER DRV_EVENT_LOG APP_LOG_PID_RECORD>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:APP_LOG_REPORT EP_MODE IAM_MONITOR LINUX_ETC_CONF STATIC_BUFFER DRV_EVENT_LOG APP_LOG_PID_RECORD>  
    # ascend310rc: RC mode (reduced functionality)
    $<$<STREQUAL:${PRODUCT},ascend310rc>:APP_LOG_WATCH RC_MODE APP_LOG_PID_RECORD>
    # ascend310Brc/Brcesl: RC mode with IAM monitoring
    $<$<STREQUAL:${PRODUCT},ascend310Brc>:APP_LOG_WATCH RC_MODE IAM_MONITOR LINUX_ETC_CONF DRV_EVENT_LOG APP_LOG_PID_RECORD>
    $<$<STREQUAL:${PRODUCT},ascend310Brcesl>:APP_LOG_WATCH RC_MODE IAM_MONITOR LINUX_ETC_CONF DRV_EVENT_LOG APP_LOG_PID_RECORD>
    # ascend910: EP mode with IAM monitoring
    $<$<STREQUAL:${PRODUCT},ascend910>:APP_LOG_REPORT EP_MODE IAM_MONITOR STATIC_BUFFER DRV_EVENT_LOG APP_LOG_PID_RECORD>  
    # ascend910B: Enhanced with driver static buffer
    $<$<STREQUAL:${PRODUCT},ascend910B>:APP_LOG_REPORT EP_MODE IAM_MONITOR STATIC_BUFFER DRIVER_STATIC_BUFFER DRV_EVENT_LOG APP_LOG_PID_RECORD>
    # ascend310p: EP mode with IAM monitoring
    $<$<STREQUAL:${PRODUCT},ascend310p>:APP_LOG_REPORT EP_MODE IAM_MONITOR STATIC_BUFFER DRV_EVENT_LOG APP_LOG_PID_RECORD>
    # helper310p: RC mode helper utility
    $<$<STREQUAL:${PRODUCT},helper310p>:IAM_MONITOR APP_LOG_WATCH RC_MODE LINUX_ETC_CONF DRV_EVENT_LOG APP_LOG_PID_RECORD>
)

### INTERNAL START ###
target_compile_definitions(slogd PRIVATE
    # OS Type: 0=Linux/Unix, 1=Windows
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:OS_TYPE_DEF=0>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:OS_TYPE_DEF=1>
    # ascend950/95esl: With kernel log and OS slog support
    $<$<AND:$<STREQUAL:${PRODUCT},ascend950>,$<NOT:$<BOOL:${ENABLE_RC}>>>:APP_LOG_REPORT EP_MODE IAM_MONITOR APP_LOG_PID_RECORD KERNEL_LOG DRV_EVENT_LOG OS_SLOG STATIC_BUFFER>
    $<$<STREQUAL:${PRODUCT},ascend950esl>:APP_LOG_REPORT EP_MODE IAM_MONITOR APP_LOG_PID_RECORD KERNEL_LOG DRV_EVENT_LOG OS_SLOG STATIC_BUFFER>
    # ascend950rc: Similar to 95 but without static buffer
    $<$<AND:$<STREQUAL:${PRODUCT},ascend950>,$<STREQUAL:${ENABLE_RC},true>>:APP_LOG_REPORT RC_MODE IAM_MONITOR APP_LOG_PID_RECORD KERNEL_LOG DRV_EVENT_LOG OS_SLOG>
    # ascend910_96/96esl: Similar to 95 but without static buffer
    $<$<STREQUAL:${PRODUCT},ascend910_96>:APP_LOG_REPORT EP_MODE IAM_MONITOR APP_LOG_PID_RECORD KERNEL_LOG DRV_EVENT_LOG OS_SLOG>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:APP_LOG_REPORT EP_MODE IAM_MONITOR APP_LOG_PID_RECORD KERNEL_LOG DRV_EVENT_LOG OS_SLOG>
    # ascend350: With kernel log and OS slog support
    $<$<AND:$<STREQUAL:${PRODUCT},ascend350>,$<NOT:$<BOOL:${ENABLE_RC}>>>:APP_LOG_REPORT EP_MODE IAM_MONITOR APP_LOG_PID_RECORD KERNEL_LOG DRV_EVENT_LOG OS_SLOG STATIC_BUFFER>
)
### INTERNAL END ###

# ------------------------------------------------------------------------------
# Compile Options (Warning flags, optimization, security hardening)
# ------------------------------------------------------------------------------
target_compile_options(slogd PRIVATE
    # Additional warnings for non-Windows platforms
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wfloat-equal -Wextra>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wunused>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wshadow>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wundef>
    
    # Build-type specific flags
    $<$<CONFIG:Debug>:-g -O0>                        # Debug: symbols, no optimization
    $<$<CONFIG:Release>:-Os -D_FORTIFY_SOURCE=2>     # Release: size optimization, buffer overflow protection
    
    # Standard and error handling
    -std=gnu11                                        # C11 with GNU extensions
    -Werror                                           # Treat warnings as errors
    
    # Security hardening flags
    -fPIE                                            # Position Independent Executable
    -fstack-protector-strong                         # Stack buffer overflow protection
    -fno-common                                      # Prevent common symbol allocation
    -fsigned-char                                    # Use signed char by default
    -fno-strict-aliasing                             # Avoid strict aliasing optimizations
    -fvisibility=hidden                              # Hide symbols by default
    
    # Dead code elimination support
    -fdata-sections                                  # Separate data sections
    -ffunction-sections                              # Separate function sections
)

# ------------------------------------------------------------------------------
# Link Options (Security flags and library paths)
# ------------------------------------------------------------------------------
target_link_options(slogd PRIVATE
    # Runtime library search path for products using extend_rootfs
    $<$<STREQUAL:${PRODUCT},ascend310p>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310B>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310Brc>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend310Brcesl>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},helper310p>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend910>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend910B>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    # Security hardening linker flags
    -Wl,-z,relro,-z,now,-z,noexecstack              # RELRO, immediate binding, no exec stack
    -Wl,--gc-sections                                # Remove unused sections
)

### INTERNAL START ###
target_link_options(slogd PRIVATE
    # Runtime library search path for products using extend_rootfs
    $<$<STREQUAL:${PRODUCT},ascend950>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend950esl>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend350>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:-Wl,-rpath-link,${CMAKE_BINARY_DIR}/extend_rootfs/lib64>
    # Security hardening linker flags
    -Wl,-z,relro,-z,now,-z,noexecstack              # RELRO, immediate binding, no exec stack
    -Wl,--gc-sections                                # Remove unused sections
)
### INTERNAL END ###

### INTERNAL START ###
# ------------------------------------------------------------------------------
# Link Directories
# ------------------------------------------------------------------------------
target_link_directories(slogd PRIVATE
    $<$<STREQUAL:${PRODUCT},ascend950>:${CMAKE_INSTALL_PREFIX}/lib>
    $<$<STREQUAL:${PRODUCT},ascend950esl>:${CMAKE_INSTALL_PREFIX}/lib>
    $<$<STREQUAL:${PRODUCT},ascend350>:${CMAKE_INSTALL_PREFIX}/lib>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:${CMAKE_INSTALL_PREFIX}/lib>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:${CMAKE_INSTALL_PREFIX}/lib>
)
### INTERNAL END ###

# ------------------------------------------------------------------------------
# Link Libraries (Product-specific dependencies)
# ------------------------------------------------------------------------------
target_link_libraries(slogd PRIVATE
    # Common interface libraries (build-time only)
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:intf_pub_optimization>
    
    # ascend910 libraries
    $<$<STREQUAL:${PRODUCT},ascend910>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend910>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend910>:log_server>
    $<$<STREQUAL:${PRODUCT},ascend910>:msn_report>
    $<$<STREQUAL:${PRODUCT},ascend910>:iam>
    $<$<STREQUAL:${PRODUCT},ascend910>:utrace_server_share>
    
    # ascend910B libraries
    $<$<STREQUAL:${PRODUCT},ascend910B>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend910B>:iam>
    $<$<STREQUAL:${PRODUCT},ascend910B>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend910B>:log_server>
    $<$<STREQUAL:${PRODUCT},ascend910B>:msn_report>
    $<$<STREQUAL:${PRODUCT},ascend910B>:utrace_server_share>
    
    # ascend310p libraries
    $<$<STREQUAL:${PRODUCT},ascend310p>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend310p>:log_server>
    $<$<STREQUAL:${PRODUCT},ascend310p>:msn_report>
    $<$<STREQUAL:${PRODUCT},ascend310p>:iam>
    $<$<STREQUAL:${PRODUCT},ascend310p>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend310p>:utrace_server_share>
    
    # helper310p libraries
    $<$<STREQUAL:${PRODUCT},helper310p>:iam>
    $<$<STREQUAL:${PRODUCT},helper310p>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},helper310p>:stackcore>
    $<$<STREQUAL:${PRODUCT},helper310p>:log_server>
    $<$<STREQUAL:${PRODUCT},helper310p>:msn_report>
    
    # ascend310 libraries (with monitor)
    $<$<STREQUAL:${PRODUCT},ascend310>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend310>:ascend_monitor>
    $<$<STREQUAL:${PRODUCT},ascend310>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend310>:log_server>
    $<$<STREQUAL:${PRODUCT},ascend310>:msn_report>
    $<$<STREQUAL:${PRODUCT},ascend310>:utrace_server_share>
    
    # ascend310B libraries
    $<$<STREQUAL:${PRODUCT},ascend310B>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend310B>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend310B>:log_server>
    $<$<STREQUAL:${PRODUCT},ascend310B>:msn_report>
    $<$<STREQUAL:${PRODUCT},ascend310B>:iam>
    $<$<STREQUAL:${PRODUCT},ascend310B>:utrace_server_share>
    
    # ascend310Besl libraries
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:log_server>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:msn_report>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:iam>
    $<$<STREQUAL:${PRODUCT},ascend310Besl>:utrace_server_share>
    
    # ascend310rc (reduced configuration)
    $<$<STREQUAL:${PRODUCT},ascend310rc>:ascend_hal>
    
    # ascend310Brc (reduced configuration with IAM)
    $<$<STREQUAL:${PRODUCT},ascend310Brc>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend310Brc>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend310Brc>:iam>
    
    # ascend310Brcesl (reduced configuration with IAM)
    $<$<STREQUAL:${PRODUCT},ascend310Brcesl>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend310Brcesl>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend310Brcesl>:iam>

    bbox_proc
    # Common security library (required for all products)
    c_sec
)

### INTERNAL START ###
# A5 products: Use URMA-specific link libraries
target_link_libraries(slogd PRIVATE
    # Common interface libraries (build-time only)
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:intf_pub_optimization>
    
    # ascend950 libraries (includes URMA)
    $<$<STREQUAL:${PRODUCT},ascend950>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend950>:iam>
    $<$<STREQUAL:${PRODUCT},ascend950>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend950>:log_server>
    $<$<STREQUAL:${PRODUCT},ascend950>:urma>
    $<$<STREQUAL:${PRODUCT},ascend950>:urma_common>
    $<$<STREQUAL:${PRODUCT},ascend950>:utrace_server_share>
    
    # ascend950esl libraries (includes URMA)
    $<$<STREQUAL:${PRODUCT},ascend950esl>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend950esl>:iam>
    $<$<STREQUAL:${PRODUCT},ascend950esl>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend950esl>:log_server>
    $<$<STREQUAL:${PRODUCT},ascend950esl>:urma>
    $<$<STREQUAL:${PRODUCT},ascend950esl>:urma_common>
    $<$<STREQUAL:${PRODUCT},ascend950esl>:utrace_server_share>

    # ascend350 libraries (includes URMA)
    $<$<STREQUAL:${PRODUCT},ascend350>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend350>:iam>
    $<$<STREQUAL:${PRODUCT},ascend350>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend350>:log_server>
    $<$<STREQUAL:${PRODUCT},ascend350>:urma>
    $<$<STREQUAL:${PRODUCT},ascend350>:urma_common>
    $<$<STREQUAL:${PRODUCT},ascend350>:utrace_server_share>
    
    # ascend910_96 libraries (includes URMA)
    $<$<STREQUAL:${PRODUCT},ascend910_96>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:iam>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:log_server>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:urma>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:urma_common>
    $<$<STREQUAL:${PRODUCT},ascend910_96>:utrace_server_share>
    
    # ascend910_96esl libraries (includes URMA)
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:iam>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:stackcore>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:log_server>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:urma>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:urma_common>
    $<$<STREQUAL:${PRODUCT},ascend910_96esl>:utrace_server_share>
    
    bbox_proc
    # Common security library (required for all products)
    c_sec
)
### INTERNAL END ###

# ------------------------------------------------------------------------------
# Target Properties
# ------------------------------------------------------------------------------
set_target_properties(slogd PROPERTIES
    OUTPUT_NAME slogd
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

# ==============================================================================
# Configuration File Targets
# ==============================================================================
# ascend310: Mini configuration with daemon monitor script
if (PRODUCT)
if (${PRODUCT} STREQUAL "ascend310")
    add_custom_target(slogDeviceFiles
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/mini/slog.conf ${CMAKE_CURRENT_BINARY_DIR}
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../../scripts/slogd_daemon_monitor.sh ${CMAKE_CURRENT_BINARY_DIR}
    )

# ascend310B: Milan 310 configuration (3 files)
elseif (${PRODUCT} STREQUAL "ascend310B" OR ${PRODUCT} STREQUAL "ascend310Besl")
    add_custom_target(slogDeviceFiles
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/milan_310/slog.conf ${CMAKE_CURRENT_BINARY_DIR}
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/milan_310/log.yaml ${CMAKE_CURRENT_BINARY_DIR}
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/milan_310/slogd.yaml ${CMAKE_CURRENT_BINARY_DIR}
    )

# ascend310Brc: Milan 310 RC configuration (3 files)
elseif (${PRODUCT} STREQUAL "ascend310Brc" OR ${PRODUCT} STREQUAL "ascend310Brcesl")
    add_custom_target(slogDeviceFiles
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/milan_310rc/slog.conf ${CMAKE_CURRENT_BINARY_DIR}
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/milan_310rc/log.yaml ${CMAKE_CURRENT_BINARY_DIR}
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/milan_310rc/slogd.yaml ${CMAKE_CURRENT_BINARY_DIR}
    )

# ascend310rc: Mini RC configuration (1 file)
elseif (${PRODUCT} STREQUAL "ascend310rc")
    add_custom_target(slogDeviceFiles
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/mini_rc/slog.conf ${CMAKE_CURRENT_BINARY_DIR}
    )

# ascend910: Cloud/DC configuration (3 files)
elseif (${PRODUCT} STREQUAL "ascend910")
    add_custom_target(slogDeviceFiles
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/cloud/slog.conf ${CMAKE_CURRENT_BINARY_DIR}/slog.conf
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/dc/log.yaml ${CMAKE_CURRENT_BINARY_DIR}
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/dc/slogd.yaml ${CMAKE_CURRENT_BINARY_DIR}
    )

# ascend910B: Milan 910 configuration (3 files)
elseif (${PRODUCT} STREQUAL "ascend910B")
    add_custom_target(slogDeviceFiles
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/milan_910/slog.conf ${CMAKE_CURRENT_BINARY_DIR}/slog.conf
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/milan_910/log.yaml ${CMAKE_CURRENT_BINARY_DIR}
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/milan_910/slogd.yaml ${CMAKE_CURRENT_BINARY_DIR}
    )

# ascend310p: DC configuration (3 files)
elseif (${PRODUCT} STREQUAL "ascend310p")
    add_custom_target(slogDeviceFiles
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/dc/slog.conf ${CMAKE_CURRENT_BINARY_DIR}/slog.conf
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/dc/log.yaml ${CMAKE_CURRENT_BINARY_DIR}
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/dc/slogd.yaml ${CMAKE_CURRENT_BINARY_DIR}
    )

# helper310p: Helper 310p configuration (3 files)
elseif (${PRODUCT} STREQUAL "helper310p")
    add_custom_target(slogDeviceFiles
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/helper_310p/slog.conf ${CMAKE_CURRENT_BINARY_DIR}/slog.conf
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/helper_310p/log.yaml ${CMAKE_CURRENT_BINARY_DIR}
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/helper_310p/slogd.yaml ${CMAKE_CURRENT_BINARY_DIR}
    )
endif ()
endif ()

### INTERNAL START ###
# ascend950/96 series: David configuration with rsyslog (5 files)
if (PRODUCT)
if ((${PRODUCT} STREQUAL "ascend950") OR 
        (${PRODUCT} STREQUAL "ascend950esl") OR 
        (${PRODUCT} STREQUAL "ascend350") OR 
        (${PRODUCT} STREQUAL "ascend910_96") OR 
        (${PRODUCT} STREQUAL "ascend910_96esl"))
    add_custom_target(slogDeviceFiles
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/david_910_95/slog.conf ${CMAKE_CURRENT_BINARY_DIR}/slog.conf
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/david_910_95/log.yaml ${CMAKE_CURRENT_BINARY_DIR}
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/david_910_95/slogd.yaml ${CMAKE_CURRENT_BINARY_DIR}
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/david_910_95/rsyslog_proc.conf ${CMAKE_CURRENT_BINARY_DIR}/rsyslog_proc.conf
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/david_910_95/rsyslog_socket.conf ${CMAKE_CURRENT_BINARY_DIR}/rsyslog_socket.conf
    )
endif ()
endif ()
### INTERNAL END ###

# ==============================================================================
# Installation Configuration
# ==============================================================================
set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR lib/cmake)

include(CMakePackageConfigHelpers)

# ------------------------------------------------------------------------------
# Install slogd executable
# ------------------------------------------------------------------------------
install(TARGETS slogd
    RUNTIME DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)

# ------------------------------------------------------------------------------
# Install configuration files
# ------------------------------------------------------------------------------
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/slog.conf
    ${CMAKE_CURRENT_BINARY_DIR}/rsyslog_proc.conf
    ${CMAKE_CURRENT_BINARY_DIR}/rsyslog_socket.conf
    DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)

# Install daemon monitor script for ascend310
if (PRODUCT)
if (${PRODUCT} STREQUAL "ascend310")
    install(PROGRAMS
        ${CMAKE_CURRENT_BINARY_DIR}/slogd_daemon_monitor.sh
        DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
    )
endif ()
endif ()

if (PRODUCT)
if ((${PRODUCT} STREQUAL "ascend310p") OR 
        (${PRODUCT} STREQUAL "ascend310B") OR 
        (${PRODUCT} STREQUAL "ascend310Besl") OR 
        (${PRODUCT} STREQUAL "ascend310Brc") OR 
        (${PRODUCT} STREQUAL "ascend310Brcesl") OR 
        (${PRODUCT} STREQUAL "ascend910") OR 
        (${PRODUCT} STREQUAL "ascend910B") OR 
        (${PRODUCT} STREQUAL "helper310p"))
    install(FILES
        ${CMAKE_CURRENT_BINARY_DIR}/log.yaml
        ${CMAKE_CURRENT_BINARY_DIR}/slogd.yaml
        DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
    )
endif ()
endif ()

### INTERNAL START ###
if (PRODUCT)
if ((${PRODUCT} STREQUAL "ascend950") OR 
        (${PRODUCT} STREQUAL "ascend950esl") OR 
        (${PRODUCT} STREQUAL "ascend350") OR 
        (${PRODUCT} STREQUAL "ascend910_96") OR 
        (${PRODUCT} STREQUAL "ascend910_96esl"))
    install(FILES
        ${CMAKE_CURRENT_BINARY_DIR}/log.yaml
        ${CMAKE_CURRENT_BINARY_DIR}/slogd.yaml
        DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
    )
endif ()
endif ()
### INTERNAL END ###