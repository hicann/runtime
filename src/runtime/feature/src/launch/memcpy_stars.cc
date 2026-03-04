/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "memcpy_c.hpp"
#include "inner_thread_local.hpp"
#include "context.hpp"
#include "stream.hpp"
#include "task.hpp"
#include "device.hpp"

namespace cce {
namespace runtime {

rtError_t MemcopyAsync(
    void* const dst, const uint64_t destMax, const void* const src, const uint64_t cpySize, const rtMemcpyKind_t kind,
    Stream* const stm, uint64_t* const realSize, const std::shared_ptr<void>& guardMem,
    const rtTaskCfgInfo_t* const cfgInfo, const rtD2DAddrCfgInfo_t* const addrCfg)
{
    UNUSED(destMax);
    TaskInfo submitTask = {};
    rtError_t errorReason;

    NULL_PTR_RETURN_MSG(stm, RT_ERROR_STREAM_NULL);

    TaskInfo* rtMemcpyAsyncTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_MEMCPY, errorReason);
    NULL_PTR_RETURN_MSG(rtMemcpyAsyncTask, errorReason);

    rtError_t error = MemcpyAsyncTaskInitV3(rtMemcpyAsyncTask, kind, src, dst, cpySize, cfgInfo, addrCfg);
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }
    *realSize = rtMemcpyAsyncTask->u.memcpyAsyncTaskInfo.size;
    if (guardMem != nullptr) {
        rtMemcpyAsyncTask->u.memcpyAsyncTaskInfo.guardMemVec->emplace_back(guardMem);
    }

    error = stm->Device_()->SubmitTask(rtMemcpyAsyncTask, stm->Context_()->TaskGenCallback_());
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }

    GET_THREAD_TASKID_AND_STREAMID(rtMemcpyAsyncTask, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)stm->Device_()->GetTaskFactory()->Recycle(rtMemcpyAsyncTask);
    return error;
}

} // namespace runtime
} // namespace cce
