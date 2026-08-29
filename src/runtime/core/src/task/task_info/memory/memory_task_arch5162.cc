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
#include "error_message_manage.hpp"
#include "task_info_v100.h"
#include "task_info.hpp"
#include "stream.hpp"
#include "runtime_task_manager.h"
#include "error_code.h"
#include "securec.h"
#include "task_scheduler_error.h"

namespace cce {
namespace runtime {

void PrintAsyncPtrProc(Driver* const driver, char_t* const errStr, void* memcpyAddrInfo, int32_t& countNum)
{
    UNUSED(driver);
    UNUSED(errStr);
    UNUSED(memcpyAddrInfo);
    UNUSED(countNum);
}

rtError_t GetD2dCrossType(
    Driver* const driver, const void* const srcAddr, const void* const desAddr, bool* isD2dCross8P)
{
    UNUSED(driver);
    UNUSED(srcAddr);
    UNUSED(desAddr);
    UNUSED(isD2dCross8P);
    return RT_ERROR_NONE;
}

rtError_t MemcpyAsyncTaskCommonInit(TaskInfo* const taskInfo)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    TaskCommonInfoInit(taskInfo);

    taskInfo->type = TS_TASK_TYPE_MEMCPY;
    taskInfo->typeName = const_cast<char_t*>("MEMCPY_ASYNC");
    memcpyAsyncTaskInfo->copyType = 0U;
    memcpyAsyncTaskInfo->copyMethod = 0U;
    memcpyAsyncTaskInfo->copyKind = 0U;
    memcpyAsyncTaskInfo->size = 0U;
    memcpyAsyncTaskInfo->src = nullptr;
    memcpyAsyncTaskInfo->destPtr = nullptr;
    memcpyAsyncTaskInfo->srcPtr = nullptr;
    memcpyAsyncTaskInfo->desPtr = nullptr;
    memcpyAsyncTaskInfo->originalDes = nullptr;
    memcpyAsyncTaskInfo->releaseArgHandle = nullptr;
    memcpyAsyncTaskInfo->copyDataType = 0U;
    memcpyAsyncTaskInfo->qos = 0U;
    memcpyAsyncTaskInfo->partId = 0U;
    memcpyAsyncTaskInfo->sqeOffset = 0U;
    memcpyAsyncTaskInfo->dmaKernelConvertFlag = false;
    memcpyAsyncTaskInfo->dsaSqeUpdateFlag = false;
    memcpyAsyncTaskInfo->sqId = 0U;
    memcpyAsyncTaskInfo->taskPos = 0U;
    memcpyAsyncTaskInfo->d2dOffsetFlag = false;
    memcpyAsyncTaskInfo->isD2dCross = false;
    memcpyAsyncTaskInfo->isSqeUpdateH2D = false;
    memcpyAsyncTaskInfo->isSqeUpdateD2H = false;
    memcpyAsyncTaskInfo->isConcernedRecycle = false;

