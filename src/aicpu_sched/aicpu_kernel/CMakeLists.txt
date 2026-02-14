# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(BASE_DIR ${CMAKE_CURRENT_SOURCE_DIR})

add_library(kernel_load_platform SHARED
    load_platform_info.cpp
)

target_include_directories(kernel_load_platform PRIVATE
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/common
)

target_link_libraries(kernel_load_platform PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:slog_headers>
    -Wl,--no-as-needed
    platform_static
    platform_headers
    c_sec
    -ldl
    -Wl,--as-needed
)

target_compile_definitions(kernel_load_platform PRIVATE
    _FORTIFY_SOURCE=2
    google=ascend_private
)

target_compile_options(kernel_load_platform PRIVATE
    -O2
    -std=c++17
    -fstack-protector-all
    -fvisibility=hidden
    -fvisibility-inlines-hidden
    -frename-registers
    -fpeel-loops
)

target_link_options(kernel_load_platform PRIVATE
    -Wl,-z,relro,-z,now
    -Wl,-Bsymbolic
)

install(TARGETS kernel_load_platform OPTIONAL
    LIBRARY DESTINATION lib
)