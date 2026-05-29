# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

include_directories(${CANN_3RD_LIB_PATH}/boost-1.87.0)
add_library(intf_qs_llt_pub INTERFACE)
target_include_directories(intf_qs_llt_pub INTERFACE
  ${CANN_3RD_LIB_PATH}/mockcpp_src/include
  ${CANN_3RD_LIB_PATH}/boost-1.87.0
)
target_compile_definitions(intf_qs_llt_pub INTERFACE
  _GLIBCXX_USE_CXX11_ABI=0
)
target_compile_options(intf_qs_llt_pub INTERFACE
  $<$<COMPILE_LANGUAGE:CXX>:-std=c++17>
  -fpermissive
  -Wall
  $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
  $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -fno-omit-frame-pointer -static-libasan -fsanitize=undefined -static-libubsan -fsanitize=leak -static-libtsan>
  $<$<STREQUAL: ${CMAKE_SYSTEM_PROCESSOR}, aarch64>:-falign-functions=32>
  -fno-inline
)
target_link_options(intf_qs_llt_pub INTERFACE
  $<$<BOOL:${ENABLE_GCOV}>:-fprofile-arcs -ftest-coverage>
  $<$<BOOL:${ENABLE_ASAN}>:-fsanitize=address -static-libasan -fsanitize=undefined  -static-libubsan -fsanitize=leak -static-libtsan>

)
target_link_libraries(intf_qs_llt_pub INTERFACE
    GTest::gtest
    ${CANN_3RD_LIB_PATH}/mockcpp/lib/libmockcpp.a
)
add_subdirectory(ut)
add_subdirectory(st)

set(QUEUE_SCHEDULE_UT_TARGET
  queue_schedule_main_ut
  queue_schedule_stub_ut
)
add_custom_target(queue_schedule_ut DEPENDS ${QUEUE_SCHEDULE_UT_TARGET})
