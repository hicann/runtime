/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef TASK_TEST_HELPER_H
#define TASK_TEST_HELPER_H

#include <vector>
#include "runtime/mem.h"
#include "kernel/kernel.hpp"

namespace cce {
namespace runtime {

inline Kernel* CreateTestKernel(rtKernelAttrType type) { return new Kernel("", 0ULL, nullptr, type, 0); }

inline Kernel* CreateTestKernelWithMixType(rtKernelAttrType type, uint8_t mixType)
{
    Kernel* kernel = new Kernel("", 0ULL, nullptr, type, 0);
    if (kernel != nullptr) {
        kernel->SetMixType(mixType);
    }
    return kernel;
}

class Stream;
class ApiImpl;

namespace ut {
namespace stream_mem_op {
struct LaunchRecord {
    uint32_t operation;
    const void* address;
    uint64_t value;
    uint32_t flag;
    Stream* stream;
};
struct StateData {
    std::vector<LaunchRecord> launches;
    size_t failAt = SIZE_MAX;
};

inline StateData& State()
{
    static StateData state;
    return state;
}

inline rtError_t Record(uint32_t operation, const void* address, uint64_t value, uint32_t flag, Stream* stream)
{
    auto& state = State();
    state.launches.push_back({operation, address, value, flag, stream});
    return (state.launches.size() - 1U == state.failAt) ? RT_ERROR_DRV_ERR : RT_ERROR_NONE;
}

inline rtError_t Write(const void* address, uint64_t value, uint32_t flag, Stream* stream)
{
    return Record(RT_STREAM_MEM_OP_VALUE_WRITE, address, value, flag, stream);
}

inline rtError_t Wait(const void* address, uint64_t value, uint32_t flag, Stream* stream)
{
    return Record(RT_STREAM_MEM_OP_VALUE_WAIT, address, value, flag, stream);
}

inline rtError_t DeviceAttributes(ApiImpl* impl, const void* address, rtPtrAttributes_t* attributes)
{
    (void)impl;
    (void)address;
    attributes->location.type = RT_MEMORY_LOC_DEVICE;
    return RT_ERROR_NONE;
}

inline rtStreamBatchMemOpParams_t Param(bool write, uint64_t value = 17U, uint32_t flag = 0U)
{
    rtStreamBatchMemOpParams_t param{};
    if (write) {
        param.valueWrite = {RT_STREAM_MEM_OP_VALUE_WRITE, reinterpret_cast<void*>(0x20000000ULL), value, flag};
    } else {
        param.valueWait = {RT_STREAM_MEM_OP_VALUE_WAIT, reinterpret_cast<void*>(0x20000000ULL), value, flag};
    }
    return param;
}
} // namespace stream_mem_op
} // namespace ut

} // namespace runtime
} // namespace cce

#endif