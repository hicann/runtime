# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
#------------------------- public ----------------------------
set(tprt_source
    c/tprt_api.cc
    feature/src/tprt_cqhandle.cc
    feature/src/tprt_device.cc
    feature/src/tprt_log.cc
    feature/src/tprt_sqhandle.cc
    feature/src/tprt_worker.cc
    feature/src/tprt_profiling.cc
    feature/src/tprt.cc
    feature/src/tprt_timer.cc
)
 
set(tprt_include
    ${LIBC_SEC_HEADER}
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/external
    ${CMAKE_CURRENT_SOURCE_DIR}/feature/inc
)
 
#------------------------- xpu_tprt internal -------------------------
add_library(xpu_tprt STATIC
        ${tprt_source}
        )

set_target_properties(xpu_tprt PROPERTIES
    POSITION_INDEPENDENT_CODE ON
)
 
target_include_directories(xpu_tprt PRIVATE
        ${tprt_include}
        )
 
target_compile_options(xpu_tprt PRIVATE
        -fno-common
        -fno-strict-aliasing
        -Werror
        $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wextra>
        $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-Wno-error=unused-parameter>
        $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-fvisibility=hidden>
        $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Windows>>:-fvisibility-inlines-hidden>
        )
 
target_link_libraries(xpu_tprt PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:msprof_headers>
    -Wl,--no-as-needed
    c_sec
    profapi_share
    mmpa
    unified_dlog
    -Wl,--as-needed
)
 
target_compile_definitions(xpu_tprt PRIVATE
    google=ascend_private
    )

if(NOT "${TARGET_SYSTEM_NAME}" STREQUAL "Windows")
    add_library(xpu_tprt_compat_stub SHARED
        stub/xpu_tprt_compat_stub.c
    )

    set_target_properties(xpu_tprt_compat_stub PROPERTIES
        OUTPUT_NAME xpu_tprt
        C_VISIBILITY_PRESET hidden
    )

    add_dependencies(xpu_tprt xpu_tprt_compat_stub)

    install(TARGETS xpu_tprt_compat_stub
        LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
        OPTIONAL
    )
endif()
