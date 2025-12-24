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

namespace cce {
namespace runtime {

#if F_DESC("MemcpyAsyncTask")
TIMESTAMP_EXTERN(rtMemcpyAsync_drvMemDestroyAddr);

bool IsSdmaMteErrorCode(const int32_t errCode)
{
    return (errCode == TS_ERROR_SDMA_LINK_ERROR) || (errCode == TS_ERROR_SDMA_POISON_ERROR);
}

void MemcpyAsyncTaskUnInit(TaskInfo * const taskInfo)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);

    if ((memcpyAsyncTaskInfo->isSqeUpdateH2D) && (memcpyAsyncTaskInfo->src != nullptr)) {
        Driver * const driver = taskInfo->stream->Device_()->Driver_();
        (void)driver->HostMemFree(memcpyAsyncTaskInfo->src);
        memcpyAsyncTaskInfo->src = nullptr;
    }

    if (memcpyAsyncTaskInfo->releaseArgHandle != nullptr) {
        ArgLoader * const argLoaderObj = taskInfo->stream->Device_()->ArgLoader_();
        (void)argLoaderObj->Release(memcpyAsyncTaskInfo->releaseArgHandle);
        memcpyAsyncTaskInfo->releaseArgHandle = nullptr;
    }

    memcpyAsyncTaskInfo->src = nullptr;
    memcpyAsyncTaskInfo->destPtr = nullptr;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.flag = 0U;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.len = 0U;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.dst = nullptr;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.src = nullptr;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.priv = nullptr;
    if (Runtime::Instance()->isRK3588HostCpu()) {
        ReleaseCpyTmpMemFor3588(taskInfo);
    } else {
        ReleaseCpyTmpMem(taskInfo);
    }
    // release guard mem.
    if (memcpyAsyncTaskInfo->guardMemVec != nullptr) {
        memcpyAsyncTaskInfo->guardMemVec->clear();
        delete memcpyAsyncTaskInfo->guardMemVec;
        memcpyAsyncTaskInfo->guardMemVec = nullptr;
    }
}

void DoCompleteSuccessForMemcpyAsyncTask(TaskInfo * const taskInfo, const uint32_t devId)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = taskInfo->stream->Device_()->Driver_();
    const uint32_t copyType = memcpyAsyncTaskInfo->copyType;
    uint32_t errorCode = taskInfo->errorCode;

    if (unlikely(errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        if (IsSdmaMteErrorCode(static_cast<int32_t>(taskInfo->mte_error))) {
            errorCode = taskInfo->mte_error;
            taskInfo->mte_error = 0U;
        }
        stream->SetErrCode(errorCode);
        if (errorCode != TS_ERROR_SDMA_OVERFLOW) {
            RT_LOG(RT_LOG_ERROR, "mem async copy error, mte_err=%#x, retCode=%#x, [%s].",
                   taskInfo->mte_error, errorCode, GetTsErrCodeDesc(errorCode));
            PrintErrorInfoForMemcpyAsyncTask(taskInfo, devId);
        }
    }

    if (errorCode != TS_ERROR_SDMA_OVERFLOW) {
        TaskFailCallBack(static_cast<uint32_t>(stream->Id_()), static_cast<uint32_t>(taskInfo->id),
            taskInfo->tid, errorCode, stream->Device_());
    }

    (void)RecycleTaskResourceForMemcpyAsyncTask(taskInfo);
    if (memcpyAsyncTaskInfo->dmaKernelConvertFlag) {
        // except for starsv2, free pcie-dma desc in ts_agent
        return;
    }

    if (memcpyAsyncTaskInfo->dsaSqeUpdateFlag || memcpyAsyncTaskInfo->isSqeUpdateD2H) {
        // update task dose not need to call drvMemDestroyAddr
        return;
    }

    COND_RETURN_VOID(driver == nullptr, "driver_ pointer NULL.");
    if ((driver->GetRunMode() == RT_RUN_MODE_ONLINE) && (copyType != RT_MEMCPY_DIR_D2D_SDMA) &&
        (copyType != RT_MEMCPY_DIR_SDMA_AUTOMATIC_ADD) && (copyType != RT_MEMCPY_ADDR_D2D_SDMA)) {
        if (stream->Model_() == nullptr) {
            rtError_t error;
            TIMESTAMP_BEGIN(rtMemcpyAsync_drvMemDestroyAddr);
            error = driver->MemDestroyAddr(&(memcpyAsyncTaskInfo->dmaAddr));
            TIMESTAMP_END(rtMemcpyAsync_drvMemDestroyAddr);
            COND_RETURN_VOID(error != RT_ERROR_NONE,
                "free dma addr failed after convert memory address, retCode=%#x.", error);
        } else {
            (stream->Model_())->PushbackDmaAddr(memcpyAsyncTaskInfo->dmaAddr);
        }
    }
}
#endif

}  // namespace runtime
}  // namespace cce