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
set(runtime_raw_device_adpt_common_list
    ${TOP_DIR}/src/runtime/feature/src/device/raw_device_adpt_comm.cc
)

add_executable(runtime_utest_dc
    ${runtime_raw_device_adpt_common_list}
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_mem.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_queue.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_res.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_dcache_lock_opb.cpp
    ${TOP_DIR}/src/runtime/feature/src/drv/npu_driver_standard_soc.cc
    ${TOP_DIR}/src/runtime/feature/src/drv/v100/npu_driver.cc
    ${TOP_DIR}/src/runtime/feature/src/kernel/v100/kernel.cc
    ${TOP_DIR}/src/runtime/feature/src/task/v100/stub_task.cc
    stub/hal_stub.cc
    main.cc
    rt_utest_model_api.cc
    rt_utest_launch.cc
    rt_utest_api.cc
    rt_utest_context.cc
    rt_utest_macro_value.cc
    )

target_compile_definitions(runtime_utest_dc PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtime_utest_dc PRIVATE
    $<BUILD_INTERFACE:runtime_utest_intf_pub>
    -lgcov
    -Wl,--whole-archive
    runtimeut_src_static_lib
    runtime_ut_stub_static_lib
    -Wl,--no-whole-archive
)

include(CMakePackageConfigHelpers)