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
include(${CMAKE_CURRENT_SOURCE_DIR}/../liteos_headers.cmake)
add_library(c_mmpa_headers INTERFACE)
target_include_directories(c_mmpa_headers INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/..>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/inc>
    $<$<STREQUAL:${TARGET_SYSTEM_NAME},LiteOS>:$<BUILD_INTERFACE:${NANO_LITEOS_HEADER_FILES_PATH}>>
    $<INSTALL_INTERFACE:include>
    $<INSTALL_INTERFACE:include/c_mmpa>
)

target_compile_definitions(c_mmpa_headers INTERFACE
  $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},LiteOS>,NANO_OS_TYPE=1,NANO_OS_TYPE=0>
)
target_include_directories(c_mmpa_headers INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/../stub/inc>
)

target_link_libraries(c_mmpa_headers INTERFACE
  c_sec_headers
)