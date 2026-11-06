# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

################ mstx_resource_name_utest ################
add_executable(mstx_resource_name_utest
    testcase/main.cpp
    testcase/mstx_resource_name_utest.cpp
)

target_include_directories(mstx_resource_name_utest PRIVATE
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/msproftx/mstx/inc
    ${MSPROF_SOURCE_DIR}/dvvp/msprof/msproftx/mstx/inc/msprof
)

target_compile_options(mstx_resource_name_utest PRIVATE
    -g
    -pipe
    -fno-access-control
)

target_compile_definitions(mstx_resource_name_utest PRIVATE
    __PROF_LLT
    google=ascend_private
)

target_link_libraries(mstx_resource_name_utest PRIVATE
    $<BUILD_INTERFACE:msprof_utestonetrack_pub>
    c_sec
)

set_target_properties(mstx_resource_name_utest
    PROPERTIES
    OUTPUT_NAME mstx_resource_name_utest
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)
