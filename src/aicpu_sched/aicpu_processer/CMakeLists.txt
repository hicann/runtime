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

set(PRODUCT_TYPE "DEFAULT")
set(lhisi_product false)

set (aicpu_processer_files
    aicpu_processer.cc
    ae_so_manager.cc
    ae_kernel_lib_manager.cc
    ae_kernel_lib_base.cc
    ae_kernel_lib_fwk.cc
    ae_kernel_lib_aicpu.cc
    ae_kernel_lib_aicpu_kfc.cpp
)
set(inc_path
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/../aicpu_sharder
    ${CMAKE_CURRENT_SOURCE_DIR}/..
    ${RUNTIME_DIR}/pkg_inc/profiling
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/common
    ${RUNTIME_DIR}/pkg_inc/base
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/aicpu_schedule
    ${RUNTIME_DIR}/include/driver
    ${RUNTIME_DIR}/src/dfx/msprof/inc/toolchain
)

add_library(aicpu_processer SHARED
    ${aicpu_processer_files}
)

target_include_directories(aicpu_processer PRIVATE
    ${inc_path}
)

target_link_libraries(aicpu_processer PRIVATE
    $<BUILD_INTERFACE:intf_pub_cxx17>
    PUBLIC c_sec
    aicpu_prof
    aicpu_sharder
    $<BUILD_INTERFACE:c_sec_headers>
)

target_compile_options(aicpu_processer PRIVATE
    $<$<NOT:$<STREQUAL:${CMAKE_SYSTEM_PROCESSOR},x86_64>>:-march=armv8-a>
    -O2
    -fstack-protector
    -fvisibility=hidden
    -fvisibility-inlines-hidden
    -Werror -Wall
    -flto
    -fdata-sections
    -ffunction-sections
    ${ae_local_cflags}
    $<$<STREQUAL:${RESERVED_SYMBOL},true>:-g>
)

target_link_options(aicpu_processer PRIVATE
    -flto
    -Wl,--gc-sections
)

target_compile_definitions(aicpu_processer PRIVATE
    RUN_ON_AICPU
    AE_PERF_LOG
    AICPU_PROFILING
)

set(INSTALL_LIBRARY_DIR lib)
if (AOSCORE_LLVM_MUSL)
    add_definitions(-D_AOSCORE_)
endif()

install(TARGETS aicpu_processer OPTIONAL
    EXPORT aicpu_processer-targets
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)
