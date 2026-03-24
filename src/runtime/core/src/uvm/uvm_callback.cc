/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "uvm_callback.hpp"
#include "base.hpp"
#include "npu_driver.hpp"

namespace cce {
namespace runtime {

void UvmCallback::MemsetAsyncCallback(void *fnData)
{
    NULL_PTR_RETURN_DIRECTLY(fnData);
    auto *params = static_cast<MemsetCallbackStruct*>(fnData);
    rtError_t ret = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER)->
        MemSetSync(params->ptr, params->destMax, params->val, params->cnt);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "MemSetAsync failed when calling MemSetSync, ret is %u.", static_cast<uint32_t>(ret));
    }
    delete params;
    return;
}

bool UvmCallback::IsUvmMem(const void * const ptr, const uint64_t cnt)
{
    rtMemLocationType locationStart;
    rtMemLocationType realLocationStart;
    rtError_t ret = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER)->PtrGetRealLocation(ptr, locationStart, realLocationStart);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Failed to get mem start location, ret = %u.", static_cast<uint32_t>(ret));
        return false;
    }

    rtMemLocationType locationEnd;
    rtMemLocationType realLocationEnd;
    ret = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER)->PtrGetRealLocation(
        static_cast<const void *>((static_cast<const char_t*>(ptr)) + cnt), locationEnd, realLocationEnd);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Failed to get mem end location, ret = %u.", static_cast<uint32_t>(ret));
        return false;
    }

    if ((locationStart == RT_MEMORY_LOC_UVM_MANAGED) && (locationEnd == RT_MEMORY_LOC_UVM_MANAGED)) {
        return true;
    }

    return false;
}

}
}