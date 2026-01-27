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
set(RUNTIME_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../../..)

set(INSTALL_LIBRARY_DIR lib)
if (AOSCORE_LLVM_MUSL)
    add_definitions(-D_AOSCORE_)
endif()

add_library(aicpu_sharder SHARED
    aicpu_context.cc
    aicpu_pulse.cc
    aicpu_sharder.cc
    aicpu_async_event.cc
    aicpu_timer.cpp
    aicpu_error_log.cpp
)

target_link_libraries(aicpu_sharder PRIVATE
    $<BUILD_INTERFACE:intf_pub_cxx17>
    PUBLIC 
    c_sec
    -rdynamic
    $<BUILD_INTERFACE:c_sec_headers>
)

target_compile_options(aicpu_sharder PRIVATE
    -O2
    -std=c++11
   -fno-common
   $<$<STREQUAL:${RESERVED_SYMBOL},true>:-g>
)

target_include_directories(aicpu_sharder PRIVATE
    ${RUNTIME_DIR}/include
    ${RUNTIME_DIR}/pkg_inc/base
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/aicpu_schedule
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched
)

install(TARGETS aicpu_sharder OPTIONAL
    EXPORT aicpu_sharder-targets
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)
