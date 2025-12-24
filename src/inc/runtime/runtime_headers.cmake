# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
include_guard(GLOBAL)

add_library(npu_runtime_headers INTERFACE)
target_include_directories(npu_runtime_headers INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/..>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/rts>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/../external>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/../external/runtime>
    $<INSTALL_INTERFACE:include>
    $<INSTALL_INTERFACE:include/runtime>
    $<INSTALL_INTERFACE:include/runtime/external>
    $<INSTALL_INTERFACE:include/runtime/external/runtime>
)