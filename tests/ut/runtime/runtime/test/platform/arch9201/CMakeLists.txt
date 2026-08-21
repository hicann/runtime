# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
##################################################################################################
add_executable(runtime_utest_arch9201
    ${runtimeut_david_src_list}
    ${TOP_DIR}/src/runtime/driver/npu_driver.cc
    ${TOP_DIR}/src/runtime/driver/npu_driver_standard_soc.cc
    stub/hal_stub.cc
    main.cc
    rt_utest_arch9201_error_proc.cc
    rt_utest_arch9201_task.cc
    rt_utest_arch9201_task_profiling.cc
    rt_utest_arch9201_kernel.cc
    rt_utest_arch9201_ost.cc
)

target_compile_definitions(runtime_utest_arch9201 PUBLIC
    TEMP_PERFORMANCE
    TEMP_PERFORMANCE_NOT_OUTPUT
)

target_link_libraries(runtime_utest_arch9201 PRIVATE
    $<BUILD_INTERFACE:runtime_utest_intf_pub>
    -lgcov
    -Wl,--whole-archive
     runtime_ut_stub_static_lib
     runtime_ut_david_static_lib
    -Wl,--no-whole-archive
)
