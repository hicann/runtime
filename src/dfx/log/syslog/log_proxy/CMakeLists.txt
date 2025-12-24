# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(logProxySrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/log_proxy.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils/log_print_syslog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils/high_mem.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils/log_buffer/log_ring_buffer.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils/log_common.c
)

set(logProxyHeaderDir
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${RUNTIME_DIR}/abl/libc_sec/include
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils
    ${CMAKE_CURRENT_SOURCE_DIR}/../../shared
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils/log_buffer
    ${IAM_HEADER_DIR}/include
)

add_executable(log_proxy
    ${logProxySrcFiles})

target_include_directories(log_proxy PRIVATE
    ${logProxyHeaderDir})

target_compile_definitions(log_proxy PRIVATE
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:OS_TYPE_DEF=0>
    WRITE_TO_SYSLOG
)

target_compile_options(log_proxy PRIVATE
    $<$<CONFIG:Debug>:-g -O0>
    $<$<CONFIG:Release>:-Os -D_FORTIFY_SOURCE=2>
    -Werror
    -Wfloat-equal -Wextra
    -fPIE
    -fstack-protector-strong
    -fvisibility=hidden
    -fno-common
)

target_link_options(log_proxy PRIVATE
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wl,-z,relro,-z,now,-z,noexecstack>
)

target_link_libraries(log_proxy PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:slog_headers>
    c_sec
    iam
)

set_target_properties(log_proxy
    PROPERTIES
    OUTPUT_NAME log_proxy
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

###################################################################
set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR lib/cmake)

include(CMakePackageConfigHelpers)

install(TARGETS log_proxy
    RUNTIME DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)

