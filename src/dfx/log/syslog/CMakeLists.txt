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
project(toolchain_syslog)

get_filename_component(TOOLAHCIN_LOG_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../" ABSOLUTE)

add_subdirectory(slog)
add_subdirectory(sklog)
add_subdirectory(log_daemon)
if (${PRODUCT_SIDE} STREQUAL "host")
add_subdirectory(msnpureport)
endif ()
if ((${PRODUCT} STREQUAL "ascend610") OR (${PRODUCT} STREQUAL "ascend610Lite") OR (${PRODUCT} STREQUAL "ascend610Liteesl"))
add_subdirectory(log_proxy)
endif ()
