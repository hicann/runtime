# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
set(TSD_SRC_PATH
    ${TOP_DIR}/src/tsd
)

add_library(intf_tsd_llt_pub INTERFACE)
target_include_directories(intf_tsd_llt_pub INTERFACE
  ${OPEN_SOURCE_DIR}/mockcpp_src/include
  ${OPEN_SOURCE_DIR}/boost-1.87.0
)
target_compile_definitions(intf_tsd_llt_pub INTERFACE
  _GLIBCXX_USE_CXX11_ABI=0
)
target_compile_options(intf_tsd_llt_pub INTERFACE
  $<$<COMPILE_LANGUAGE:CXX>:-std=c++17>
  -fpermissive
  -Wall
  -fsanitize=undefined
  -static-libubsan
  -fno-sanitize=alignment
)
target_link_options(intf_tsd_llt_pub INTERFACE
  -fsanitize=undefined
)
target_link_libraries(intf_tsd_llt_pub INTERFACE
    GTest::gtest
    ${OPEN_SOURCE_DIR}/mockcpp/lib/libmockcpp.a
)

add_subdirectory(tsdclient)
set(TSD_UT_TARGET
  tsd_client_utest
)
add_custom_target(tsd_ut DEPENDS ${TSD_UT_TARGET})