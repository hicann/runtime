# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set(SRC_PATH
    ${AICPU_SCHED_PATH}/aicpu_processer
)
set(BASE_DIR ${CMAKE_CURRENT_SOURCE_DIR})

set(ENGINE_SRC_FILES
    ${SRC_PATH}/aicpu_processer.cc
    ${SRC_PATH}/ae_so_manager.cc
    ${SRC_PATH}/ae_kernel_lib_manager.cc
    ${SRC_PATH}/ae_kernel_lib_fwk.cc
    ${SRC_PATH}/ae_kernel_lib_aicpu.cc
    ${SRC_PATH}/ae_kernel_lib_aicpu_kfc.cpp
    ${SRC_PATH}/stub/aicpu_context.cpp
    ${SRC_PATH}/ae_kernel_lib_base.cc
)
set(local_lib_cpu_src_files
    aicpu_engine_ut.cc
    # ae_kernel_lib_aicpu_ut.cc #fixme
    ae_kernel_lib_aicpu_kfc_ut.cc
    ae_kernel_lib_fwk_ut.cc
    ae_so_manager_ut.cc
    stub.cc
)

set(local_lib_cpu_inc_path
    ${SRC_PATH}
    ${AICPU_SCHED_PATH}/aicpu_sharder
    ${AICPU_SCHED_PATH}
    ${RUNTIME_DIR}/pkg_inc/profiling
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/common
    ${RUNTIME_DIR}/pkg_inc/base
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched/aicpu_schedule
    ${RUNTIME_DIR}/include/driver
    ${RUNTIME_DIR}/src/dfx/msprof/inc/toolchain
)

set(test_so_code_simple
    engine_ut_test_aicpu.cc
)

add_executable(aicpu_processer_utest
    main.cc
    testframe/stub/slog_stub.cc
    ${ENGINE_SRC_FILES}
    ${local_lib_cpu_src_files}
    ${test_so_code_simple}
)

target_link_libraries(aicpu_processer_utest PRIVATE
    c_sec
    $<BUILD_INTERFACE:intf_aicpu_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    -ldl
    pthread
    c_sec_headers
)

target_include_directories(aicpu_processer_utest PRIVATE
    ${local_lib_cpu_inc_path}
)

target_compile_definitions(aicpu_processer_utest PRIVATE
    ${THE_TEST_PRODUCT_CFLAG}
    __AICPU_UT_TEST__
    DAVINCI_MINI
    DEBUG
)