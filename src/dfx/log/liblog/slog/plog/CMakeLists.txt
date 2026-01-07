# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set(plogSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/plog_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/plog_device_log.c
    ${CMAKE_CURRENT_SOURCE_DIR}/plog_api.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/plog_host_log.c
    ${CMAKE_CURRENT_SOURCE_DIR}/plog_driver_log.c
    ${CMAKE_CURRENT_SOURCE_DIR}/plog_thread.c
    ${CMAKE_CURRENT_SOURCE_DIR}/plog_file_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/plog_driver_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/plog_drv.c
    ${CMAKE_CURRENT_SOURCE_DIR}/plog_buffer_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_file_util.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/library_load.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_common.c
)

set(plogHeaderDir
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${LIBC_SEC_HEADER}
    ${TOOLAHCIN_LOG_DIR}/../../../include/driver
    ${TOOLAHCIN_LOG_DIR}/inc/toolchain
    ${TOOLAHCIN_LOG_DIR}/shared
    ${TOOLAHCIN_LOG_DIR}/utils
    ${TOOLAHCIN_LOG_DIR}/liblog/slog
    ${TOOLAHCIN_LOG_DIR}/../../../pkg_inc/mmpa
    ${TOOLAHCIN_LOG_DIR}/../../../pkg_inc
    ${TOOLAHCIN_LOG_DIR}/../../../pkg_inc/dump
)

add_library(static_plog_cpp STATIC
    ${plogSrcFiles})

target_include_directories(static_plog_cpp PRIVATE
    ${plogHeaderDir})

target_compile_definitions(static_plog_cpp PRIVATE
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:OS_TYPE_DEF=0>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:OS_TYPE_DEF=1>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:OS_TYPE=0>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:OS_TYPE=1>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:SECUREC_USING_STD_SECURE_LIB=0>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:WRITE_TO_SYSLOG>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:HAL_REGISTER_ALOG>
    PROCESS_LOG
    LOG_CPP
)

target_link_options(static_plog_cpp PRIVATE
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wl,-z,relro,-z,now,-z,noexecstack>
)

target_compile_options(static_plog_cpp PRIVATE
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Werror>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wfloat-equal -Wextra>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wunused>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wshadow>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wundef>
    $<$<CONFIG:Debug>:-g -O0>
    $<$<CONFIG:Release>:-Os>
    -fvisibility=hidden
    -fPIE
    -fPIC
    -fstack-protector-strong
    -fno-common
    -fsigned-char
    -fno-strict-aliasing
    -ffunction-sections
    -fdata-sections
)

target_link_libraries(static_plog_cpp PRIVATE
    $<BUILD_INTERFACE:slog_headers>
    c_sec
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:mmpa>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:dl>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:rt>
    -Wl,--gc-sections
)

set_target_properties(static_plog_cpp
    PROPERTIES
    OUTPUT_NAME plog_cpp
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

###################################################################
install(TARGETS static_plog_cpp 
    ARCHIVE DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)

############################unified_npu_log_plog##############################
add_library(static_plog STATIC
    ${plogSrcFiles})

target_include_directories(static_plog PRIVATE
    ${plogHeaderDir})

target_compile_definitions(static_plog PRIVATE
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:OS_TYPE_DEF=0>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:OS_TYPE_DEF=1>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:OS_TYPE=0>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:OS_TYPE=1>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:SECUREC_USING_STD_SECURE_LIB=0>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:WRITE_TO_SYSLOG>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:HAL_REGISTER_ALOG>
    PROCESS_LOG
)

target_link_options(static_plog PRIVATE
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wl,-z,relro,-z,now,-z,noexecstack>
)

target_compile_options(static_plog PRIVATE
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Werror>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wfloat-equal -Wextra>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wunused>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wshadow>
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wundef>
    $<$<CONFIG:Debug>:-g -O0>
    $<$<CONFIG:Release>:-Os>
    -fvisibility=hidden
    -fPIE
    -fPIC
    -fstack-protector-strong
    -fno-common
    -fsigned-char
    -fno-strict-aliasing
    -ffunction-sections
    -fdata-sections
)

target_link_libraries(static_plog PRIVATE
    $<BUILD_INTERFACE:slog_headers>
    c_sec
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:mmpa>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:dl>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Linux>:rt>
    -Wl,--gc-sections
)

set_target_properties(static_plog
    PROPERTIES
    OUTPUT_NAME plog
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

###################################################################
install(TARGETS static_plog 
    ARCHIVE DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)