    memcpyAsyncTaskInfo->dmaAddr.phyAddr.flag = 0U;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.len = 0U;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.dst = nullptr;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.src = nullptr;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.priv = nullptr;
    memcpyAsyncTaskInfo->dmaAddr.fixed_size = 0U;
    memcpyAsyncTaskInfo->dmaAddr.virt_id = 0U;
    memcpyAsyncTaskInfo->memcpyAddrInfo = nullptr;
    if (memcpyAsyncTaskInfo->guardMemVec == nullptr) {
        memcpyAsyncTaskInfo->guardMemVec = new (std::nothrow) std::vector<std::shared_ptr<void>>();
        COND_RETURN_AND_MSG_OUTER(
            memcpyAsyncTaskInfo->guardMemVec == nullptr, RT_ERROR_MEMORY_ALLOCATION, ErrorCode::EE1013,
            sizeof(std::vector<std::shared_ptr<void>>), "new");
        taskInfo->needPostProc = true;
    }
    return RT_ERROR_NONE;
}

rtError_t MemcpyAsyncTaskInitV3(
    TaskInfo* const taskInfo, uint32_t cpyType, const void* srcAddr, void* desAddr, const uint64_t cpySize,
    const rtTaskCfgInfo_t* cfgInfo, const rtD2DAddrCfgInfo_t* const addrCfg)
{
    rtError_t error = MemcpyAsyncTaskCommonInit(taskInfo);
    ERROR_RETURN_MSG_INNER(error, "MemcpyAsyncTaskCommonInit V3 failed, retCode=%#x.", error);

    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    UNUSED(cpyType);
    memcpyAsyncTaskInfo->copyKind = RT_MEMCPY_DEVICE_TO_DEVICE;
    memcpyAsyncTaskInfo->copyType = RT_MEMCPY_DIR_D2D_SDMA;
    RT_LOG(
        RT_LOG_INFO, "Set memcpy type, kind=%u, direct=%u.", memcpyAsyncTaskInfo->copyKind,
        memcpyAsyncTaskInfo->copyType);
    memcpyAsyncTaskInfo->size = cpySize;
    if (cfgInfo != nullptr) {
        memcpyAsyncTaskInfo->qos = cfgInfo->qos;
        memcpyAsyncTaskInfo->partId = cfgInfo->partId;
        if (cfgInfo->d2dCrossFlag) {
            memcpyAsyncTaskInfo->isD2dCross = cfgInfo->d2dCrossFlag;
        }
    } else {
        memcpyAsyncTaskInfo->qos = 0U;
        memcpyAsyncTaskInfo->partId = 0U;
    }
    RT_LOG(RT_LOG_INFO, "Init qos=%u, partId=%u.", memcpyAsyncTaskInfo->qos, memcpyAsyncTaskInfo->partId);

    if (addrCfg != nullptr) {
        memcpyAsyncTaskInfo->d2dOffsetFlag = true;
        memcpyAsyncTaskInfo->dstOffset = addrCfg->dstOffset;
        memcpyAsyncTaskInfo->srcOffset = addrCfg->srcOffset;
        RT_LOG(
            RT_LOG_INFO, "cpySize=%llu, srcOffset=%llu, dstOffset=%llu.", memcpyAsyncTaskInfo->size,
            memcpyAsyncTaskInfo->srcOffset, memcpyAsyncTaskInfo->dstOffset);
    }

    memcpyAsyncTaskInfo->src = const_cast<void*>(srcAddr);
    memcpyAsyncTaskInfo->destPtr = desAddr;

    memcpyAsyncTaskInfo->dmaKernelConvertFlag = true;
    RT_LOG(RT_LOG_INFO, "CopyType=%u: use virtual address directly.", memcpyAsyncTaskInfo->copyType);
    return RT_ERROR_NONE;
}

rtError_t MemcpyAsyncD2HTaskInit(
    TaskInfo* const taskInfo, const void* srcAddr, const uint64_t cpySize, uint32_t sqId, uint32_t pos)
{
    UNUSED(taskInfo);
    UNUSED(srcAddr);
    UNUSED(cpySize);
    UNUSED(sqId);
    UNUSED(pos);
    return RT_ERROR_FEATURE_NOT_SUPPORT;
}

void SetStarsResultForMemcpyAsyncTask(TaskInfo* const taskInfo, const rtCqReport_t& logicCq)
{
    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) != 0U) {
        if ((logicCq.errorType & CQE_ERROR_MAP_TIMEOUT) != 0U) {
            taskInfo->errorCode = TS_ERROR_SDMA_TIMEOUT;
        } else if (logicCq.errorCode == TS_ERROR_SDMA_OVERFLOW) {
            taskInfo->errorCode = TS_ERROR_SDMA_OVERFLOW;
        } else {
            taskInfo->errorCode = TS_ERROR_SDMA_ERROR;
        }
    }
}

bool GetModuleIdByMemcpyAddr(Driver const* const driver, void* memcpyAddr, uint32_t* moduleId)
{
    if (driver == nullptr) {
        RT_LOG(RT_LOG_ERROR, "Get module id failed, driver is nullptr.");
        return false;
    }
    return driver->GetAddrModuleId(memcpyAddr, moduleId) == RT_ERROR_NONE;
}

