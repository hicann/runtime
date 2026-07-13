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
#include "memory_task.h"
#include "inner_thread_local.hpp"
#include "context.hpp"
#include "stream.hpp"
#include "task.hpp"
#include "device.hpp"
#include "runtime.hpp"
#include "securec.h"
#include <cinttypes>

namespace cce {
namespace runtime {

static void InitStarsSdmaSqe(
    rtStarsSdmaSqe_t *sdmaSqe, const uint64_t count, const Stream * const stm, const rtTaskCfgInfo_t * const cfgInfo)
{
    if (cfgInfo != nullptr) {
        sdmaSqe->qos = cfgInfo->qos;
        sdmaSqe->partid = cfgInfo->partId;
    } else {
        sdmaSqe->qos = 0U;
        sdmaSqe->partid = 0U;
    }
    const uint32_t memcpyAsyncTaskD2DQos = stm->Device_()->GetDevProperties().memcpyAsyncTaskD2DQos;
    if ((memcpyAsyncTaskD2DQos != UINT32_MAX) && (cfgInfo != nullptr) && (cfgInfo->d2dCrossFlag != true)) {
        sdmaSqe->qos = memcpyAsyncTaskD2DQos;
    }

    sdmaSqe->sssv = 1U;
    sdmaSqe->dssv = 1U;
    sdmaSqe->sns = 1U;
    sdmaSqe->dns = 1U;
    sdmaSqe->srcStreamId = static_cast<uint16_t>(RT_SMMU_STREAM_ID_1FU);
    sdmaSqe->dst_streamid = static_cast<uint16_t>(RT_SMMU_STREAM_ID_1FU);
    sdmaSqe->src_sub_streamid = static_cast<uint16_t>(stm->Device_()->GetSSID_());
    sdmaSqe->dstSubStreamId = static_cast<uint16_t>(stm->Device_()->GetSSID_());
    sdmaSqe->length = static_cast<uint32_t>(count);
}

rtError_t MemcopyAsyncPtr(void * const memcpyAddrInfo, const uint64_t destMax, const uint64_t count,
    Stream *stm, const std::shared_ptr<void> &guardMem, const rtTaskCfgInfo_t * const cfgInfo, const bool isMemcpyDesc)
{
    UNUSED(destMax);
    rtError_t error;
    rtTaskGenCallback callback = nullptr;
    TaskInfo submitTask = {};
    rtError_t errorReason;
    TaskInfo *cpyAsyncTask = stm->AllocTask(&submitTask, TS_TASK_TYPE_MEMCPY, errorReason);
    NULL_PTR_RETURN_MSG(cpyAsyncTask, errorReason);

    rtStarsSdmaSqe_t sdmaSqe = {};
    uint64_t flushSize = 16U;
    uint64_t copySize = sizeof(rtStarsSdmaSqe_t);
    if (isMemcpyDesc) {
        flushSize = MEMCPY_DESC_LENGTH_OFFSET;
        copySize = MEMCPY_DESC_LENGTH_OFFSET;
        InitStarsSdmaSqe(&sdmaSqe, 0ULL, stm, cfgInfo);
    } else {
        InitStarsSdmaSqe(&sdmaSqe, count, stm, cfgInfo);
    }
    RT_LOG(RT_LOG_INFO, "memcpyAddrInfo=0x%lx , qos=%u",
        RtPtrToValue<void *>(memcpyAddrInfo), sdmaSqe.qos);
    Device * const dev = stm->Device_();
    const auto recycleTask = [&dev, &cpyAsyncTask]() {
        (void)dev->GetTaskFactory()->Recycle(cpyAsyncTask);
    };
    if (dev->Driver_()->GetRunMode() == RT_RUN_MODE_ONLINE) {
        error = dev->Driver_()->MemCopySync(memcpyAddrInfo, flushSize, &sdmaSqe, copySize, RT_MEMCPY_HOST_TO_DEVICE);
        if (error != RT_ERROR_NONE) {
            ERROR_PROC_RETURN_MSG_INNER(error, recycleTask();,
                "Failed to memory copy stream info, device_id=%u, size=%" PRIu64 ", retCode=%#x.",
                dev->Id_(), copySize, error);
        }
        error = dev->Driver_()->DevMemFlushCache(RtPtrToValue<void *>(memcpyAddrInfo), flushSize);
        if (error != RT_ERROR_NONE) {
            ERROR_PROC_RETURN_MSG_INNER(error, recycleTask();, "Failed to flush stream info, device_id=%u, retCode=%#x",
                dev->Id_(), error);
        }
    } else {
        error = dev->Driver_()->MemCopySync(memcpyAddrInfo, flushSize, &sdmaSqe, copySize, RT_MEMCPY_HOST_TO_DEVICE);
        if (error != RT_ERROR_NONE) {
            ERROR_PROC_RETURN_MSG_INNER(error, recycleTask();,
                "Failed to memory copy stream info, device_id=%u, retCode=%#x", dev->Id_(), error);
        }
    }

    error = MemcpyAsyncTaskInitV1(cpyAsyncTask, memcpyAddrInfo, isMemcpyDesc ? 0ULL : count);
    if (error != RT_ERROR_NONE) {
        recycleTask();
        return error;
    }

    if (guardMem != nullptr) {
        cpyAsyncTask->u.memcpyAsyncTaskInfo.guardMemVec->emplace_back(guardMem);
    }

    callback = (stm->Context_() == nullptr) ? nullptr : stm->Context_()->TaskGenCallback_();
    error = dev->SubmitTask(cpyAsyncTask, callback);
    if (error != RT_ERROR_NONE) {
        recycleTask();
        return error;
    }

    GET_THREAD_TASKID_AND_STREAMID(cpyAsyncTask, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;
}

rtError_t Memcpy2DAsync(void * const dst, const uint64_t dstPitch, const void * const src,
    const uint64_t srcPitch, const uint64_t width, const uint64_t height, const rtMemcpyKind_t kind,
    uint64_t * const realSize, Stream * const stm, const uint64_t fixedSize)
{
    TaskInfo submitTask = {};
    rtError_t errorReason;
    rtTaskGenCallback callback = nullptr;

    if (stm == nullptr) {
        return RT_ERROR_STREAM_NULL;
    }

    TaskInfo *taskAsync2d = stm->AllocTask(&submitTask, TS_TASK_TYPE_MEMCPY, errorReason);
    NULL_PTR_RETURN_MSG(taskAsync2d, errorReason);
    const auto recycleTask = [&stm, &taskAsync2d]() {
        (void)stm->Device_()->GetTaskFactory()->Recycle(taskAsync2d);
    };

    rtError_t error = MemcpyAsyncTaskInitV2(taskAsync2d, dst, dstPitch, src, srcPitch, width, height, kind, fixedSize);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "invoke taskAsync2d Init error code:%#x", error);
        recycleTask();
        return error;
    }
    *realSize = taskAsync2d->u.memcpyAsyncTaskInfo.size;

    callback = (stm->Context_() == nullptr) ? nullptr : stm->Context_()->TaskGenCallback_();
    error = stm->Device_()->SubmitTask(taskAsync2d, callback);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "invoke device_ SubmitTask error code:%#x", error);
        recycleTask();
        return error;
    }

    GET_THREAD_TASKID_AND_STREAMID(taskAsync2d, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;
}
    
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

    error = stm->Device_()->SubmitTask(rtMemcpyAsyncTask);
    if (error != RT_ERROR_NONE) {
        goto ERROR_RECYCLE;
    }

    GET_THREAD_TASKID_AND_STREAMID(rtMemcpyAsyncTask, stm->AllocTaskStreamId());
    return RT_ERROR_NONE;

ERROR_RECYCLE:
    (void)stm->Device_()->GetTaskFactory()->Recycle(rtMemcpyAsyncTask);
    return error;
}

rtError_t DevMemSetAsyncByMemset(Stream * const stm, void * const ptr,
    const uint64_t destMax, const uint32_t fillVal, const uint64_t fillCount)
{
    UNUSED(stm);
    UNUSED(ptr);
    UNUSED(destMax);
    UNUSED(fillVal);
    UNUSED(fillCount);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

} // namespace runtime
} // namespace cce
