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
    feature/src/tprt.cc
)
 
set(tprt_include
    ${LIBC_SEC_HEADER}
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/inc/external
    ${CMAKE_CURRENT_SOURCE_DIR}/feature/inc
)
 
#------------------------- xpu_tprt -------------------------
add_library(xpu_tprt SHARED
        ${tprt_source}
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
        )
 
target_link_libraries(xpu_tprt PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:mmpa_headers>
    $<BUILD_INTERFACE:slog_headers>
    -Wl,--no-as-needed
    c_sec
    -Wl,--as-needed
)
 
target_compile_definitions(xpu_tprt PRIVATE
    LOG_CPP
    google=ascend_private
    )

install(TARGETS xpu_tprt DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL)