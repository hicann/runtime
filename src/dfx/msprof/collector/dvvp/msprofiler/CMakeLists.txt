# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
####################### libmsprofiler.so #########################
set(msprofilerCpp
    ../common/utils/utils.cpp
    ../common/cmd_log/cmd_log.cpp
    ${PROF_BASIC_DIR}/osal/osal.c
    prof_api_common.cpp
)

set(msprofilerInc
   ${RUNTIME_DIR}/graphengine/inc
   ${RUNTIME_DIR}/include/external
   ${RUNTIME_DIR}/graphengine/inc/external
   ${RUNTIME_DIR}/graphengine/inc/framework/common
   ${RUNTIME_DIR}/src/dfx/error_manager
   ${LIBC_SEC_HEADER}
   ../
   ../common
   ../common/utils
   ../common/cmd_log
   ../common/logger
   ../common/json
   ${PROF_BASIC_DIR}/osal
   ../analyze/inc
)

set(msprofilerFwcSrc
    ${msprofilerCpp}
    prof_ge_core.cpp
)

add_library(msprofiler_fwk_share SHARED
    ${msprofilerFwcSrc}
    prof_acl_core.cpp
    prof_acl_api.cpp
    prof_api_runtime.cpp
)

target_include_directories(msprofiler_fwk_share PRIVATE
    ${msprofilerInc}
    ../profapi/inc
    ../depend/include/wrapper
)

set_target_properties(msprofiler_fwk_share
    PROPERTIES
    OUTPUT_NAME $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,libmsprofiler,msprofiler>
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
)

target_compile_definitions(msprofiler_fwk_share PRIVATE
    google=ascend_private
    $<$<STREQUAL:${CMAKE_BUILD_TYPE},Debug>:MSPROF_DEBUG>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:NOMINMAX>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>:WIN32>
)

target_compile_options(msprofiler_fwk_share PRIVATE
    -fPIC
    -fstack-protector-all
    -fno-strict-aliasing
    -fno-common
    -fvisibility=hidden
    $<$<COMPILE_LANGUAGE:CXX>:-fvisibility-inlines-hidden>
    -Wall
    -Wextra
    -Wfloat-equal
    $<$<CONFIG:Release>:-D_FORTIFY_SOURCE=2 -Os>
    $<$<CONFIG:Debug>:-D_FORTIFY_SOURCE=2 -Os>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Debug>>:/MTd>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Release>>:/MT>
)

target_link_options(msprofiler_fwk_share PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
    -Wl,--exclude-libs=ALL
)

# msprof 通用服务器场景：msprofiler_fwk_share 源码不直接引用任何驱动符号（driver 调用均经
# profimpl 层的 MsprofDrvApi 间接 dlopen/dlsym），链接期不需要 ascend_hal_stub，避免 NEEDED
# 表带上 libascend_hal.so（无驱动包环境下会导致本 so 加载期失败）。

target_link_libraries(msprofiler_fwk_share
    PRIVATE
        intf_pub
        slog_headers
        mmpa_headers
        adump_headers
        npu_runtime_headers
        c_sec
        alog
        mmpa
        profapi_share
        error_manager
    PUBLIC
        msprof_headers
)

if (WIN32)
    set(msprof_targets msprofiler_fwk_share msprof_headers)
else()
    set(msprof_targets msprofiler_fwk_share profapi_share msprof_headers)
endif()

add_library(msprofiler ALIAS msprofiler_fwk_share)

install_package(
    PACKAGE msprof
    TARGETS ${msprof_targets}
    FILES   ${MSPROF_DIR}/inc/toolchain/prof_acl_api.h
            ${MSPROF_DIR}/inc/toolchain/prof_api.h
            ${MSPROF_DIR}/inc/toolchain/prof_common.h
            ${MSPROF_DIR}/inc/toolchain/prof_data_config.h
            ${MSPROF_DIR}/inc/toolchain/prof_engine.h
            ${MSPROF_DIR}/inc/toolchain/prof_reporter.h
            ${RUNTIME_DIR}/pkg_inc/profiling/devprof_pub.h
            ${RUNTIME_DIR}/pkg_inc/profiling/aprof_pub.h
    DESTINATION ${INSTALL_INCLUDE_DIR}/msprof/toolchain
)
####################### libmsprofiler.so #########################

####################### libmsprofiler_lite.so #########################
set(msprofilerLiteInc
   ${RUNTIME_DIR}/include/external
   ${RUNTIME_DIR}/src/dfx/error_manager
   ${LIBC_SEC_HEADER}
   ${MSPROF_DIR}/include/external
   ${PROF_BASIC_DIR}/osal
   ../
   ../common
   ../common/logger
   ../common/json
)

add_library(msprofiler_fwk_lite_share SHARED
    prof_acl_api.cpp
    prof_api_runtime.cpp
)

target_include_directories(msprofiler_fwk_lite_share PRIVATE
    ${msprofilerLiteInc}
    ../profapi/inc
    ../depend/include/wrapper
)

set_target_properties(msprofiler_fwk_lite_share
    PROPERTIES
    OUTPUT_NAME msprofiler
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/proflib
)

target_compile_definitions(msprofiler_fwk_lite_share PRIVATE
    PROF_LITE
    OSAL
    $<$<STREQUAL:${CMAKE_BUILD_TYPE},Debug>:MSPROF_DEBUG>
)

target_compile_options(msprofiler_fwk_lite_share PRIVATE
    -fPIC
    -fstack-protector-all
    -fno-strict-aliasing
    -fno-common
    -fvisibility=hidden
    $<$<COMPILE_LANGUAGE:CXX>:-fvisibility-inlines-hidden>
    -Wall
    -Wextra
    -Wfloat-equal
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Debug>>:/MTd>
    $<$<AND:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>,$<STREQUAL:${CMAKE_CONFIGURATION_TYPES},Release>>:/MT>
)

target_link_options(msprofiler_fwk_lite_share PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,-Bsymbolic
    -Wl,--exclude-libs=ALL
)

target_link_libraries(msprofiler_fwk_lite_share
    PRIVATE
        mmpa_headers
        intf_pub
        slog_headers
        -Wl,--no-as-needed
        c_sec
        alog
        profapi_lite_share
        -Wl,--as-needed
        mmpa
    PUBLIC
        msprof_headers
)

install(TARGETS msprofiler_fwk_lite_share OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}/lib
)
####################### libmsprofiler_lite.so #########################