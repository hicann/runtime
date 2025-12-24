# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

############################# [ascend610/ascend610Lite/ascend610Lite] ####################################
############################# libslog.so #################################################################
set (libslogSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/../alog_to_slog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../slog_api.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_core_iam.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_unified_timer_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_async_process.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_iam.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_level_iam.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_level_env.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_level_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_time.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_attr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_message.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_print_syslog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/high_mem.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_buffer/log_ring_buffer.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_system_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_common.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_time.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/library_load.c)

set(libslogHeaderDir
    ${RUNTIME_DIR}/abl/libc_sec/include
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../shared
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_buffer
    ${IAM_HEADER_DIR}/include
    ${MDC_LINUX_SDK_DIR}/include
    ${RUNTIME_DIR}/inc/driver
    ${RUNTIME_DIR}/manager/resmgr/procmgr/unified_timer/include)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 11)

add_library(slog
    SHARED
        ${libslogSrcFiles})

target_include_directories(slog
    PRIVATE
        ${libslogHeaderDir})

target_compile_definitions(slog
    PRIVATE
        OS_TYPE_DEF=0
        OS_TYPE=0
        IAM
        LINUX_ETC_CONF
        GETCLOCK_VIRTUAL
        WRITE_TO_SYSLOG
    PUBLIC
        $<$<STREQUAL:${SLOG_NAME},alog>:LOG_CPP>
)

target_compile_definitions(slog PRIVATE
    $<$<STREQUAL:${PRODUCT},as31xm1>:BUF_SIZE>
)

target_compile_options(slog
    PRIVATE
        -Werror
        -Wfloat-equal -Wextra
        -Wunused
        -Wshadow
        -Wundef
        -fvisibility=hidden
        $<$<CONFIG:Debug>:-g -O0>
        $<$<CONFIG:Release>:-Os -D_FORTIFY_SOURCE=2>
        -fPIC
        -fstack-protector-strong
        -fno-common
        -fsigned-char
        -fno-strict-aliasing
        -fdata-sections
        -ffunction-sections
)

target_link_options(slog
    PRIVATE
        -Wl,-z,relro,-z,now,-z,noexecstack
        -Wl,--gc-sections
)

target_link_directories(slog
    PRIVATE
        ${MDC_LINUX_SDK_DIR}/lib64>
        ${MDC_LINUX_SDK_DIR}/lib64/mdc/base-plat>
)

target_link_libraries(slog
    PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        $<BUILD_INTERFACE:intf_pub_optimization>
        $<BUILD_INTERFACE:mmpa_headers>
        iam
        -lrt
        c_sec
    PUBLIC
        slog_headers
)

if (SLOG_NAME)
if (${SLOG_NAME} STREQUAL "alog")
set_target_properties(slog
    PROPERTIES
    OUTPUT_NAME ascendalog
)
else ()
set_target_properties(slog
    PROPERTIES
    OUTPUT_NAME slog
)
endif ()
else ()
set_target_properties(slog
    PROPERTIES
    OUTPUT_NAME slog
)
endif()

############################# [ascend610/ascend610Lite/ascend610Lite] ####################################
############################# libalog.so #################################################################
add_library(alog
    SHARED
        ${libslogSrcFiles})

target_include_directories(alog
    PRIVATE
        ${libslogHeaderDir})

target_compile_definitions(alog
    PRIVATE
        OS_TYPE_DEF=0
        OS_TYPE=0
        IAM
        LINUX_ETC_CONF
        GETCLOCK_VIRTUAL
        WRITE_TO_SYSLOG
    PUBLIC
        LOG_CPP
)

target_compile_definitions(alog PRIVATE
    $<$<STREQUAL:${PRODUCT},as31xm1>:BUF_SIZE>
)

target_compile_options(alog
    PRIVATE
        -Werror
        -Wfloat-equal -Wextra
        -Wunused
        -Wshadow
        -Wundef
        -fvisibility=hidden
        $<$<CONFIG:Debug>:-g -O0>
        $<$<CONFIG:Release>:-Os -D_FORTIFY_SOURCE=2>
        -fPIC
        -fstack-protector-strong
        -fno-common
        -fsigned-char
        -fno-strict-aliasing
        -fdata-sections
        -ffunction-sections
)

target_link_options(alog
    PRIVATE
        -Wl,-z,relro,-z,now,-z,noexecstack
        -Wl,--gc-sections
)

target_link_directories(alog
    PRIVATE
        ${MDC_LINUX_SDK_DIR}/lib64>
        ${MDC_LINUX_SDK_DIR}/lib64/mdc/base-plat>
)

