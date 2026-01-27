# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
include_directories(${OPEN_SOURCE_DIR}/boost-1.87.0)
include_directories(${OPEN_SOURCE_DIR}/mockcpp_src/include)
##################################################################################################
add_executable(runtime_utest_api_david
    ${runtimeut_david_src_list}
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_standard_soc.cc
    stub/hal_stub.cc
    main.cc
    rt_utest_david.cc
    rt_utest_arg_manage_david.cc
    rt_utest_ub_api.cc
    rt_utest_api_david.cc
    rt_utest_context_david.cc
    rt_utest_macro_value.cc
    )

target_compile_definitions(runtime_utest_api_david PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtime_utest_api_david PRIVATE
    $<BUILD_INTERFACE:runtime_utest_intf_pub>
    -lgcov
    -Wl,--whole-archive
     runtime_ut_stub_static_lib
     runtime_ut_david_static_lib
    -Wl,--no-whole-archive
)
##################################################################################################

###################################################################################################
add_executable(runtime_utest_task_david
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_standard_soc.cc
    stub/hal_stub.cc
    main.cc
    rt_utest_david_task_recycle.cc
    rt_utest_david_task_send.cc
    rt_utest_david_task.cc
    rt_utest_david_event.cc
    rt_utest_david_stream.cc
    rt_utest_david_elf.cc
    rt_utest_david_device.cc
    rt_utest_david_context.cc
    rt_utest_stream_ub.cc
    rt_utest_dcache_lock_david.cc
    rt_utest_david_customer_stack_size.cc
)

target_compile_definitions(runtime_utest_task_david PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtime_utest_task_david PRIVATE
    $<BUILD_INTERFACE:runtime_utest_intf_pub>
    -Wl,--whole-archive
    -lgcov
    runtime_ut_stub_static_lib
    runtime_ut_david_static_lib
    -Wl,--no-whole-archive
)
###################################################################################################

###################################################################################################
add_executable(runtime_utest_xpu
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_standard_soc.cc
    stub/hal_stub.cc
    stub/xpu_stub.cc
    main.cc
    tprt/rt_utest_xpu_tprt_worker.cc
    tprt/rt_utest_xpu_tprt_sqhandle.cc
    tprt/rt_utest_xpu_tprt_cqhandle.cc
    tprt/rt_utest_xpu_tprt_device.cc
    tprt/rt_utest_xpu_tprt.cc
    tprt/rt_utest_xpu_tprt_log.cc
    xpu/rt_utest_xpu_launch.cc
    xpu/rt_utest_xpu_argmanage.cc
    xpu/rt_utest_xpu_argloader.cc
    xpu/rt_utest_xpu_pool.cc
    xpu/rt_utest_xpu_task.cc
    xpu/rt_utest_xpu_recycle.cc
    xpu/rt_utest_xpu_stream_sqcq_manage.cc
    xpu/rt_utest_xpu_stream.cc
    xpu/rt_utest_xpu_context.cc
    xpu/rt_utest_xpu_kernel.cc
    xpu/rt_utest_xpu_stream_synchronize.cc
    xpu/rt_utest_xpu_device.cc
    xpu/rt_utest_xpu_runtime.cc
)

target_include_directories(
    runtime_utest_xpu PUBLIC 
    ${TOP_DIR}/src/runtime/tprt/inc/external
    ${TOP_DIR}/src/runtime/tprt/feature/inc
    ${TOP_DIR}/abl/slog/inc
    ${TOP_DIR}/abl/mmpa/inc
    ${TOP_DIR}/abl/libc_sec/include
    stub
)

target_compile_definitions(runtime_utest_xpu PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtime_utest_xpu PRIVATE
    $<BUILD_INTERFACE:runtime_utest_intf_pub>
    -Wl,--whole-archive
    runtime_ut_stub_static_lib
    runtime_ut_david_static_lib
    -Wl,--no-whole-archive
)

###################################################################################################