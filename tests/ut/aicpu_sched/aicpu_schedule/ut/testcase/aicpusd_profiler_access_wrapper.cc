/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <cstring>
#include <unistd.h>

namespace {
constexpr const char* kHiperfLibPath = "/usr/lib64/libhiperf_executor.so";
int g_hiperfAccessResult = -1;
} // namespace

extern "C" void AicpusdSetHiperfAccessResult(const int result) { g_hiperfAccessResult = result; }

extern "C" int __real_access(const char* pathname, int mode);

extern "C" int __wrap_access(const char* pathname, int mode)
{
    if ((pathname != nullptr) && (std::strcmp(pathname, kHiperfLibPath) == 0)) {
        return g_hiperfAccessResult;
    }
    return __real_access(pathname, mode);
}
