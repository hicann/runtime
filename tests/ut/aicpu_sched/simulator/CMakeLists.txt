# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
# 通用 esched 仿真测试平台
#
# 为 aicpu_sched / queue_schedule 等 esched 事件驱动模块提供统一的 HAL/DRV 打桩 + 可编程事件注入。
# 分层：
#   L1 符号接管  hal_esched_shim.cpp 导出与 pkg_inc/driver 同名 esched 强符号，链接期接管 HAL 弱符号
#   L2 仿真引擎  EschedSimEngine 事件队列（wait 出队 / submit 入队+捕获 / ack 捕获）
#   L3 测试 API  SimPlatform 门面、EventInfoBuilder、HwtsTsTaskBuilder
#   L4 测试用例  各模块 testcase，从 ComputeProcessMain 入口切入
# 依赖方向单向：L4→L3→L2←L1。L2 纯 C++ 标准库，零测试框架依赖。
#
# 构建产物：
#   sim_platform_inc (INTERFACE)  测试面公开头，供 testcase #include "sim/sim_platform.h"
#   esched_sim (OBJECT)           L1 shim + L2 引擎，各模块 UT 以 $<TARGET_OBJECTS:esched_sim> 链入
#   esched_sim_selftest (可执行)  平台自测，14 用例，CI 回归基线
#
# 接入方式（任一 esched 模块 UT）：
#   add_executable(<your_ut> ${被测源码} ${testcase} ${精简c_stub} $<TARGET_OBJECTS:esched_sim>)
#   target_link_libraries(<your_ut> PRIVATE sim_platform_inc <模块原有依赖>)
# 注意：被测模块的 c_stub 必须移除同名 esched 桩，否则与平台符号竞争导致引擎被旁路。
#
# 构建运行：
#   bash tests/build_ut.sh -u -t esched_sim_selftest && ./build/tests/ut/aicpu_sched/simulator/esched_sim_selftest
#   bash tests/build_ut.sh -u -t aicpu_sched_sim_utest && ./build/tests/ut/aicpu_sched/aicpu_schedule/ut/aicpu_sched_sim_utest
# -----------------------------------------------------------------------------------------------------------

add_library(sim_platform_inc INTERFACE)
target_include_directories(sim_platform_inc INTERFACE
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${RUNTIME_DIR}/pkg_inc/driver
    ${RUNTIME_DIR}/include
    ${CMAKE_BINARY_DIR}/libc_sec/source/include
)

add_library(esched_sim OBJECT
    core/esched_sim_engine.cpp
    shims/hal_esched_shim.cpp
)

target_compile_definitions(esched_sim PRIVATE
    _GLIBCXX_USE_CXX11_ABI=0
)
target_compile_options(esched_sim PRIVATE
    $<$<COMPILE_LANGUAGE:CXX>:-std=c++17>
    -fno-inline
    $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
    $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -fno-omit-frame-pointer -static-libasan -fsanitize=undefined -static-libubsan>
)
target_link_libraries(esched_sim PRIVATE
    sim_platform_inc
    c_sec
)

add_executable(esched_sim_selftest
    test/esched_sim_engine_test.cpp
    $<TARGET_OBJECTS:esched_sim>
)
target_compile_definitions(esched_sim_selftest PRIVATE
    _GLIBCXX_USE_CXX11_ABI=0
)
target_compile_options(esched_sim_selftest PRIVATE
    $<$<COMPILE_LANGUAGE:CXX>:-std=c++17>
    -fno-inline
    $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
    $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -fno-omit-frame-pointer -static-libasan -fsanitize=undefined -static-libubsan>
)
target_link_options(esched_sim_selftest PRIVATE
    $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
    $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -static-libasan -fsanitize=undefined -static-libubsan>
)
target_link_libraries(esched_sim_selftest PRIVATE
    sim_platform_inc
    GTestShared::gtest
    pthread
    c_sec
)

add_custom_target(esched_sim_ut DEPENDS esched_sim_selftest)