void PrintModuleIdProc(Driver const* const driver, char_t* const errStr, void* src, void* dst, int32_t& countNum)
{
    uint32_t srcModuleId = SVM_INVALID_MODULE_ID;
    uint32_t dstModuleId = SVM_INVALID_MODULE_ID;
    if (GetModuleIdByMemcpyAddr(driver, RtPtrToPtr<void*>(&src), &srcModuleId) &&
        (srcModuleId != SVM_INVALID_MODULE_ID)) {
        countNum += snprintf_truncated_s(
            errStr + countNum, static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum), ", src_module_id=%u",
            srcModuleId);
    }
    if (GetModuleIdByMemcpyAddr(driver, RtPtrToPtr<void*>(&dst), &dstModuleId) &&
        (dstModuleId != SVM_INVALID_MODULE_ID)) {
        countNum += snprintf_truncated_s(
            errStr + countNum, static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum), ", dst_module_id=%u",
            dstModuleId);
    }
}

void PrintErrorInfoForMemcpyAsyncTask(TaskInfo* const taskInfo, const uint32_t devId)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream* const stream = taskInfo->stream;
    Driver* const driver = stream->Device_()->Driver_();
    char_t errMsg[MSG_LENGTH] = {};
    int32_t countNum = sprintf_s(
        errMsg, static_cast<size_t>(MSG_LENGTH),
        "Asynchronous memory copy failed, device_id=%u, stream_id=%d, task_id=%u, flip_num=%hu, ", devId, stream->Id_(),
        taskInfo->id, taskInfo->flipNum);
    if ((countNum < 0) || (countNum > MSG_LENGTH)) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Failed to call sprintf_s, count=%d.", countNum);
        return;
    }

    countNum += sprintf_s(
        errMsg + countNum, static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum),
        "copy_type=%s, copy_method=%u, memcpy_type=%u, copy_data_type=%u, length=%" PRIu64, "MEMCPY_DIR_D2D_SDMA(2)",
        static_cast<uint32_t>(memcpyAsyncTaskInfo->copyMethod),
        static_cast<uint32_t>(memcpyAsyncTaskInfo->dmaAddr.phyAddr.flag),
        static_cast<uint32_t>(memcpyAsyncTaskInfo->copyDataType), memcpyAsyncTaskInfo->size);
    countNum += snprintf_truncated_s(
        errMsg + countNum, static_cast<size_t>(MSG_LENGTH) - static_cast<uint64_t>(countNum),
        ", src_addr=%#" PRIx64 ", dst_addr=%#" PRIx64, RtPtrToValue(memcpyAsyncTaskInfo->src),
        RtPtrToValue(memcpyAsyncTaskInfo->destPtr));
    PrintModuleIdProc(driver, errMsg, memcpyAsyncTaskInfo->src, memcpyAsyncTaskInfo->destPtr, countNum);
    Stream* const reportStream = GetReportStream(stream);
    STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_RTS, "%s", errMsg);
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

    sqe->u.memcpyAsyncWithoutSdmaInfo.src = RtPtrToValue(memcpyAsyncTaskInfo->src);
    sqe->u.memcpyAsyncWithoutSdmaInfo.dest = RtPtrToValue(memcpyAsyncTaskInfo->destPtr);
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

void MemcpyAsyncTaskUnInit(TaskInfo* const taskInfo)
{
    MemcpyAsyncTaskInfo* memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    memcpyAsyncTaskInfo->src = nullptr;
    memcpyAsyncTaskInfo->destPtr = nullptr;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.flag = 0U;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.len = 0U;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.dst = nullptr;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.src = nullptr;
    memcpyAsyncTaskInfo->dmaAddr.phyAddr.priv = nullptr;
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

void DoCompleteSuccessForMemcpyAsyncTask(TaskInfo* const taskInfo, const uint32_t devId)
{
    Stream* const stream = taskInfo->stream;
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
