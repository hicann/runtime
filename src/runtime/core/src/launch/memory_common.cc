/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "memory_c.hpp"
#include "common/enum_to_string_utils.hpp"
#include "inner_thread_local.hpp"
#include "context.hpp"
#include "device.hpp"
#include "reduce_task.h"
#include "task.hpp"

namespace cce {
namespace runtime {

TIMESTAMP_EXTERN(rtReduceAsyncV2_part1);
TIMESTAMP_EXTERN(rtReduceAsyncV2_part2);

rtError_t ReduceAsyncV2(void * const dst, const void * const src, const uint64_t cpySize,
    const rtRecudeKind_t kind, const rtDataType_t type, Stream * const stm, void * const overflowAddr)
{
    rtError_t error;
    TIMESTAMP_BEGIN(rtReduceAsyncV2_part1);
    Device * const dev = stm->Device_();
    Driver * const devDrv = dev->Driver_();
    const uint32_t deviceId = dev->Id_();

    if (devDrv != nullptr) {
        rtDevCapabilityInfo capabilityInfo = {};
        error = dev->GetDeviceCapabilities(capabilityInfo);
        ERROR_RETURN_MSG_INNER(error, "Get chip capability failed, device_id=%u, retCode=%#x.",
            deviceId, error);

        const uint32_t sdmaReduceSupport = capabilityInfo.sdma_reduce_support;
        const uint32_t offset = static_cast<uint32_t>(type);
        RT_LOG(RT_LOG_INFO, "ReduceAsyncV2 sdma_reduce_support=0x%x.", sdmaReduceSupport);
        if (((sdmaReduceSupport >> offset) & 0x1U) == 0U) {
            RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1006, "Parameter type value " + DataTypeToString(type),
                "The current SoC does not support the reduction operation of this data type");
            return RT_ERROR_FEATURE_NOT_SUPPORT;
        }
    }
    TIMESTAMP_END(rtReduceAsyncV2_part1);

    TIMESTAMP_BEGIN(rtReduceAsyncV2_part2);
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *rtReduceAsyncV2Task = stm->AllocTask(&submitTask, TS_TASK_TYPE_REDUCE_ASYNC_V2, errorReason);
    NULL_PTR_RETURN_MSG(rtReduceAsyncV2Task, errorReason);

    std::function<void()> const reduceAsyncV2TaskRecycle = [&, rtReduceAsyncV2Task]() {
        (void)dev->GetTaskFactory()->Recycle(rtReduceAsyncV2Task);
    };
    ScopeGuard taskGuarder(reduceAsyncV2TaskRecycle);
    rtReduceAsyncV2Task->u.reduceAsyncV2TaskInfo.overflowAddrOffset = INVALID_CONTEXT_OVERFLOW_OFFSET;
    Context * const ctx = stm->Context_();
    if ((dev->GetTschVersion() >= static_cast<uint32_t>(TS_VERSION_REDUCV2_OPTIMIZE)) &&
        (RtPtrToValue<void *>(overflowAddr) == RtPtrToValue<void *>(ctx->CtxGetOverflowAddr()))) {
        rtReduceAsyncV2Task->u.reduceAsyncV2TaskInfo.overflowAddrOffset = ctx->CtxGetOverflowAddrOffset();
    }

    error = ReduceAsyncV2TaskInit(rtReduceAsyncV2Task, kind, src, dst, cpySize, overflowAddr);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    rtReduceAsyncV2Task->u.reduceAsyncV2TaskInfo.copyDataType = static_cast<uint8_t>(type);

    error = ctx->CheckMemAlign(src, type);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    error = ctx->CheckMemAlign(dst, type);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    error = dev->SubmitTask(rtReduceAsyncV2Task);
    COND_RETURN_WITH_NOLOG((error != RT_ERROR_NONE), error);

    GET_THREAD_TASKID_AND_STREAMID(rtReduceAsyncV2Task, stm->AllocTaskStreamId());
    taskGuarder.ReleaseGuard();
    TIMESTAMP_END(rtReduceAsyncV2_part2);
    return RT_ERROR_NONE;
}

} // namespace runtime
} // namespace cce
