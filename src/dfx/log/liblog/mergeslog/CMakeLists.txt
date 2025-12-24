# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(reportSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/mergeslog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils/log_system_api.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils/log_print_syslog.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../../utils/log_common.c
)

set(reportHeaderDir
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${RUNTIME_DIR}/abl/libc_sec/include
    ${TOOLAHCIN_LOG_DIR}/utils
    ${IAM_HEADER_DIR}/include
)

add_library(ascendlogcollector SHARED
    ${reportSrcFiles})

target_include_directories(ascendlogcollector PRIVATE
    ${reportHeaderDir})

target_compile_definitions(ascendlogcollector PRIVATE
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:OS_TYPE_DEF=0>
    WRITE_TO_SYSLOG
)

target_compile_options(ascendlogcollector PRIVATE
    -Werror
    -Wfloat-equal -Wextra
    -Wunused
    -Wshadow
    -Wundef
    -fvisibility=hidden
    $<$<CONFIG:Debug>:-g -O0>
    $<$<CONFIG:Release>:-Os -D_FORTIFY_SOURCE=2>
    -fPIE
    -fstack-protector-strong
    -fno-common
    -fsigned-char
    -fno-strict-aliasing
)

target_link_options(ascendlogcollector PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
)

target_link_libraries(ascendlogcollector PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:slog_headers>
    $<$<STREQUAL:${PRODUCT},as31xm1>:iam>
    $<$<STREQUAL:${PRODUCT},ascend610>:iam>
    $<$<STREQUAL:${PRODUCT},ascend610Lite>:iam>
    $<$<STREQUAL:${PRODUCT},ascend610Liteesl>:iam>
    dl
    rt
    c_sec
)

set_target_properties(ascendlogcollector
    PROPERTIES
    OUTPUT_NAME ascendlogcollector
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

###################################################################
set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR lib/cmake)

include(CMakePackageConfigHelpers)

install(TARGETS ascendlogcollector
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)
