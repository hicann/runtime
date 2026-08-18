# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
### INTERNAL START ###
add_subdirectory(../log_post_process/app_report ${CMAKE_CURRENT_BINARY_DIR}/app_report)
add_subdirectory(../log_post_process/sys_report ${CMAKE_CURRENT_BINARY_DIR}/sys_report)

set(iamSlogdSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/../../slogd_main.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../slogd_argv.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../trace_server/slogd_trace_server.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../bbox_server/slogd_bbox_server.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../slogd_service.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../slogd_dev_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../slogd_thread_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_pre_process/log_communication/slogd_communication.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_pre_process/log_communication/slogd_communication_iam.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_pre_process/cmd_process/slogd_collect_log.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_pre_process/slogd_recv_msg.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_pre_process/slogd_parse_msg.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_pre_process/slogd_recv_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/sys_log/slogd_syslog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/sys_log/slogd_kernel_log.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/app_log/slogd_applog_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/app_log/slogd_applog_flush.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/app_log/slogd_applog_report.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/app_log/slogd_appnum_watch.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/event_log/slogd_eventlog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/group_log/slogd_group_log.c
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
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils/log_system_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils/msg_queue.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils/log_queue.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils/share_mem.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils/log_common.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils/log_buffer/log_ring_buffer.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils/log_compress/log_compress.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils/log_compress/log_software_zip.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils/log_compress/log_hardware_zip.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils/log_time.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils/log_print_syslog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils/log_file_util.c
)
# ------------------------------------------------------------------------------
# IAM-based Device Include Directories
# ------------------------------------------------------------------------------
set(iamSlogdIncFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/../
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_pre_process
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_pre_process/log_communication
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_pre_process/cmd_process
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/sys_log
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/app_log
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/event_log
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/firmware_log
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_classify/group_log
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_mgr/level_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_mgr/file_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_mgr/config_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_mgr/buffer_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_post_process
    ${CMAKE_CURRENT_SOURCE_DIR}/../log_post_process/session_mgr
    ${CMAKE_CURRENT_SOURCE_DIR}/../../trace_server
    ${CMAKE_CURRENT_SOURCE_DIR}/../../bbox_server
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../common
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/pm
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/config
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../common/driver
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../utils/log_buffer
    ${LIBC_SEC_HEADER}
    ${KERNEL_NVE_MTD_HEADER_DIR}
    ${RUNTIME_DIR}/pkg_inc/driver
    ${RUNTIME_DIR}/src/dfx/adump/external
    ${MDC_LINUX_SDK_DIR}/include
    ${IAM_HEADER_DIR}/include
    ${TOP_DIR}/manager/resmgr/secmgr/include/
)

