/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "memory_task.h"
#include "error_code.h"
#include "stream_david.hpp"

namespace cce {
namespace runtime {

#if F_DESC("MemcpyAsyncTask")
void DoCompleteSuccessForMemcpyAsyncTask(TaskInfo * const taskInfo, const uint32_t devId)
{
    Stream * const stream = taskInfo->stream;
    uint32_t errorCode = taskInfo->errorCode;

    if (unlikely(errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        switch (static_cast<int16_t>(taskInfo->mte_error)) {
            case TS_ERROR_SDMA_POISON_ERROR:
                errorCode = TS_ERROR_SDMA_POISON_ERROR;
                stream->SetErrCode(errorCode);
                break;
            case TS_ERROR_SDMA_LINK_ERROR:
                errorCode = TS_ERROR_SDMA_LINK_ERROR;
                stream->SetErrCode(errorCode);
                break;
            default:
                stream->SetErrCode(errorCode);
                break;
        }
        if (errorCode != TS_ERROR_SDMA_OVERFLOW) {
            RT_LOG(RT_LOG_ERROR, "mem async copy error, retCode=%#x, [%s].", errorCode, GetTsErrCodeDesc(errorCode));
            PrintErrorInfoForMemcpyAsyncTask(taskInfo, devId);
            TaskFailCallBack(static_cast<uint32_t>(stream->Id_()), static_cast<uint32_t>(taskInfo->id),
            taskInfo->tid, errorCode, stream->Device_());
        }
    }
}

static void AsyncDmaWqeProc(MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo, const Stream * const stream)
{
    bool ubFlag = IsDavidUbDma(memcpyAsyncTaskInfo->copyType);
    if ((!ubFlag) && (!memcpyAsyncTaskInfo->isSqeUpdateH2D)) {
        return;
    }

    bool isUbMode = false;
    AsyncDmaWqeDestroyInfo destroyParm;
    (void)memset_s(&destroyParm, sizeof(AsyncDmaWqeDestroyInfo), 0, sizeof(AsyncDmaWqeDestroyInfo));
    destroyParm.tsId = stream->Device_()->DevGetTsId();
    destroyParm.sqId = stream->GetSqId();
    if (ubFlag) {
        destroyParm.wqe = memcpyAsyncTaskInfo->ubDma.wqePtr;
        destroyParm.size = memcpyAsyncTaskInfo->ubDma.wqeLen;
        isUbMode = true;
    } else {
        if (memcpyAsyncTaskInfo->isSqeUpdateH2D) {
            destroyParm.dmaAddr = &(memcpyAsyncTaskInfo->dmaAddr);
        } else {
            RT_LOG(RT_LOG_ERROR, "pcie does not support");
            return;
        }
    }
    rtError_t error = stream->Device_()->Driver_()->DestroyAsyncDmaWqe(stream->Device_()->Id_(), &destroyParm,
            isUbMode);
    COND_RETURN_VOID(error != RT_ERROR_NONE, "drv destroy asyncDmaWqe failed, retCode=%#x.", error);
    RT_LOG(RT_LOG_INFO, "ub wqe or pcie dma release success, is_ub_mode=%d, is_update=%d, sq_id=%u.",
        isUbMode, memcpyAsyncTaskInfo->isSqeUpdateH2D, destroyParm.sqId);
}

void MemcpyAsyncTaskUnInit(TaskInfo * const taskInfo)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = taskInfo->stream->Device_()->Driver_();

    (void)RecycleTaskResourceForMemcpyAsyncTask(taskInfo);
    // release guard mem.
    if (memcpyAsyncTaskInfo->guardMemVec != nullptr) {
        memcpyAsyncTaskInfo->guardMemVec->clear();
        delete memcpyAsyncTaskInfo->guardMemVec;
        memcpyAsyncTaskInfo->guardMemVec = nullptr;
    }

    COND_RETURN_VOID(driver == nullptr, "driver_ pointer NULL.");
    if (memcpyAsyncTaskInfo->dmaKernelConvertFlag) {
        rtError_t error = RT_ERROR_NONE;
        // only for david, other chips free pcie-dma desc in ts_agent
        if (IsPcieDma(memcpyAsyncTaskInfo->copyType) && !(Runtime::Instance()->GetConnectUbFlag()) &&
            !(memcpyAsyncTaskInfo->isSqeUpdateH2D)) {
            error = driver->MemDestroyAddr(&(memcpyAsyncTaskInfo->dmaAddr));
            COND_RETURN_VOID(error != RT_ERROR_NONE,
                "free dma addr failed after convert memory address, retCode=%#x.", error);
            RT_LOG(RT_LOG_INFO, "pcie dma release success.");
        }

        if ((memcpyAsyncTaskInfo->isSqeUpdateH2D) && (memcpyAsyncTaskInfo->src != nullptr)) {
            (void)driver->HostMemFree(memcpyAsyncTaskInfo->src);
            memcpyAsyncTaskInfo->src = nullptr;
        }

        DavidStream *davidStm = static_cast<DavidStream *>(stream);
        if (memcpyAsyncTaskInfo->releaseArgHandle != nullptr) {
            if (davidStm->ArgManagePtr() != nullptr) {
                davidStm->ArgManagePtr()->RecycleDevLoader(memcpyAsyncTaskInfo->releaseArgHandle);
            }
            memcpyAsyncTaskInfo->releaseArgHandle = nullptr;
        }

        AsyncDmaWqeProc(memcpyAsyncTaskInfo, stream);
    }

    ReleaseCpyTmpMemForDavid(taskInfo);
    memcpyAsyncTaskInfo->src = nullptr;
    memcpyAsyncTaskInfo->destPtr = nullptr;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.flag = 0U;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.len = 0U;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.dst = nullptr;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.src = nullptr;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.priv = nullptr;
}
#endif

}  // namespace runtime
}  // namespace cce