/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "api_impl.hpp"
#include "base.hpp"
#include "osal.hpp"
#include "profiler.hpp"
#include "npu_driver.hpp"

namespace cce {
namespace runtime {
rtError_t ApiImpl::MemManagedAdvise(const void *const ptr, uint64_t size, uint16_t advise, rtMemManagedLocation location)
{
    RT_LOG(RT_LOG_DEBUG, "MemManaged advise, size=%" PRIu64 ", advise=%u.", size, advise);
    Context *ctx = CurrentContext();
    CHECK_CONTEXT_VALID_WITH_RETURN(ctx, RT_ERROR_CONTEXT_NULL);

    return ctx->Device_()->Driver_()->MemManagedAdvise(ptr, size, advise, location);
}

rtError_t ApiImpl::MemManagedGetAttr(rtMemManagedRangeAttribute attribute, const void *ptr, size_t size, void *data, size_t dataSize)
{
    RT_LOG(RT_LOG_DEBUG, "get memory attribute.");
    TIMESTAMP_NAME(__func__);

    Context * const curCtx = CurrentContext();
    Driver *curDrv = nullptr;
    if (ContextManage::CheckContextIsValid(curCtx, true)) {
        const ContextProtect cp(curCtx);
        curDrv = curCtx->Device_()->Driver_();
    } else {
        curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    }
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
    return curDrv->MemManagedGetAttr(attribute, ptr, size, data, dataSize);
}

rtError_t ApiImpl::MemManagedGetAttrs(rtMemManagedRangeAttribute *attributes, size_t numAttributes, const void *ptr, size_t size, void **data, size_t *dataSizes)
{
    RT_LOG(RT_LOG_DEBUG, "get memory attributes.");
    TIMESTAMP_NAME(__func__);
    Context * const curCtx = CurrentContext();
    Driver *curDrv = nullptr;

    const bool isContextValid = ContextManage::CheckContextIsValid(curCtx, true);
    if (!isContextValid) {
        curDrv = Runtime::Instance()->driverFactory_.GetDriver(NPU_DRIVER);
    } else {
        const ContextProtect cp(curCtx);
        curDrv = curCtx->Device_()->Driver_();
    }
    NULL_PTR_RETURN_MSG(curDrv, RT_ERROR_DRV_NULL);
    return curDrv->MemManagedGetAttrs(attributes, numAttributes, ptr, size, data, dataSizes);
}
}
}