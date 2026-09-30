# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
cmake_minimum_required(VERSION 3.14)

add_library(msprof_headers INTERFACE)

target_include_directories(msprof_headers INTERFACE
    $<BUILD_INTERFACE:${MSPROF_DIR}/inc>
    $<BUILD_INTERFACE:${MSPROF_DIR}/inc/toolchain>
    $<BUILD_INTERFACE:${RUNTIME_DIR}/pkg_inc>
    $<BUILD_INTERFACE:${RUNTIME_DIR}/pkg_inc/profiling>
    $<INSTALL_INTERFACE:include>
    $<INSTALL_INTERFACE:include/msprof>
    $<INSTALL_INTERFACE:include/msprof/toolchain>
)