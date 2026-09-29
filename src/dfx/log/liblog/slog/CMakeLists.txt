# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

add_library(slog_headers INTERFACE)
target_include_directories(slog_headers INTERFACE
    $<BUILD_INTERFACE:${RUNTIME_DIR}/include/dfx>
    $<BUILD_INTERFACE:${RUNTIME_DIR}/include/dfx/base>
    $<BUILD_INTERFACE:${RUNTIME_DIR}/pkg_inc>
    $<BUILD_INTERFACE:${RUNTIME_DIR}/pkg_inc/base>
    $<BUILD_INTERFACE:${RUNTIME_DIR}/src/dfx/log/inc>
    $<BUILD_INTERFACE:${RUNTIME_DIR}/src/dfx/log/inc/toolchain>
    $<INSTALL_INTERFACE:include>
    $<INSTALL_INTERFACE:include/slog>
    $<INSTALL_INTERFACE:include/slog/toolchain>
)

set(liblog_type "device")

if(${PRODUCT_SIDE} STREQUAL "host")
    set(liblog_type "host")
endif ()

# MODEXT_LOG_BUILD 由 modext CMakelists 设置，标识当前为模块扩展构建上下文。
# 仅在 modext 构建时切换为 device_ext 类型（由 modext 的 plog_device 扩展库提供）。
# npu_runtime 等带 MODULE_EXT=true 但非 modext 构建时，仍使用 device 类型 （由 plog_device 提供 unified_dlog/alog）。
if (MODEXT_LOG_BUILD)
    set(liblog_type "device_ext")
endif ()

# Build configuration based on liblog_type
if(liblog_type STREQUAL "host")
    add_subdirectory(plog)
    add_subdirectory(plog_host)
elseif(liblog_type STREQUAL "device")
    add_subdirectory(plog_device)
endif ()
