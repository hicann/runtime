/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_UVM_CALLBACK_HPP
#define CCE_RUNTIME_UVM_CALLBACK_HPP

#include "runtime.hpp"
#include "runtime/base.h"

namespace cce {
namespace runtime {
typedef struct MemsetCallbackStruct {
    void *ptr;
    uint64_t destMax;
    uint32_t val;
    uint64_t cnt;
} MemsetCallbackStruct;

class UvmCallback {
public :
    UvmCallback() = default;
    virtual ~UvmCallback() = default;

    UvmCallback(const UvmCallback &) = delete;
    UvmCallback &operator=(const UvmCallback &) = delete;
    UvmCallback(UvmCallback &&) = delete;
    UvmCallback &operator=(UvmCallback &&) = delete;

    // UVM Callback
    static void MemsetAsyncCallback(void *fnData);

    static bool IsUvmMem(const void * const ptr, const uint64_t cnt);
};    
}
}

#endif  // CCE_RUNTIME_UVM_CALLBACK_HPP