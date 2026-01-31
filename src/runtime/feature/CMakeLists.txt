# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
include(${CMAKE_CURRENT_SOURCE_DIR}/../../inc/runtime/runtime_headers.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/platform.cmake)
if ("${PRODUCT}" STREQUAL "ascend031")
    runtime_platform_tiny_obj(runtime_platform_tiny)
    include(${CMAKE_CURRENT_SOURCE_DIR}/tiny.cmake)
else()
    runtime_platform_others_obj(runtime_platform_others)
    runtime_platform_tiny_obj(runtime_platform_tiny)
    runtime_platform_910B_obj(runtime_platform_910B)
    runtime_platform_kirin_obj(runtime_platform_kirin)
    include(${CMAKE_CURRENT_SOURCE_DIR}/v200.cmake)
    include(${CMAKE_CURRENT_SOURCE_DIR}/runtime.cmake)
    include(${CMAKE_CURRENT_SOURCE_DIR}/cmodel.cmake)
endif()