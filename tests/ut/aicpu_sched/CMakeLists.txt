# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set(AICPU_SCHED_PATH
    ${TOP_DIR}/src/aicpu_sched
)

add_library(intf_aicpu_llt_pub INTERFACE)
target_include_directories(intf_aicpu_llt_pub INTERFACE
  ${OPEN_SOURCE_DIR}/mockcpp_src/include
  ${OPEN_SOURCE_DIR}/boost-1.87.0
)
target_compile_definitions(intf_aicpu_llt_pub INTERFACE
  _GLIBCXX_USE_CXX11_ABI=0
)
target_compile_options(intf_aicpu_llt_pub INTERFACE
  $<$<COMPILE_LANGUAGE:CXX>:-std=c++17>
  -fpermissive
  -Wall
  # -Werror
  -fsanitize=undefined
  -static-libubsan
  -fno-sanitize=alignment
)
target_link_options(intf_aicpu_llt_pub INTERFACE
  -fsanitize=undefined
)
target_link_libraries(intf_aicpu_llt_pub INTERFACE
    GTest::gtest
    ${OPEN_SOURCE_DIR}/mockcpp/lib/libmockcpp.a
)

add_subdirectory(aicpu_cust_schedule/ut)
add_subdirectory(aicpu_processer/ut)
add_subdirectory(aicpu_prof/ut)
add_subdirectory(aicpu_sharder/ut)
add_subdirectory(aicpu_schedule/ut)
add_subdirectory(aicpu_kernel/ut)

add_subdirectory(aicpu_processer/st)
add_subdirectory(aicpu_prof/st)
add_subdirectory(aicpu_sharder/st)
add_subdirectory(aicpu_schedule/st)

set(AICPU_SCHED_TARGET
  aicpu_custom_schedule_utest
  aicpu_custom_schedule_utest_dc
  aicpu_custom_schedule_utest_open
  aicpu_processer_utest
  aicpu_prof_llt_ut
  aicpu_aicpuschedule_utest
  aicpu_aicpuschedule_utest_host_cpu
  aicpu_thread_datadump_utest
  aicpu_aicpuschedule_utest_open
  aicpu_sharder_utest
  aicpu_kernel_utest

  # aicpu_aicpuschedule_stest
  # aicpu_aicpuschedule_stest_host_cpu
  # aicpu_aicpuschedule_stest_hostaicpu
  # aicpu_thread_datadump_stest
  # aicpu_processer_stest
  # aicpu_prof_llt_st
  # aicpu_sharder_st
)
add_custom_target(aicpu_sched_ut DEPENDS ${AICPU_SCHED_TARGET})