target_link_libraries(alog
    PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        $<BUILD_INTERFACE:intf_pub_optimization>
        $<BUILD_INTERFACE:mmpa_headers>
        iam
        -lrt
        c_sec
    PUBLIC
        slog_headers
)

set_target_properties(alog
    PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY alog
    OUTPUT_NAME ascendalog
)

############################# [ascend610/ascend610Lite/ascend610Lite] ####################################
############################# install ####################################################################
install(TARGETS slog alog
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)

install(TARGETS slog alog
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}/${CMAKE_SYSTEM_PROCESSOR} OPTIONAL
)

############################# [ascend610/ascend610Lite/ascend610Lite] ####################################
################################# libunified_npu_log.so(driver) ##########################################
add_library(unified_slog
    SHARED
        ${libslogSrcFiles})

target_include_directories(unified_slog
    PRIVATE
        ${libslogHeaderDir})

target_compile_definitions(unified_slog
    PRIVATE
        OS_TYPE_DEF=0
        OS_TYPE=0
        IAM
        LINUX_ETC_CONF
        GETCLOCK_VIRTUAL
        WRITE_TO_SYSLOG
)

target_compile_definitions(unified_slog PRIVATE
    $<$<STREQUAL:${PRODUCT},as31xm1>:BUF_SIZE>
)

target_compile_options(unified_slog
    PRIVATE
        -Werror
        -Wfloat-equal -Wextra
        -Wunused
        -Wshadow
        -Wundef
        -fvisibility=hidden
        $<$<CONFIG:Debug>:-g -O0>
        $<$<CONFIG:Release>:-Os -D_FORTIFY_SOURCE=2>
        -fPIC
        -fstack-protector-strong
        -fno-common
        -fsigned-char
        -fno-strict-aliasing
        -fdata-sections
        -ffunction-sections
)

target_link_options(unified_slog
    PRIVATE
        -Wl,-z,relro,-z,now,-z,noexecstack
        -Wl,--gc-sections
)

target_link_directories(unified_slog
    PRIVATE
        ${MDC_LINUX_SDK_DIR}/lib64>
        ${MDC_LINUX_SDK_DIR}/lib64/mdc/base-plat>
)

target_link_libraries(unified_slog
    PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        $<BUILD_INTERFACE:intf_pub_optimization>
        $<BUILD_INTERFACE:mmpa_headers>
        iam
        -lrt
        c_sec
    PUBLIC
        slog_headers
)

set_target_properties(unified_slog
    PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY unified_slog
    OUTPUT_NAME unified_dlog
)

install(TARGETS unified_slog
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)

install(TARGETS unified_slog
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}/${CMAKE_SYSTEM_PROCESSOR} OPTIONAL
)

################################# libunified_npu_log.so(runtime) ##########################################
add_library(unified_dlog
    SHARED
        ${libslogSrcFiles})

target_include_directories(unified_dlog
    PRIVATE
        ${libslogHeaderDir})

target_compile_definitions(unified_dlog
    PRIVATE
        OS_TYPE_DEF=0
        OS_TYPE=0
        IAM
        LINUX_ETC_CONF
        GETCLOCK_VIRTUAL
        WRITE_TO_SYSLOG
    PUBLIC
        APP_LOG
)

target_compile_definitions(unified_dlog PRIVATE
    $<$<STREQUAL:${PRODUCT},as31xm1>:BUF_SIZE>
)

target_compile_options(unified_dlog
    PRIVATE
        -Werror
        -Wfloat-equal -Wextra
        -Wunused
        -Wshadow
        -Wundef
        -fvisibility=hidden
        $<$<CONFIG:Debug>:-g -O0>
        $<$<CONFIG:Release>:-Os -D_FORTIFY_SOURCE=2>
        -fPIC
        -fstack-protector-strong
        -fno-common
        -fsigned-char
        -fno-strict-aliasing
        -fdata-sections
        -ffunction-sections
)

target_link_options(unified_dlog
    PRIVATE
        -Wl,-z,relro,-z,now,-z,noexecstack
        -Wl,--gc-sections
)

target_link_directories(unified_dlog
    PRIVATE
        ${MDC_LINUX_SDK_DIR}/lib64>
        ${MDC_LINUX_SDK_DIR}/lib64/mdc/base-plat>
)

target_link_libraries(unified_dlog
    PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        $<BUILD_INTERFACE:intf_pub_optimization>
        $<BUILD_INTERFACE:mmpa_headers>
        iam
        -lrt
        c_sec
    PUBLIC
        slog_headers
)

set_target_properties(unified_dlog
    PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY unified_dlog
    OUTPUT_NAME unified_dlog
)

install(TARGETS unified_dlog
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)

install(TARGETS unified_dlog
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}/${CMAKE_SYSTEM_PROCESSOR} OPTIONAL
)