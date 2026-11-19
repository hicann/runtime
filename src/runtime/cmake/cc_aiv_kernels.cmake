# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
include_guard(GLOBAL)

# CC AIV 设备核（标准 AscendC fatbin，当前只适配 A5）的构建与依赖挂载。
# 只在真正出包的构建处 include：cmake/runtime.cmake（runtime_v100）、cmake/v200.cmake（runtime_v200）。
# UT 裁剪构建不引入；其余完整/出包构建（含 superbuild 直接 cmake）缺省 ON。
# 显式 -DCC_BUILD_AIV_KERNELS=OFF 可关闭（关闭后 CC 的 KeystreamXor 无 AIV 核可用）。
# 上面的 include_guard(GLOBAL) 保证本文件即使被两个变体各 include 一次，子工程也只引入一次。
if(ENABLE_UT)
    set(CC_BUILD_AIV_KERNELS OFF)
endif()
option(CC_BUILD_AIV_KERNELS "Build the CC AIV fatbin together with the runtime" ON)

if(CC_BUILD_AIV_KERNELS)
    add_subdirectory(
        ${RUNTIME_FEATURE_DIR}/cc_manager/crypto/device
        ${CMAKE_BINARY_DIR}/cc_aiv_kernels)
    message(STATUS "CC AIV kernels: ENABLED (CC_BUILD_AIV_KERNELS=ON), "
        "AIV fatbin will be built and installed into <libdir>/ops")
else()
    message(STATUS "CC AIV kernels: DISABLED (CC_BUILD_AIV_KERNELS=OFF), "
        "runtime will not ship the CC AIV fatbins (CC KeystreamXor unavailable at runtime)")
endif()
