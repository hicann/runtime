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

set(aicpu_prof_common_src_file
    ${CMAKE_CURRENT_SOURCE_DIR}/profiling_adp.cc
    ${CMAKE_CURRENT_SOURCE_DIR}/prof_so_manager.cpp
)

set(inc_path_
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/aicpu_schedule
    ${RUNTIME_DIR}/src/aicpu_sched
    ${RUNTIME_DIR}/pkg_inc/base
    ${RUNTIME_DIR}/src/dfx/msprof/inc/toolchain
    ${RUNTIME_DIR}/pkg_inc/profiling
)

add_library(aicpu_prof SHARED
    ${aicpu_prof_common_src_file}
)

target_include_directories(aicpu_prof PRIVATE
    ${inc_path_}
)

target_link_libraries(aicpu_prof PRIVATE
    $<BUILD_INTERFACE:intf_pub_cxx17>
    -ldl
    $<$<NOT:$<STREQUAL:${TARGET_SYSTEM_NAME},Android>>:-lrt>
    PUBLIC c_sec
    -rdynamic
    $<BUILD_INTERFACE:c_sec_headers>
)

set(X86_AARCH64_ON_HOST not_x86_or_aarch64_on_host)
if ((CMAKE_HOST_SYSTEM_PROCESSOR STREQUAL x86_64) AND (PRODUCT_SIDE STREQUAL host))
    set(X86_AARCH64_ON_HOST x86_or_aarhc64_on_host)
endif()

target_compile_definitions(aicpu_prof PRIVATE
    $<$<NOT:$<STREQUAL:${X86_AARCH64_ON_HOST},x86_or_aarhc64_on_host>>:RUN_ON_AICPU>
    OS_TYPE=0
)

target_compile_options(aicpu_prof PRIVATE
    -O2
    -std=c++11
    -D_FORTIFY_SOURCE=2
    -ftrapv
    $<$<STREQUAL:${RESERVED_SYMBOL},true>:-g>
    -fPIC
)

set(INSTALL_LIBRARY_DIR lib)
if (AOSCORE_LLVM_MUSL)
    add_definitions(-D_AOSCORE_)
endif()

install(TARGETS aicpu_prof OPTIONAL
    EXPORT aicpu_prof-targets
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)