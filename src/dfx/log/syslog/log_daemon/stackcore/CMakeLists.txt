# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set(INSTALL_LIBRARY_DIR lib)

set(stackcoreSrcList
    ${CMAKE_CURRENT_SOURCE_DIR}/stackcore.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stackcore_common.c
)

set(stackcoreHeaders
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${LIBC_SEC_HEADER}
    ${TOOLAHCIN_LOG_DIR}/inc/stackcore
)

add_library(stackcore SHARED
    ${stackcoreSrcList}
)

add_library(stackcore_headers INTERFACE)
target_include_directories(stackcore_headers INTERFACE
    ${stackcoreHeaders}
)

target_link_libraries(stackcore PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:stackcore_headers>
    c_sec
)

target_compile_options(stackcore PRIVATE
    -Werror
    -Wfloat-equal -Wextra
    -Wunused
    -Wshadow
    -Wundef
    $<$<CONFIG:Debug>:-g -O0>
    $<$<CONFIG:Release>:-O2 -D_FORTIFY_SOURCE=2>
    -std=c99
    -fno-common
    -fstack-protector-strong
    -fPIC
    -fdata-sections
    -ffunction-sections
)

target_link_options(stackcore PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,--gc-sections
)

target_compile_definitions(stackcore PRIVATE
    $<$<STREQUAL:${PRODUCT},ascend960>:LOG_CORETRACE>
    $<$<STREQUAL:${PRODUCT},ascend960esl>:LOG_CORETRACE>
    $<$<STREQUAL:${PRODUCT},ascend950>:LOG_CORETRACE>
    $<$<STREQUAL:${PRODUCT},ascend950esl>:LOG_CORETRACE>
    $<$<STREQUAL:${PRODUCT},ascend350>:LOG_CORETRACE>
    $<$<STREQUAL:${PRODUCT},ascend310N>:LOG_CORETRACE>
    _GNU_SOURCE
)

install(TARGETS stackcore OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)

install(PROGRAMS
    ${CMAKE_CURRENT_BINARY_DIR}/coretrace_helper.sh
    DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)
