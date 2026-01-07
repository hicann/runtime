# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

############################# ![ascend610/ascend610Lite/ascend610Lite] ###################################
############################# libslog.so #################################################################
set(libslogSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/../alog_to_slog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../slog_api.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_time.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_attr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_console.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_message.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_level_env.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_level_shm.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_level_mgr.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_communication/dlog_socket.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_communication/dlog_shm_control.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_print_syslog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/share_mem.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_system_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_common.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/log_time.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils/library_load.c
)

set(libslogHeaderDir
    ${LIBC_SEC_HEADER}
    ${TOOLAHCIN_LOG_DIR}/../../../include/driver
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../../../../pkg_inc/mmpa
    ${RUNTIME_DIR}/inc/driver
    ${IAM_HEADER_DIR}/include
    ${CMAKE_CURRENT_SOURCE_DIR}/../
    ${CMAKE_CURRENT_SOURCE_DIR}/../dlog_communication
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../utils
)

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
        $<$<STREQUAL:${PRODUCT},ascend310B>:LINUX_ETC_CONF>
        $<$<STREQUAL:${PRODUCT},ascend310Besl>:LINUX_ETC_CONF>
        $<$<STREQUAL:${PRODUCT},ascend310Brc>:LINUX_ETC_CONF>
        $<$<STREQUAL:${PRODUCT},ascend310Brcesl>:LINUX_ETC_CONF>
        $<$<STREQUAL:${PRODUCT},helper310p>:LINUX_ETC_CONF>
        WRITE_TO_SYSLOG
    PUBLIC
        $<$<STREQUAL:${SLOG_NAME},alog>:LOG_CPP>
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
        -ffunction-sections
        -fdata-sections
)

target_link_options(slog
    PRIVATE
        -Wl,-z,relro,-z,now,-z,noexecstack
        -Wl,--gc-sections
)

target_link_libraries(slog
    PRIVATE
        $<BUILD_INTERFACE:mmpa_headers>
        $<BUILD_INTERFACE:intf_pub>
        mmpa
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
endif ()

install(TARGETS slog
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)

############################# ![ascend610/ascend610Lite/ascend610Lite] ###################################
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
        $<$<STREQUAL:${PRODUCT},ascend310B>:LINUX_ETC_CONF>
        $<$<STREQUAL:${PRODUCT},ascend310Besl>:LINUX_ETC_CONF>
        $<$<STREQUAL:${PRODUCT},ascend310Brc>:LINUX_ETC_CONF>
        $<$<STREQUAL:${PRODUCT},ascend310Brcesl>:LINUX_ETC_CONF>
        $<$<STREQUAL:${PRODUCT},helper310p>:LINUX_ETC_CONF>
        WRITE_TO_SYSLOG
    PUBLIC
        LOG_CPP
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
        -ffunction-sections
        -fdata-sections
)

target_link_options(alog
    PRIVATE
        -Wl,-z,relro,-z,now,-z,noexecstack
        -Wl,--gc-sections
)

target_link_libraries(alog
    PRIVATE
        $<BUILD_INTERFACE:mmpa_headers>
        $<BUILD_INTERFACE:intf_pub>
        mmpa
        c_sec
    PUBLIC
        slog_headers
)

set_target_properties(alog
    PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY alog
    OUTPUT_NAME ascendalog
)

install(TARGETS alog
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)

# install(TARGETS alog
#     LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}/${CMAKE_SYSTEM_PROCESSOR} OPTIONAL
# )

############################# ![ascend610/ascend610Lite/ascend610Lite] ###################################
############################# libunified_npu_log.so ######################################################
add_library(unified_dlog
    SHARED
        ${libslogSrcFiles}
)

target_include_directories(unified_dlog
    PRIVATE
        ${libslogHeaderDir}
)

target_compile_definitions(unified_dlog
    PRIVATE
        OS_TYPE_DEF=0
        OS_TYPE=0
        WRITE_TO_SYSLOG
        $<$<NOT:$<BOOL:${PRODUCT}>>:APP_LOG>
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
        -ffunction-sections
        -fdata-sections
)

target_link_options(unified_dlog
    PRIVATE
        -Wl,-z,relro,-z,now,-z,noexecstack
        -Wl,--gc-sections
)

target_link_libraries(unified_dlog
    PRIVATE
        $<BUILD_INTERFACE:mmpa_headers>
        $<BUILD_INTERFACE:intf_pub>
        mmpa
        c_sec
    PUBLIC
        slog_headers
)

install(TARGETS unified_dlog
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)

# install(TARGETS unified_dlog
#     LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}/${CMAKE_SYSTEM_PROCESSOR} OPTIONAL
# )