# ------------------------------------------------------------------------------
# Product-Specific Configuration
# MDC products: Use IAM-specific source files and headers
# ------------------------------------------------------------------------------
set(slogdSrcFiles ${iamSlogdSrcFiles})
set(slogdHeaderDir ${iamSlogdIncFiles})

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
    # ascend610/Lite: Hardware compression, SR monitoring, RC mode with IAM
    $<$<STREQUAL:${PRODUCT},ascend610>:HARDWARE_ZIP SR_MONITOR GETCLOCK_VIRTUAL APP_LOG_WATCH RC_MODE IAM LINUX_ETC_CONF GROUP_LOG IAM_MONITOR SLOGD_COLLECT>
    $<$<STREQUAL:${PRODUCT},ascend610Lite>:HARDWARE_ZIP SR_MONITOR GETCLOCK_VIRTUAL APP_LOG_WATCH RC_MODE IAM LINUX_ETC_CONF GROUP_LOG IAM_MONITOR SLOGD_COLLECT>
    $<$<STREQUAL:${PRODUCT},ascend610Liteesl>:HARDWARE_ZIP SR_MONITOR GETCLOCK_VIRTUAL APP_LOG_WATCH RC_MODE IAM LINUX_ETC_CONF GROUP_LOG IAM_MONITOR SLOGD_COLLECT>
    # mc62cm12a: Similar to ascend610Lite
    $<$<STREQUAL:${PRODUCT},mc62cm12a>:SOFTWARE_ZIP SR_MONITOR GETCLOCK_VIRTUAL APP_LOG_WATCH RC_MODE IAM LINUX_ETC_CONF GROUP_LOG IAM_MONITOR SLOGD_COLLECT>
    $<$<STREQUAL:${PRODUCT},mc62cm12aesl>:SOFTWARE_ZIP SR_MONITOR GETCLOCK_VIRTUAL APP_LOG_WATCH RC_MODE IAM LINUX_ETC_CONF GROUP_LOG IAM_MONITOR SLOGD_COLLECT>
    # mc32dm11a: Similar to 1952lite
    $<$<STREQUAL:${PRODUCT},mc32dm11a>:SR_MONITOR GETCLOCK_VIRTUAL APP_LOG_WATCH RC_MODE IAM LINUX_ETC_CONF GROUP_LOG IAM_MONITOR SLOGD_COLLECT>
    $<$<STREQUAL:${PRODUCT},mc32dm11aesl>:SR_MONITOR GETCLOCK_VIRTUAL APP_LOG_WATCH RC_MODE IAM LINUX_ETC_CONF GROUP_LOG IAM_MONITOR SLOGD_COLLECT>
    # as31xm1: Software compression instead of hardware
    $<$<STREQUAL:${PRODUCT},as31xm1>:SOFTWARE_ZIP GETCLOCK_VIRTUAL APP_LOG_WATCH RC_MODE IAM LINUX_ETC_CONF GROUP_LOG IAM_MONITOR SLOGD_COLLECT>
)

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
    # Security hardening linker flags
    -Wl,-z,relro,-z,now,-z,noexecstack              # RELRO, immediate binding, no exec stack
    -Wl,--gc-sections                                # Remove unused sections
)

# ------------------------------------------------------------------------------
# Link Directories (Product-specific library paths)
# ------------------------------------------------------------------------------
target_link_directories(slogd PRIVATE
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
    $<$<STREQUAL:${PRODUCT},mc32dm11a>:${MDC_LINUX_SDK_DIR}/lib64/mdc/base-plat>
    $<$<STREQUAL:${PRODUCT},mc32dm11aesl>:${MDC_LINUX_SDK_DIR}/lib64>
    $<$<STREQUAL:${PRODUCT},mc32dm11aesl>:${MDC_LINUX_SDK_DIR}/lib64/mdc/base-plat>
    $<$<STREQUAL:${PRODUCT},as31xm1>:${MDC_LINUX_SDK_DIR}/lib64>
    $<$<STREQUAL:${PRODUCT},as31xm1>:${MDC_LINUX_SDK_DIR}/lib64/mdc/base-plat>
)

# ------------------------------------------------------------------------------
# Link Libraries (Product-specific dependencies)
# ------------------------------------------------------------------------------
target_link_libraries(slogd PRIVATE
    # Common interface libraries (build-time only)
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:adump_headers>
    $<BUILD_INTERFACE:intf_pub_optimization>
    
    # ascend610 series libraries (with KMS and real-time support)
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
    
    # mc62cm12a series libraries (with zlib compression)
    $<$<STREQUAL:${PRODUCT},mc62cm12a>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},mc62cm12a>:kms>
    $<$<STREQUAL:${PRODUCT},mc62cm12a>:iam>
    $<$<STREQUAL:${PRODUCT},mc62cm12a>:-lrt>
    $<$<STREQUAL:${PRODUCT},mc62cm12a>:easy_comm>
    $<$<STREQUAL:${PRODUCT},mc62cm12a>:-lz>
    $<$<STREQUAL:${PRODUCT},mc62cm12aesl>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},mc62cm12aesl>:kms>
    $<$<STREQUAL:${PRODUCT},mc62cm12aesl>:iam>
    $<$<STREQUAL:${PRODUCT},mc62cm12aesl>:-lrt>
    $<$<STREQUAL:${PRODUCT},mc62cm12aesl>:easy_comm>
    $<$<STREQUAL:${PRODUCT},mc62cm12aesl>:-lz>

    # mc32dm11a series libraries
    $<$<STREQUAL:${PRODUCT},mc32dm11a>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},mc32dm11a>:kms>
    $<$<STREQUAL:${PRODUCT},mc32dm11a>:iam>
    $<$<STREQUAL:${PRODUCT},mc32dm11a>:-lrt>
    $<$<STREQUAL:${PRODUCT},mc32dm11a>:easy_comm>
    $<$<STREQUAL:${PRODUCT},mc32dm11aesl>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},mc32dm11aesl>:kms>
    $<$<STREQUAL:${PRODUCT},mc32dm11aesl>:iam>
    $<$<STREQUAL:${PRODUCT},mc32dm11aesl>:-lrt>
    $<$<STREQUAL:${PRODUCT},mc32dm11aesl>:easy_comm>
    
    # as31xm1 libraries (with zlib compression)
    $<$<STREQUAL:${PRODUCT},as31xm1>:ascend_hal>
    $<$<STREQUAL:${PRODUCT},as31xm1>:iam>
    $<$<STREQUAL:${PRODUCT},as31xm1>:-lrt>
    $<$<STREQUAL:${PRODUCT},as31xm1>:easy_comm>
    $<$<STREQUAL:${PRODUCT},as31xm1>:-lz>

    bbox_proc
    # Common security library (required for all products)
    c_sec
)

