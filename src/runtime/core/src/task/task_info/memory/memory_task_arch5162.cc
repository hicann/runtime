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
#include "task_info_v100.h"
#include "stream.hpp"
#include "runtime.hpp"
#include "runtime_task_manager.h"
#include "error_code.h"
#include "model.hpp"

namespace cce {
namespace runtime {

void PrintAsyncPtrProc(Driver* const driver, char_t* const errStr, void* memcpyAddrInfo, int32_t& countNum)
{
    UNUSED(driver);
    UNUSED(errStr);
    UNUSED(memcpyAddrInfo);
    UNUSED(countNum);
}

rtError_t MixKernelUpdatePrepare(TaskInfo* const updateTask, void** const hostAddr, const uint64_t allocSize)
{
    UNUSED(updateTask);
    UNUSED(hostAddr);
    UNUSED(allocSize);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t NormalKernelUpdatePrepare(TaskInfo* const updateTask, void** const hostAddr, const uint64_t allocSize)
{
    UNUSED(updateTask);
    UNUSED(hostAddr);
    UNUSED(allocSize);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ConvertAsyncDma(TaskInfo* const taskInfo)
{
    UNUSED(taskInfo);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t ConvertAsyncDma2D(
    TaskInfo* const taskInfo2D, void* const dst, const uint64_t dstPitch, const void* const src,
    const uint64_t srcPitch, const uint64_t width, const uint64_t height, const uint64_t fixedSize)
{
    UNUSED(taskInfo2D);
    UNUSED(dst);
    UNUSED(dstPitch);
    UNUSED(src);
    UNUSED(srcPitch);
    UNUSED(width);
    UNUSED(height);
    UNUSED(fixedSize);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t SqeUpdateH2DTaskInit(
    TaskInfo* const taskInfo, void* srcAddr, void* dstAddr, const uint64_t cpySize, void* releaseArgHandle,
    void* const updateArgHandle)
{
    UNUSED(taskInfo);
    UNUSED(srcAddr);
    UNUSED(dstAddr);
    UNUSED(cpySize);
    UNUSED(releaseArgHandle);
    UNUSED(updateArgHandle);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t UpdateD2HTaskInit(
    TaskInfo* const taskInfo, const void* sqeBaseAddr, const uint64_t cpySize, const uint32_t sqId, const uint32_t pos,
    const uint8_t sqeOffset)
{
    UNUSED(taskInfo);
    UNUSED(sqeBaseAddr);
    UNUSED(cpySize);
    UNUSED(sqId);
    UNUSED(pos);
    UNUSED(sqeOffset);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t MemWriteValueTaskInit(TaskInfo* taskInfo, const void* const devAddr, const uint64_t value)
{
    UNUSED(taskInfo);
    UNUSED(devAddr);
    UNUSED(value);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

void MemWaitTaskUnInit(TaskInfo* taskInfo) { UNUSED(taskInfo); }

rtError_t MemWaitValueTaskInit(TaskInfo* taskInfo, const void* const devAddr, const uint64_t value, const uint32_t flag)
{
    UNUSED(taskInfo);
    UNUSED(devAddr);
    UNUSED(value);
    UNUSED(flag);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t UpdateTaskD2HSubmit(const TaskInfo* const updateTask, void* sqeAddr, Stream* const stm)
{
    UNUSED(updateTask);
    UNUSED(sqeAddr);
    UNUSED(stm);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t UpdateTaskH2DSubmit(TaskInfo* const updateTask, Stream* const stm, void* sqeDeviceAddr)
{
    UNUSED(updateTask);
    UNUSED(stm);
    UNUSED(sqeDeviceAddr);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

void IpcEventDestroy(IpcEvent** eventPtr, int32_t freeId, bool isNeedDestroy)
{
    UNUSED(eventPtr);
    UNUSED(freeId);
    UNUSED(isNeedDestroy);
}

rtError_t GetCaptureRecordTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params)
{
    UNUSED(taskInfo);
    UNUSED(params);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t GetCaptureWaitTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params)
{
    UNUSED(taskInfo);
    UNUSED(params);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t GetCaptureResetTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params)
{
    UNUSED(taskInfo);
    UNUSED(params);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t GetWriteValueTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params)
{
    UNUSED(taskInfo);
    UNUSED(params);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t GetWaitValueTaskParams(const TaskInfo* const taskInfo, rtTaskParams* const params)
{
    UNUSED(taskInfo);
    UNUSED(params);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t UpdateWriteValueTaskParams(TaskInfo* const taskInfo, rtTaskParams* const params)
{
    UNUSED(taskInfo);
    UNUSED(params);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t UpdateWaitValueTaskParams(TaskInfo* const taskInfo, rtTaskParams* const params)
{
    UNUSED(taskInfo);
    UNUSED(params);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t CreateL2AddrTaskInit(TaskInfo* const taskInfo, const uint64_t ptePtrAddr)
{
    UNUSED(taskInfo);
    UNUSED(ptePtrAddr);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

rtError_t UpdateAddressTaskInit(TaskInfo* taskInfo, uint64_t devAddr, uint64_t len)
{
    UNUSED(taskInfo);
    UNUSED(devAddr);
    UNUSED(len);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

static void ConstructPlaceHolderSqe(TaskInfo* const taskInfo, rtStarsSqe_t* const command)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;

    RtStarsPhSqe* const sqe = &(command->phSqe);
    sqe->header.type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->header.wrCqe = stream->GetStarsWrCqeFlag();
    sqe->header.rtStreamId = static_cast<uint16_t>(stream->Id_());
    sqe->header.taskId = taskInfo->id;
    sqe->header.u.sqeSubType = RT_SQE_SUBTYPE_MEMORY_COPY;
    sqe->header.preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    sqe->header.postP = RT_STARS_SQE_INT_DIR_NO;

    sqe->u.memcpyAsyncWithoutSdmaInfo.src =
        static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->src));
    sqe->u.memcpyAsyncWithoutSdmaInfo.dest =
        static_cast<uint64_t>(reinterpret_cast<uintptr_t>(memcpyAsyncTaskInfo->destPtr));
    sqe->u.memcpyAsyncWithoutSdmaInfo.size = memcpyAsyncTaskInfo->size;
    sqe->u.memcpyAsyncWithoutSdmaInfo.pid = static_cast<uint32_t>(drvDeviceGetBareTgid());
    PrintSqe(command, "MemCopyAsyncByPlaceHolder");
    RT_LOG(
        RT_LOG_INFO, "ConstructSqe, size_=%" PRIu64 ", pid=%u.", memcpyAsyncTaskInfo->size,
        sqe->u.memcpyAsyncWithoutSdmaInfo.pid);
}

void ConstructSqeForMemcpyAsyncTask(TaskInfo* const taskInfo, rtStarsSqe_t* const command)
{
    ConstructPlaceHolderSqe(taskInfo, command);
    RT_LOG(
        RT_LOG_INFO, "MemcpyAsyncTask using PH SQE. stream_id=%d, task_id=%u",
        static_cast<int32_t>(taskInfo->stream->Id_()), static_cast<uint32_t>(taskInfo->id));
    PrintSqe(command, "MemcpyAsyncPtr");
}

static void ReleaseCpyTmpMem(TaskInfo* const taskInfo)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;
    Driver* const driver = taskInfo->stream->Device_()->Driver_();

    if (memcpyAsyncTaskInfo->srcPtr != nullptr) {
        if (stream->Device_()->IsAddrFlatDev()) {
            (void)driver->HostMemFree(memcpyAsyncTaskInfo->srcPtr);
        } else {
            free(memcpyAsyncTaskInfo->srcPtr);
        }
        memcpyAsyncTaskInfo->srcPtr = nullptr;
    }
    if (memcpyAsyncTaskInfo->desPtr != nullptr) {
        free(memcpyAsyncTaskInfo->desPtr);
        memcpyAsyncTaskInfo->desPtr = nullptr;
    }
}

void MemcpyAsyncTaskUnInit(TaskInfo* const taskInfo)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);

    if ((memcpyAsyncTaskInfo->isSqeUpdateH2D) && (memcpyAsyncTaskInfo->src != nullptr)) {
        Driver* const driver = taskInfo->stream->Device_()->Driver_();
        (void)driver->HostMemFree(memcpyAsyncTaskInfo->src);
        memcpyAsyncTaskInfo->src = nullptr;
    }

    if (memcpyAsyncTaskInfo->releaseArgHandle != nullptr) {
        ArgLoader* const argLoaderObj = taskInfo->stream->Device_()->ArgLoader_();
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
    ReleaseCpyTmpMem(taskInfo);
    if (memcpyAsyncTaskInfo->guardMemVec != nullptr) {
        memcpyAsyncTaskInfo->guardMemVec->clear();
        delete memcpyAsyncTaskInfo->guardMemVec;
        memcpyAsyncTaskInfo->guardMemVec = nullptr;
    }
}

static bool IsSdmaMteErrorCode(const int32_t errCode)
{
    return (errCode == TS_ERROR_SDMA_LINK_ERROR) || (errCode == TS_ERROR_SDMA_POISON_ERROR);
}

TIMESTAMP_EXTERN(rtMemcpyAsync_drvMemDestroyAddr);
void DoCompleteSuccessForMemcpyAsyncTask(TaskInfo* const taskInfo, const uint32_t devId)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;
    Driver* const driver = taskInfo->stream->Device_()->Driver_();
    const uint32_t copyType = memcpyAsyncTaskInfo->copyType;
    uint32_t errorCode = taskInfo->errorCode;

    if (unlikely(errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        if (IsSdmaMteErrorCode(static_cast<int32_t>(taskInfo->mte_error))) {
            errorCode = taskInfo->mte_error;
            taskInfo->mte_error = 0U;
        }
        stream->SetErrCode(errorCode);
        if (errorCode != TS_ERROR_SDMA_OVERFLOW) {
            RT_LOG(
                RT_LOG_ERROR, "mem async copy error, mte_err=%#x, retCode=%#x, [%s].", taskInfo->mte_error, errorCode,
                GetTsErrCodeDesc(errorCode));
            PrintErrorInfoForMemcpyAsyncTask(taskInfo, devId);
        }
    }

    if (errorCode != TS_ERROR_SDMA_OVERFLOW) {
        TaskFailCallBack(
            static_cast<uint32_t>(stream->Id_()), static_cast<uint32_t>(taskInfo->id), taskInfo->tid, errorCode,
            stream->Device_());
    }

    (void)RecycleTaskResourceForMemcpyAsyncTask(taskInfo);
    if (memcpyAsyncTaskInfo->dmaKernelConvertFlag) {
        // except for david, free pcie-dma desc in ts_agent
        return;
    }

    if (memcpyAsyncTaskInfo->dsaSqeUpdateFlag || memcpyAsyncTaskInfo->isSqeUpdateD2H) {
        // update task does not need to call drvMemDestroyAddr
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
            COND_RETURN_VOID(
                error != RT_ERROR_NONE, "free dma addr failed after convert memory address, retCode=%#x.", error);
        } else {
            (stream->Model_())->PushbackDmaAddr(memcpyAsyncTaskInfo->dmaAddr);
        }
    }
}

static bool MemoryTaskRegister()
{
    TaskFuncSingle memcpyFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForMemcpyAsyncTask,
        .doCompleteSuccFunc = &DoCompleteSuccessForMemcpyAsyncTask,
        .taskUnInitFunc = &MemcpyAsyncTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoForMemcpyAsyncTask,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultForMemcpyAsyncTask,
    };
    RegTaskFunc(CHIP_5162A, TS_TASK_TYPE_MEMCPY, memcpyFuncs);
    return true;
}

static bool g_memoryTaskRegister = MemoryTaskRegister();

} // namespace runtime
} // namespace cce
