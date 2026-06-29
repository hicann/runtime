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
#include "base.hpp"
#include "driver/ascend_hal.h"
#include "runtime.hpp"
#include "runtime/base.h"
#include "runtime/mem.h"
#include "runtime/rt_inner_mem.h"
#include "npu_driver.hpp"
#include "api.hpp"

namespace cce {
namespace runtime {

constexpr int32_t RT_INVALID_NUMA_NODE_ID = -1;

struct MemsetCallbackStruct {
    void *ptr;
    uint64_t destMax;
    uint32_t val;
    uint64_t cnt;
};

struct rtMemcpyCallbackParam {
    void *dst;
    uint64_t destMax;
    const void *src;
    uint64_t cnt;
    rtMemcpyKind_t kind;
    bool checkKind;
    Stream* stm;
};

struct PrefetchParams {
    DVdeviceptr ptr;
    struct drv_uvm_location location;
    size_t size;
    uint32_t flags;
};

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
    static void MemcpyAsyncCallback(void *userData);

    static bool IsUvmMem(const void * const ptr, const uint64_t cnt);
    static void CreateMemcpyCallbackParam(void * const dst, const uint64_t destMax, const void * const src, const uint64_t cnt,
    const rtMemcpyKind_t kind, bool checkKind, Stream * const curStm, rtMemcpyCallbackParam* memcpyCallbackParam);

    // UVM Prefetch
    static void PrefetchCallbackWrapper(void *userData);
    static void PrefetchBatchCallbackWrapper(void *userData);
    static int32_t ConvertUvmLocIdForHostNumaType(drv_uvm_location_type drvUvmLocType, int32_t oriDrvUvmLocId);
    static rtError_t GetCurrentThreadNumaNode(int32_t &currentNumaNode);
    static drv_uvm_location_type ConvertUvmLocTypeToDrvUvmLocType(rtMemManagedLocationType const uvmLocType);
    static rtError_t ConvertUvmLocationStruct(drv_uvm_location& drvUvmLoc, rtMemManagedLocation& memManagedLoc);

    template <typename T>
    static rtError_t FillIntParaIntoMemBuffer(const T intPara, uint8_t *const memBuffer, size_t memBufferSize, size_t& offset)
    {
        NULL_PTR_RETURN_NOLOG(memBuffer, RT_ERROR_INVALID_VALUE);
        COND_RETURN_WITH_NOLOG((memBufferSize == 0), RT_ERROR_INVALID_VALUE);
        COND_RETURN_WITH_NOLOG(((offset >= memBufferSize) || (offset + sizeof(T) >= memBufferSize)),
            RT_ERROR_INVALID_VALUE);
        T* tmpPtr = RtPtrToPtr<T*>(memBuffer + offset);
        *tmpPtr = intPara;
        offset += sizeof(T);
        return RT_ERROR_NONE;
    }
};

}  // namespace runtime
}  // namespace cce

#endif  // CCE_RUNTIME_UVM_CALLBACK_HPP