# ------------------------------------------------------------------------------
# Target Properties
# ------------------------------------------------------------------------------
set_target_properties(slogd PROPERTIES
    OUTPUT_NAME slogd
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

# ==============================================================================
# Configuration File Targets (Copy product-specific config files)
# ==============================================================================
# ascend610: MDC configuration (3 files)
if (PRODUCT)
if ((${PRODUCT} STREQUAL "ascend610") OR
    (${PRODUCT} STREQUAL "mc62cm12a") OR 
    (${PRODUCT} STREQUAL "mc62cm12aesl"))
    add_custom_target(slogDeviceFiles
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/mdc/slog.conf ${CMAKE_CURRENT_BINARY_DIR}/slog.conf
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/mdc/log.yaml ${CMAKE_CURRENT_BINARY_DIR}
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/mdc/slogd.yaml ${CMAKE_CURRENT_BINARY_DIR}
    )

# ascend610Lite and mc62cm12a series: MDC Lite configuration (3 files)
elseif ((${PRODUCT} STREQUAL "ascend610Lite") OR 
        (${PRODUCT} STREQUAL "ascend610Liteesl") OR 
        (${PRODUCT} STREQUAL "mc32dm11a") OR 
        (${PRODUCT} STREQUAL "mc32dm11aesl"))
    add_custom_target(slogDeviceFiles
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/mdc_610lite/slog.conf ${CMAKE_CURRENT_BINARY_DIR}/slog.conf
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/mdc/log.yaml ${CMAKE_CURRENT_BINARY_DIR}
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/mdc/slogd.yaml ${CMAKE_CURRENT_BINARY_DIR}
    )

# as31xm1: MDC 310 configuration (3 files)
elseif (${PRODUCT} STREQUAL "as31xm1")
    add_custom_target(slogDeviceFiles
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/mdc_310/slog.conf ${CMAKE_CURRENT_BINARY_DIR}/slog.conf
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/mdc_310/log.yaml ${CMAKE_CURRENT_BINARY_DIR}
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/mdc_310/slogd.yaml ${CMAKE_CURRENT_BINARY_DIR}
    )
endif ()
endif ()

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
# Install configuration files (product-specific)
# ------------------------------------------------------------------------------
if (PRODUCT)
if ((${PRODUCT} STREQUAL "ascend610") OR 
    (${PRODUCT} STREQUAL "ascend610Lite") OR 
    (${PRODUCT} STREQUAL "ascend610Liteesl") OR 
    (${PRODUCT} STREQUAL "mc32dm11a") OR 
    (${PRODUCT} STREQUAL "mc32dm11aesl") OR 
    (${PRODUCT} STREQUAL "as31xm1") OR 
    (${PRODUCT} STREQUAL "mc62cm12a") OR 
    (${PRODUCT} STREQUAL "mc62cm12aesl"))
    install(FILES
        ${CMAKE_CURRENT_BINARY_DIR}/log.yaml
        ${CMAKE_CURRENT_BINARY_DIR}/slogd.yaml
        ${CMAKE_CURRENT_BINARY_DIR}/slog.conf
        DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
    )
endif ()
endif ()
### INTERNAL START ###
