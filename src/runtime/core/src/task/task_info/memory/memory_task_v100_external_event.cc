/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "memory_task.h"
#include "common_task.h"
#include "stream.hpp"
#include "stars_cond_isa_helper.hpp"
#include "stars_external_event_cond_isa_helper.hpp"

namespace cce {
namespace runtime {
rtError_t ConstructLastSqeForExternalWaitTask(
    TaskInfo* taskInfo, const RtStarsMemWaitValueInstrFcPara& fcPara, uint64_t& funcCallSize)
{
    MemWaitValueTaskInfo* memWaitValueTask = &taskInfo->u.memWaitValueTask;
    RtStarsExternalWaitFuncCall fc = {};
    funcCallSize = static_cast<uint64_t>(sizeof(RtStarsExternalWaitFuncCall));
    RtStarsExternalWaitFuncCallPara externalPara = {};
    externalPara.waitRefreshAddr = fcPara.devAddr;
    externalPara.maxLoop = fcPara.maxLoop;
    externalPara.sqIdMemAddr = fcPara.sqIdMemAddr;
    externalPara.sqHeadPre = fcPara.sqHeadPre;
    ConstructExternalWaitFuncCall(fc, externalPara);
    const rtError_t ret = taskInfo->stream->Device_()->Driver_()->MemCopySync(
        memWaitValueTask->funcCallSvmMem2, memWaitValueTask->funCallMemSize2, &fc, funcCallSize,
        RT_MEMCPY_HOST_TO_DEVICE);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(
            RT_LOG_ERROR, "Copy external wait function-call failed, stream_id=%d, task_id=%hu, retCode=%#x.",
            taskInfo->stream->Id_(), taskInfo->id, static_cast<uint32_t>(ret));
    }
    return ret;
}
} // namespace runtime
} // namespace cce
