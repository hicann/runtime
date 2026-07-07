# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(RUNTIME_CORE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/core)
set(RUNTIME_FEATURE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/feature)
set(RUNTIME_CMAKE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

include(${RUNTIME_DIR}/pkg_inc/runtime/runtime/runtime_headers.cmake)
include(${RUNTIME_DIR}/src/inc/runtime/runtime_inner_headers.cmake)
include(${RUNTIME_CMAKE_DIR}/platform.cmake)
include(${RUNTIME_CMAKE_DIR}/runtime_warning_options.cmake)

if ("${PRODUCT}" STREQUAL "ascend031")
    runtime_platform_tiny_obj(runtime_platform_tiny)
    include(${RUNTIME_CMAKE_DIR}/tiny.cmake)
elseif("${PRODUCT}" STREQUAL "ascend5162a")
    runtime_platform_arch5162_obj(runtime_platform_arch5162)
    include(${RUNTIME_CMAKE_DIR}/arch5162.cmake)
else()
    runtime_platform_others_obj(runtime_platform_others)
    runtime_platform_tiny_obj(runtime_platform_tiny)
    runtime_platform_arch5162_obj(runtime_platform_arch5162)
    runtime_platform_910B_obj(runtime_platform_910B)
    runtime_platform_kirin_obj(runtime_platform_kirin)
    include(${RUNTIME_CMAKE_DIR}/v200.cmake)
    include(${RUNTIME_CMAKE_DIR}/runtime.cmake)
    include(${RUNTIME_CMAKE_DIR}/cmodel.cmake)
endif()
