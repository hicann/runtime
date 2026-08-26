# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

# stub_external_deps UT
# 专测 src/tsd/stub/stub_external_deps.cpp 桩文件行为。
# 与 tsd_client_utest 的关键区别：不链接 platform 库，直接编译桩文件，
# 使桩的空实现代码路径被执行，固化返回值契约。

add_executable(stub_external_deps_utest
    ${TSD_SRC_PATH}/stub/stub_external_deps.cpp
    stub_external_deps_utest.cpp
    ${CMAKE_CURRENT_LIST_DIR}/../common/main.cpp
)

target_include_directories(stub_external_deps_utest PRIVATE
    ${RUNTIME_DIR}/pkg_inc/platform/
)

target_link_libraries(stub_external_deps_utest PRIVATE
    intf_tsd_llt_pub
)
