# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

cmake_minimum_required(VERSION 3.12)
project(toolchain_liblog)

get_filename_component(TOOLAHCIN_LOG_DIR "${CMAKE_CURRENT_SOURCE_DIR}/.." ABSOLUTE)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(LOG_COMMON_COMPILE_OPTIONS
    -Werror
    -Wall
    -Wextra
    -Wundef
    -Wunused
    -Wfloat-equal
    -Wshadow
)

add_subdirectory(slog)

# MODEXT_LOG_BUILD 由 modext CMakeLists 设置，标识当前为模块扩展构建上下文。
# 仅在 modext 构建时添加 mergeslog （模块扩展专有的日志合并库）。
if (MODEXT_LOG_BUILD)
    add_subdirectory(mergeslog)
endif ()
