/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <algorithm>
#include <cinttypes>
#include <string>
#include <vector>

#include "stream.hpp"
#include "runtime.hpp"
#include "driver.hpp"
#include "thread_local_container.hpp"
#include "stars_cond_isa_helper.hpp"
#include "stars_arg_manager.hpp"
#include "event.hpp"
#include "notify.hpp"
#include "task_fail_callback_manager.hpp"
#include "device/device_error_proc.hpp"
#include "hwts.hpp"
#include "common_task.h"
#include "task_manager.h"
#include "model.hpp"
#include "error_code.h"
#include "davinci_kernel_task.h"
#include "ffts_task.h"

namespace cce {
namespace runtime {
namespace {
const std::set<int32_t> MEM_ERROR_CODE = {TS_ERROR_AICORE_MTE_ERROR,
                                          TS_ERROR_SDMA_LINK_ERROR,
                                          TS_ERROR_SDMA_POISON_ERROR};

// FFTS 失败路径只做轻量可观测增强：围绕上报的 contextId 打印结构化摘要和原始 context，
// 避免在正常路径引入额外观测开销。
struct FftsPlusContextTypeName {
    uint16_t contextType;
    const char *name;
};

std::string GetFftsPlusContextTypeName(const uint16_t contextType)
{
    static constexpr FftsPlusContextTypeName fftsPlusContextTypeNames[] = {
        {RT_CTX_TYPE_AICORE, "AICORE"},
        {RT_CTX_TYPE_AIV, "AIV"},
        {RT_CTX_TYPE_MIX_AIC, "MIX_AIC"},
        {RT_CTX_TYPE_MIX_AIV, "MIX_AIV"},
        {RT_CTX_TYPE_SDMA, "SDMA"},
        {RT_CTX_TYPE_NOTIFY_WAIT, "NOTIFY_WAIT"},
        {RT_CTX_TYPE_NOTIFY_RECORD, "NOTIFY_RECORD"},
        {RT_CTX_TYPE_WRITE_VALUE, "WRITE_VALUE"},
        {RT_CTX_TYPE_FLUSH_DATA, "FLUSH_DATA"},
        {RT_CTX_TYPE_INVALIDATE_DATA, "INVALIDATE_DATA"},
        {RT_CTX_TYPE_WRITEBACK_DATA, "WRITEBACK_DATA"},
        {RT_CTX_TYPE_AICPU, "AICPU"},
        {RT_CTX_TYPE_COND_SWITCH, "COND_SWITCH"},
        {RT_CTX_TYPE_CASE_SWITCH, "CASE_SWITCH"},
        {RT_CTX_TYPE_AT_START, "AT_START"},
        {RT_CTX_TYPE_AT_END, "AT_END"},
        {RT_CTX_TYPE_LABEL, "LABEL"},
        {RT_CTX_TYPE_PERSISTENT_CACHE, "PERSISTENT_CACHE"},
        {RT_CTX_TYPE_DSA, "DSA"},
        {RT_CTX_TYPE_WRITE_VALUE_RDMA, "WRITE_VALUE_RDMA"},
    };

    for (const auto &contextTypeName : fftsPlusContextTypeNames) {
        if (contextTypeName.contextType == contextType) {
            return contextTypeName.name;
        }
    }
    return "UNKNOWN";
}

rtError_t CopyFftsPlusContextToHost(TaskInfo *taskInfo, const uint32_t contextId, void *ctxInfo)
{
    FftsPlusTaskInfo *fftsPlusTask = &taskInfo->u.fftsPlusTask;
    const uint64_t offset = static_cast<uint64_t>(contextId) * CONTEXT_LEN;
    // 所有失败处理分支都复用这层保护，遇到 contextId 非法、descriptor 为空或越界时，
    // 统一停在一条明确错误上，避免继续打印派生噪声。
    COND_RETURN_ERROR_MSG_INNER((ctxInfo == nullptr) || (fftsPlusTask->descAlignBuf == nullptr) ||
        ((offset + CONTEXT_LEN) > fftsPlusTask->descBufLen), RT_ERROR_INVALID_VALUE,
        "invalid ffts context copy request, context_id=%u, descBufLen=%" PRIu64 ".", contextId, fftsPlusTask->descBufLen);

    return taskInfo->stream->Device_()->Driver_()->MemCopySync(ctxInfo, CONTEXT_LEN,
        static_cast<void *>((reinterpret_cast<uint8_t *>(fftsPlusTask->descAlignBuf)) + offset),
        CONTEXT_LEN, RT_MEMCPY_DEVICE_TO_HOST);
}

void LogFftsPlusContextDetail(TaskInfo *taskInfo, const uint32_t devId, const uint32_t contextId,
    const uint8_t *ctxInfo)
{
    const auto * const commonCtx = reinterpret_cast<const rtFftsPlusComCtx_t *>(ctxInfo);
    const auto * const buf = reinterpret_cast<const uint32_t *>(ctxInfo);
    const std::string contextTypeName = GetFftsPlusContextTypeName(commonCtx->contextType);
    RT_LOG(RT_LOG_ERROR, "fftsplus context detail, dev_id=%u, stream_id=%d, task_id=%u, context_id=%u, "
        "context_type=%u[%s], successor_num=%u, thread_id=%u, thread_dim=%u.",
        devId, taskInfo->stream->Id_(), taskInfo->id, contextId, commonCtx->contextType,
        contextTypeName.c_str(), commonCtx->successorNum,
        commonCtx->threadId, commonCtx->threadDim);
    for (uint32_t j = 0U; j < (CONTEXT_LEN / sizeof(uint32_t)); ++j) {
        RT_LOG(RT_LOG_ERROR, "FftsPlusTask-%s The %u context-buf[%u]=%#010x.", contextTypeName.c_str(),
            contextId, j, buf[j]);
    }
}

rtError_t CheckFftsPlusDsaContext(const void * const descBuf, const uint64_t descBufLen)
{
    if (descBufLen == 0U) {
        return RT_ERROR_NONE;
    }
    COND_RETURN_ERROR_MSG_INNER(descBuf == nullptr, RT_ERROR_INVALID_VALUE,
        "fftsplus desc buffer is null, desc_buf_len=%" PRIu64 ".", descBufLen);
    COND_RETURN_ERROR_MSG_INNER((descBufLen % CONTEXT_LEN) != 0U, RT_ERROR_INVALID_VALUE,
        "fftsplus desc buffer length is invalid, desc_buf_len=%" PRIu64 ".", descBufLen);

    const uint32_t contextNum = static_cast<uint32_t>(descBufLen / CONTEXT_LEN);
    const auto * const contextBuf = static_cast<const uint8_t *>(descBuf);
    for (uint32_t i = 0U; i < contextNum; ++i) {
        const auto * const context =
            RtPtrToPtr<const rtFftsPlusComCtx_t *, const uint8_t *>(contextBuf + (static_cast<uint64_t>(i) * CONTEXT_LEN));
        COND_RETURN_AND_MSG_OUTER(context->contextType == RT_CTX_TYPE_DSA, RT_ERROR_FEATURE_NOT_SUPPORT,
            ErrorCode::EE1006, __func__,  "random number generation subtask"); 
    }
    return RT_ERROR_NONE;
}

rtError_t CheckFftsPlusDsaContextFromDevice(TaskInfo *taskInfo, const rtFftsPlusTaskInfo_t * const fftsPlusTaskInfo)
{
    FftsPlusTaskInfo * const fftsPlusTask = &taskInfo->u.fftsPlusTask;
    if (fftsPlusTask->descBufLen == 0U) {
        return RT_ERROR_NONE;
    }
    COND_RETURN_ERROR_MSG_INNER(fftsPlusTaskInfo->descBuf == nullptr, RT_ERROR_INVALID_VALUE,
        "fftsplus device desc buffer is null, desc_buf_len=%" PRIu64 ".", fftsPlusTask->descBufLen);

    std::vector<uint8_t> hostDesc(static_cast<size_t>(fftsPlusTask->descBufLen));
    const rtError_t error = taskInfo->stream->Device_()->Driver_()->MemCopySync(hostDesc.data(), fftsPlusTask->descBufLen,
        fftsPlusTaskInfo->descBuf, fftsPlusTask->descBufLen, RT_MEMCPY_DEVICE_TO_HOST);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error,
        "copy fftsplus device desc to host failed, retCode=%#x, desc_buf_len=%" PRIu64 ".",
        error, fftsPlusTask->descBufLen);
    return CheckFftsPlusDsaContext(hostDesc.data(), fftsPlusTask->descBufLen);
}
} // namespace 

constexpr const uint16_t STARS_DATADUMP_LOADINFO_END_BITMAP = 0x20U;

#if F_DESC("FftsPlusTask")
// static constexpr uint32_t CONTEXT_LEN = 128U;               // 128B
static void DeallocFftsPlusDescMem(TaskInfo* taskInfo)
{
    if (taskInfo->u.fftsPlusTask.descBuf != nullptr) {
        const auto dev = taskInfo->stream->Device_();
        (void) (dev->Driver_())->DevMemFree(taskInfo->u.fftsPlusTask.descBuf, dev->Id_());
        taskInfo->u.fftsPlusTask.descBuf = nullptr;
    }
    taskInfo->u.fftsPlusTask.descAlignBuf = nullptr;
}

rtError_t FillFftsPlusSqe(TaskInfo* taskInfo, const void * const devMem)
{
    FftsPlusTaskInfo *fftsPlusTask = &taskInfo->u.fftsPlusTask;
    const uint32_t size = sizeof(fftsPlusTask->fftsSqe.reserved16) / sizeof(fftsPlusTask->fftsSqe.reserved16[0]);

    for (size_t i = 0LU; i < size; i++) {
        fftsPlusTask->fftsSqe.reserved16[i] = 0U;
    }

    rtStarsFftsPlusHeader_t *sqeHeader = reinterpret_cast<rtStarsFftsPlusHeader_t *>(&fftsPlusTask->fftsSqe.sqeHeader);
    sqeHeader->type = 0U;
    sqeHeader->ie   = 0U;
    sqeHeader->preP = 0U;
    sqeHeader->postP = 0U;
    if ((fftsPlusTask->kernelFlag & RT_KERNEL_DUMPFLAG) != 0U) {
        if (taskInfo->stream->IsOverflowEnable()) {
            sqeHeader->preP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
        }
        sqeHeader->postP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
        fftsPlusTask->fftsSqe.reserved16[1U] = fftsPlusTask->fftsSqe.reserved16[1U] | SQE_BIZ_FLAG_DATADUMP;
        RT_LOG(RT_LOG_INFO, "sqe set dumpflag");
    }

    sqeHeader->wrCqe = taskInfo->stream->GetStarsWrCqeFlag();

    sqeHeader->rtStreamId = static_cast<uint16_t>(taskInfo->stream->Id_());
    sqeHeader->taskId = taskInfo->id;
    sqeHeader->overflowEn = taskInfo->stream->IsOverflowEnable();

    fftsPlusTask->fftsSqe.fftsType = RT_FFTS_PLUS_TYPE;
    fftsPlusTask->fftsSqe.kernelCredit = RT_STARS_MAX_KERNEL_CREDIT;

    // Config software timeout in fftsplus when hccl launch
    Device *device = taskInfo->stream->Device_();
    const bool supportFlag = device->CheckFeatureSupport(TS_FEATURE_FFTSPLUS_TIMEOUT);
    if (supportFlag &&
        ((fftsPlusTask->fftsSqe.subType == RT_STARS_FFTSPLUS_HCCL_WITHOUT_AICAIV_FLAG) ||
        (fftsPlusTask->fftsSqe.subType == RT_STARS_FFTSPLUS_HCCL_WITH_AICAIV_FLAG)) &&
        (!taskInfo->stream->GetBindFlag())) {
        const uint16_t timeoutConfig = fftsPlusTask->fftsSqe.timeout;
        if (timeoutConfig == 0U) {
            fftsPlusTask->fftsSqe.timeout = RT_STARS_DEFAULT_HCCL_FFTSPLUS_TIMEOUT;
        } else if (timeoutConfig == static_cast<uint16_t>(UINT16_MAX)) {
            fftsPlusTask->fftsSqe.timeout = 0U;
        } else {
            // no operation
        }
        fftsPlusTask->fftsSqe.kernelCredit = RT_STARS_NEVER_TIMEOUT_KERNEL_CREDIT;
        RT_LOG(RT_LOG_INFO, "Begin to Create Ffts Plus Task timeoutConfig=%u, timeout=%us, subType=%u.",
            timeoutConfig, fftsPlusTask->fftsSqe.timeout, fftsPlusTask->fftsSqe.subType);
    }

    fftsPlusTask->fftsSqe.dsaSqId = 0U;

    const uint64_t stackPhyBase =
        static_cast<uint64_t>(reinterpret_cast<uintptr_t>(device->GetStackPhyBase32k()));
    fftsPlusTask->fftsSqe.stackPhyBaseL = static_cast<uint32_t>(stackPhyBase);
    fftsPlusTask->fftsSqe.stackPhyBaseH = static_cast<uint32_t>(stackPhyBase >> UINT32_BIT_NUM);
    const uint64_t devMemAddr = static_cast<uint64_t>(reinterpret_cast<uintptr_t>(devMem));
    fftsPlusTask->fftsSqe.contextAddressBaseL = static_cast<uint32_t>(devMemAddr);
    fftsPlusTask->fftsSqe.contextAddressBaseH =
        (static_cast<uint32_t>(devMemAddr >> UINT32_BIT_NUM)) & MASK_17_BIT;
    if ((CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_INFO) == 1) ||
        (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_DEBUG) == 1)) {
        fftsPlusTask->fftsSqe.scheduleDfxFlag = 1U;
    }
    if (fftsPlusTask->errInfo == nullptr) {
        fftsPlusTask->errInfo = new (std::nothrow) std::vector<rtFftsPlusTaskErrInfo_t>();
        COND_RETURN_AND_MSG_OUTER(fftsPlusTask->errInfo == nullptr, RT_ERROR_MEMORY_ALLOCATION,
            ErrorCode::EE1013, std::to_string(sizeof(std::vector<rtFftsPlusTaskErrInfo_t>)));
    }

    return RT_ERROR_NONE;
}

static void ShowFftsPlusTaskDebug(TaskInfo* taskInfo, const rtFftsPlusTaskInfo_t * const fftsPlusTaskInfo,
    const FftsPlusTaskInfo *fftsPlusTask)
{
    if (CheckLogLevel(static_cast<int32_t>(RUNTIME), DLOG_INFO) == 0) {
        return;
    }

    RT_LOG(RT_LOG_INFO, "descBuf=%p, descAlignBuf=%p", fftsPlusTask->descBuf, fftsPlusTask->descAlignBuf);

    // print context for debug
    RT_LOG(RT_LOG_INFO, "FftsPlusTask-begin-context,descBufLen_=%" PRIu64, fftsPlusTask->descBufLen);
    for (uint32_t i = 0U; i < (fftsPlusTask->descBufLen / 128U); i++) {
        RT_LOG(RT_LOG_INFO, "stream_id=%d,task_id=%u,FftsPlusTask-The %u context:", taskInfo->stream->Id_(),
            taskInfo->id, i);
        const uint32_t * const buf = static_cast<const uint32_t *>(fftsPlusTaskInfo->descBuf) + (i * 32U);
        for (uint32_t j = 0U; j < 32U; j++) {
            RT_LOG(RT_LOG_INFO, "FftsPlusTask-The %u context-buf[%u]=%#010x.", i, j, buf[j]);
        }
    }
    RT_LOG(RT_LOG_INFO, "FftsPlusTask-end-context");

    return;
}

TIMESTAMP_EXTERN(FftsPlusTaskH2Dcpy);
TIMESTAMP_EXTERN(FftsPlusTaskAlloc);
static rtError_t FftsPlusTmpAllocH2D(TaskInfo* taskInfo, const rtFftsPlusTaskInfo_t * const fftsPlusTaskInfo,
    FftsPlusTaskInfo *fftsPlusTask)
{
    // malloc device memory
    const auto dev = taskInfo->stream->Device_();
    TIMESTAMP_BEGIN(FftsPlusTaskAlloc);
    rtError_t ret = (dev->Driver_())->DevMemAlloc(&fftsPlusTask->descBuf,
        static_cast<uint64_t>(fftsPlusTask->descBufLen + CONTEXT_ALIGN_LEN),
        RT_MEMORY_HBM, dev->Id_());
    TIMESTAMP_END(FftsPlusTaskAlloc);
    COND_RETURN_ERROR((ret != RT_ERROR_NONE) || (fftsPlusTask->descBuf == nullptr), ret,
                      "alloc fftsPlusDescDev failed, retCode=%#x, descBufLen=%" PRIu64 "(bytes), dev_id=%u.",
                      ret, fftsPlusTask->descBufLen, dev->Id_());
    // 128-byte alignment
    const uint64_t descAlign = (reinterpret_cast<uint64_t>(fftsPlusTask->descBuf) & 0x7fU) == 0U ?
        reinterpret_cast<uint64_t>(fftsPlusTask->descBuf) :
        (((reinterpret_cast<uint64_t>(fftsPlusTask->descBuf) >> CONTEXT_ALIGN_BIT) + 1U) <<  CONTEXT_ALIGN_BIT);
    fftsPlusTask->descAlignBuf = reinterpret_cast<void *>(descAlign);
    ShowFftsPlusTaskDebug(taskInfo, fftsPlusTaskInfo, fftsPlusTask);
    // cpy context from host to device
    TIMESTAMP_BEGIN(FftsPlusTaskH2Dcpy);
    ret = dev->Driver_()->MemCopySync(fftsPlusTask->descAlignBuf, fftsPlusTask->descBufLen,
        fftsPlusTaskInfo->descBuf, fftsPlusTask->descBufLen, RT_MEMCPY_HOST_TO_DEVICE);
    TIMESTAMP_END(FftsPlusTaskH2Dcpy);
    if (ret != RT_ERROR_NONE) {
        DeallocFftsPlusDescMem(taskInfo);
        RT_LOG(RT_LOG_ERROR, "MemCopySync for args failed, retCode=%#x.", static_cast<uint32_t>(ret));
        return ret;
    }
    return RT_ERROR_NONE;
}

static rtError_t FftsPlusPoolH2D(TaskInfo* taskInfo, const rtFftsPlusTaskInfo_t * const fftsPlusTaskInfo,
    FftsPlusTaskInfo *fftsPlusTask)
{
    rtArgsEx_t pureArgsInfo = {};
    pureArgsInfo.args = const_cast<void*>(static_cast<const void*>(fftsPlusTaskInfo->descBuf));
    pureArgsInfo.argsSize = static_cast<uint32_t>(fftsPlusTask->descBufLen);
    StarsArgLoaderResult result = {};
    const rtError_t error = taskInfo->stream->LoadArgsInfo(&pureArgsInfo, false, &result, LoadPolicy::LP_FFTS);
    COND_RETURN_ERROR_MSG_INNER(error != RT_ERROR_NONE, error, "FftsPlusPoolH2D Failed, stream_id=%d,"
        " retCode=%#x, size=%" PRIu64, taskInfo->stream->Id_(), static_cast<uint32_t>(error), fftsPlusTask->descBufLen);

    fftsPlusTask->argHandle = result.handle;
    fftsPlusTask->descBuf = result.kerArgs;
    fftsPlusTask->descAlignBuf = result.kerArgs;
    ShowFftsPlusTaskDebug(taskInfo, fftsPlusTaskInfo, fftsPlusTask);
    return RT_ERROR_NONE;
}

static rtError_t FftsPlusTaskFillArgsAddr(TaskInfo* taskInfo, const rtFftsPlusTaskInfo_t * const fftsPlusTaskInfo)
{
    const uint32_t argsHandleInfoNum = fftsPlusTaskInfo->argsHandleInfoNum;
    const auto dev = taskInfo->stream->Device_();

    COND_RETURN_ERROR_MSG_INNER(dev == nullptr, RT_ERROR_INVALID_VALUE, "device is null, stream_id=%d,",
        taskInfo->stream->Id_());

    if ((argsHandleInfoNum != 0) && (fftsPlusTaskInfo->argsHandleInfoPtr != nullptr)) {
        taskInfo->u.fftsPlusTask.argsHandleInfoPtr = new (std::nothrow) std::vector<void *>();
        COND_RETURN_AND_MSG_OUTER(taskInfo->u.fftsPlusTask.argsHandleInfoPtr == nullptr, RT_ERROR_MEMORY_ALLOCATION,
            ErrorCode::EE1013, std::to_string(sizeof(std::vector<void *>)));
        for (uint32_t i = 0U; i < argsHandleInfoNum; i++) {
            const Handle * const argHdl = static_cast<Handle *>(fftsPlusTaskInfo->argsHandleInfoPtr[i]);
            if (argHdl == nullptr) {
                continue;
            }
            taskInfo->u.fftsPlusTask.argsHandleInfoPtr->push_back(fftsPlusTaskInfo->argsHandleInfoPtr[i]);
        }
    }
    return RT_ERROR_NONE;
}

rtError_t FftsPlusTaskInit(TaskInfo* taskInfo, const rtFftsPlusTaskInfo_t * const fftsPlusTaskInfo,
                           const uint32_t flag)
{
    rtError_t error = RT_ERROR_NONE;
    TaskCommonInfoInit(taskInfo);
    taskInfo->typeName = "FFTS_PLUS";
    taskInfo->type = TS_TASK_TYPE_FFTS_PLUS;

    FftsPlusTaskInfo *fftsPlusTask = &taskInfo->u.fftsPlusTask;
    fftsPlusTask->descBuf = nullptr;
    fftsPlusTask->descAlignBuf = nullptr;
    fftsPlusTask->argHandle = nullptr;
    fftsPlusTask->descBufLen = 0ULL;
    fftsPlusTask->kernelFlag = static_cast<uint8_t>(flag);
    fftsPlusTask->loadDumpInfo = 0ULL;
    fftsPlusTask->loadDumpInfoLen = 0U;
    fftsPlusTask->loadDumpInfo = 0ULL;
    fftsPlusTask->unloadDumpInfoLen = 0U;
    fftsPlusTask->argsHandleInfoNum = fftsPlusTaskInfo->argsHandleInfoNum;
    fftsPlusTask->argsHandleInfoPtr = nullptr;

    uint32_t descAddrType = fftsPlusTaskInfo->descAddrType;
    RT_LOG(RT_LOG_INFO, "totalContextNum=%hu, readyContextNum=%hu, flag=%u, descAddrType=%u, argsHandleInfoNum=%u.",
        fftsPlusTaskInfo->fftsPlusSqe->totalContextNum, fftsPlusTaskInfo->fftsPlusSqe->readyContextNum,
        flag, descAddrType, fftsPlusTask->argsHandleInfoNum);

    if ((fftsPlusTask->kernelFlag & RT_KERNEL_FFTSPLUS_DYNAMIC_SHAPE_DUMPFLAG) != 0U) {
        fftsPlusTask->loadDumpInfo = reinterpret_cast<uintptr_t>(fftsPlusTaskInfo->fftsPlusDumpInfo.loadDumpInfo);
        fftsPlusTask->loadDumpInfoLen = fftsPlusTaskInfo->fftsPlusDumpInfo.loadDumpInfolen;
        fftsPlusTask->unloadDumpInfo = reinterpret_cast<uintptr_t>(fftsPlusTaskInfo->fftsPlusDumpInfo.unloadDumpInfo);
        fftsPlusTask->unloadDumpInfoLen = fftsPlusTaskInfo->fftsPlusDumpInfo.unloadDumpInfolen;
    }
    error = FftsPlusTaskFillArgsAddr(taskInfo, fftsPlusTaskInfo);
    COND_PROC(error != RT_ERROR_NONE, return error);
    // sqe copy
    constexpr size_t sqeSize = sizeof(rtFftsPlusSqe_t);
    (void)memcpy_s(&fftsPlusTask->fftsSqe, sqeSize, fftsPlusTaskInfo->fftsPlusSqe, sqeSize);

    fftsPlusTask->inputArgsSize.infoAddr = nullptr;
    fftsPlusTask->inputArgsSize.atomicIndex = 0U;
    rtArgsSizeInfo_t &argsSize = ThreadLocalContainer::GetArgsSizeInfo();
    if (argsSize.infoAddr != nullptr) {
        fftsPlusTask->inputArgsSize.infoAddr = argsSize.infoAddr;
        fftsPlusTask->inputArgsSize.atomicIndex = argsSize.atomicIndex;
        argsSize.infoAddr = nullptr;
        argsSize.atomicIndex = 0U;
        RT_LOG(RT_LOG_INFO, "infoAddr=%p, atomicIndex=%u.",
               fftsPlusTask->inputArgsSize.infoAddr, fftsPlusTask->inputArgsSize.atomicIndex);
    }

    fftsPlusTask->descBufLen = fftsPlusTaskInfo->descBufLen;
    error = RT_ERROR_INVALID_VALUE;
    if (descAddrType == RT_FFTS_PLUS_CTX_DESC_ADDR_TYPE_HOST) {
        error = CheckFftsPlusDsaContext(fftsPlusTaskInfo->descBuf, fftsPlusTask->descBufLen);
        COND_PROC(error != RT_ERROR_NONE, return error);
        if ((taskInfo->stream->Device_() != nullptr) &&
            (taskInfo->stream->Device_()->ArgLoader_() != nullptr) &&
            (taskInfo->stream->Device_()->ArgLoader_()->CheckPcieBar()) &&
            (fftsPlusTask->descBufLen <= PCIE_BAR_COPY_SIZE)) {
            RT_LOG(RT_LOG_INFO, "using pcie Bar cpy, size=%lu.", fftsPlusTask->descBufLen);
            error = FftsPlusPoolH2D(taskInfo, fftsPlusTaskInfo, fftsPlusTask);
        } else {
            RT_LOG(RT_LOG_INFO, "using normal cpy, size=%lu.", fftsPlusTask->descBufLen);
            error = FftsPlusTmpAllocH2D(taskInfo, fftsPlusTaskInfo, fftsPlusTask);
        }
        COND_PROC(error != RT_ERROR_NONE, return error);
        error = FillFftsPlusSqe(taskInfo, fftsPlusTask->descAlignBuf);
    } else if (descAddrType == RT_FFTS_PLUS_CTX_DESC_ADDR_TYPE_DEVICE) {
        error = CheckFftsPlusDsaContextFromDevice(taskInfo, fftsPlusTaskInfo);
        COND_PROC(error != RT_ERROR_NONE, return error);
        fftsPlusTask->descAlignBuf = const_cast<void *>(fftsPlusTaskInfo->descBuf);
        RT_LOG(RT_LOG_INFO, "stream_id=%d, task_id=%u, Device addr:descAlignBuf=%" PRIu64 ", descBufLen=%" PRIu64 ".",
            taskInfo->stream->Id_(), taskInfo->id, fftsPlusTask->descAlignBuf, fftsPlusTask->descBufLen);
        error = FillFftsPlusSqe(taskInfo, fftsPlusTaskInfo->descBuf);
    } else {
        // no op
    }
    return error;
}

static void ReleaseArgsHandleForFftsPlusTask(TaskInfo* taskInfo)
{
    Stream *stm = taskInfo->stream;
    FftsPlusTaskInfo *fftsPlusTask = &taskInfo->u.fftsPlusTask;
    if (fftsPlusTask->argsHandleInfoPtr != nullptr) {
        for (auto iter : *(fftsPlusTask->argsHandleInfoPtr)) {
            if (iter != nullptr) {
                Handle * const argHdl = static_cast<Handle *>(iter);
                RT_LOG(RT_LOG_INFO, "device_id=%u, stream_id=%d, task_id=%u, argsHandleInfoNum=%u, argHdl=%#" PRIx64
                    ", argdevaddr=%#" PRIx64 "argsHandleInfoPtr=%p", stm->Device_()->Id_(), stm->Id_(), taskInfo->id,
                    fftsPlusTask->argsHandleInfoNum, argHdl, argHdl->argsAlloc->GetDevAddr(argHdl->kerArgs),
                    fftsPlusTask->argsHandleInfoPtr);
                const bool isModel = (stm->Model_() != nullptr);
                if (isModel) {
                    static_cast<Model *>(stm->Model_())->PushbackArgHandle(static_cast<uint16_t>(stm->Id_()),
                        taskInfo->id, argHdl);
                } else {
                    (void)stm->Device_()->ArgLoader_()->Release(argHdl);
                }
            }
        }
        fftsPlusTask->argsHandleInfoPtr->clear();
        delete fftsPlusTask->argsHandleInfoPtr;
        fftsPlusTask->argsHandleInfoPtr = nullptr;
        fftsPlusTask->argsHandleInfoNum = 0U;
    }
}

void FftsPlusTaskUnInit(TaskInfo * const taskInfo)
{
    Stream *stm = taskInfo->stream;
    if (taskInfo->u.fftsPlusTask.errInfo != nullptr) {
        taskInfo->u.fftsPlusTask.errInfo->clear();
        delete taskInfo->u.fftsPlusTask.errInfo;
        taskInfo->u.fftsPlusTask.errInfo = nullptr;
    }
    if (taskInfo->u.fftsPlusTask.argHandle != nullptr) {
        if (stm->IsSeparateSendAndRecycle()) {
            stm->Device_()->PushFftsPlusArgHandle(taskInfo->u.fftsPlusTask.argHandle);
        } else {
            (void)stm->Device_()->ArgLoader_()->Release(taskInfo->u.fftsPlusTask.argHandle);
        }
        taskInfo->u.fftsPlusTask.descBuf = nullptr;
        taskInfo->u.fftsPlusTask.argHandle = nullptr;
    }

    DeallocFftsPlusDescMem(taskInfo);
    ReleaseArgsHandleForFftsPlusTask(taskInfo);
}

static void ConstructFftsPlusDumpInfoSqe(const TaskInfo *const taskInfo, rtStarsSqe_t * const command,
                                  const uint64_t dumpInfo, const uint32_t len, const uint16_t flag)
{
    RtStarsPhSqe * const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = taskInfo->stream->GetStarsWrCqeFlag();
    sqe->res0 = 0U;

    sqe->rt_streamID = static_cast<uint16_t>(taskInfo->stream->Id_());
    sqe->task_id = taskInfo->id;
    sqe->task_type = TS_TASK_TYPE_DATADUMP_LOADINFO;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.data_dump_load_info.dumpinfoPtr = dumpInfo;
    sqe->u.data_dump_load_info.length = len;
    sqe->u.data_dump_load_info.stream_id = static_cast<uint16_t>(taskInfo->stream->Id_());
    sqe->u.data_dump_load_info.task_id = taskInfo->id;
    sqe->u.data_dump_load_info.reserved = flag;
    PrintSqe(command, "FftsPlusDumpInfo");

    RT_LOG(RT_LOG_INFO, "FftsPlus add dataDumpInfoTask stream_id=%d task_id=%hu",
        taskInfo->stream->Id_(), taskInfo->id);
}

static void ConstructFftsPlusSqe(TaskInfo* taskInfo, rtStarsSqe_t * const command)
{
    // update taskid after SetSerialId
    FftsPlusTaskInfo *fftPlusTask = &taskInfo->u.fftsPlusTask;

    fftPlusTask->fftsSqe.sqeHeader.taskId = taskInfo->id;
    const errno_t error = memcpy_s(command, sizeof(rtStarsSqe_t), &fftPlusTask->fftsSqe, sizeof(fftPlusTask->fftsSqe));
    if (error != EOK) {
        command->fftsPlusSqe.sqeHeader.type = RT_STARS_SQE_TYPE_INVALID;
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Failed to call memcpy_s to copy fftPlusTask->fftsSqe, src=%p, dest=%p,"
            " dest_max=%zu, count=%zu, retCode=%#x.", &fftPlusTask->fftsSqe, command, sizeof(rtStarsSqe_t),
            sizeof(fftPlusTask->fftsSqe), error);
    }

    PrintSqe(command, "FftsPlus");
    RT_LOG(RT_LOG_INFO, "FftsPlusTask stream_id=%d, task_id=%hu, dsa_sq_id=%u", taskInfo->stream->Id_(),
        taskInfo->id, fftPlusTask->fftsSqe.dsaSqId);
}
static void SqeTaskUpdateForAllFftsPlus(rtStarsSqe_t * const fftsplusSqe) // plan B
{
    const uint16_t realStreamId = fftsplusSqe->fftsPlusSqe.sqeHeader.rtStreamId;
    const uint16_t realTaskId = fftsplusSqe->fftsPlusSqe.sqeHeader.taskId;
    // task_id[0:11] + updateflag[12:0, 13:1] + stream_id[14:15] = stream_id
    fftsplusSqe->fftsPlusSqe.sqeHeader.rtStreamId = (realTaskId & RT_MASK_BIT0_BIT11) |
            static_cast<uint16_t>(RT_TASK_UPDATE_FLAG_FOR_ALL << RT_TASK_UPDATE_FLAG_BIT12) | 
            (realStreamId & RT_MASK_BIT14_BIT15);
    // stream_id[0:11] + task_id[12:15] = task_id
    fftsplusSqe->fftsPlusSqe.sqeHeader.taskId = (realStreamId & RT_MASK_BIT0_BIT11)
                                                 | (realTaskId & (RT_MASK_BIT12 | RT_MASK_BIT13_BIT15));

    RT_LOG(RT_LOG_DEBUG, "Update fftsplus sqe for all, real_stream_id=%hu, real_task_id=%hu, "
        "new_stream_id=%hu, new_task_id=%hu", realStreamId, realTaskId,
        fftsplusSqe->fftsPlusSqe.sqeHeader.rtStreamId, fftsplusSqe->fftsPlusSqe.sqeHeader.taskId);
}

static void SqeTaskUpdateForExpandSpec(rtStarsSqe_t * const fftsplusSqe) // plan C
{
    const uint16_t realStreamId = fftsplusSqe->fftsPlusSqe.sqeHeader.rtStreamId;
    const uint16_t realTaskId = fftsplusSqe->fftsPlusSqe.sqeHeader.taskId;

    // task_id[0:14] + updateFlag bit15:1 = stream_id
    fftsplusSqe->fftsPlusSqe.sqeHeader.rtStreamId = (realTaskId & RT_MASK_BIT0_BIT14) |
        (RT_UPDATE_FOR_STREAM_EXTEND << RT_UPDATE_FOR_STREAM_EXTEND_FLAG_BIT);
    // stream_id[0:14] + task_id[15] = task_id
    fftsplusSqe->fftsPlusSqe.sqeHeader.taskId = (realStreamId & RT_MASK_BIT0_BIT14) | (realTaskId & RT_MASK_BIT15);

    RT_LOG(RT_LOG_DEBUG, "Update fftsplus sqe for expand spec, real_stream_id=%hu, real_task_id=%hu, "
        "new_stream_id=%hu, new_task_id=%hu", realStreamId, realTaskId,
        fftsplusSqe->fftsPlusSqe.sqeHeader.rtStreamId, fftsplusSqe->fftsPlusSqe.sqeHeader.taskId);
}

void SqeTaskUpdateForFftsPlus(TaskInfo* taskInfo, rtStarsSqe_t * const fftsplusSqe)
{
    Device *device = taskInfo->stream->Device_();

    // update plan C
    if (device->CheckFeatureSupport(TS_FEATURE_SOFTWARE_SQ_ENABLE)) {
        SqeTaskUpdateForExpandSpec(fftsplusSqe);
        return;
    }

    // update plan B
    if (device->CheckFeatureSupport(TS_FEATURE_TASK_SAME_FOR_ALL)) {
        SqeTaskUpdateForAllFftsPlus(fftsplusSqe);
        return;
    }

    if (!device->CheckFeatureSupport(TS_FEATURE_FFTSPLUS_TASKID_SAME_FIX)) {
        RT_LOG(RT_LOG_DEBUG, "driver version is not supported");
        return;
    }
    if ((fftsplusSqe->fftsPlusSqe.subType != RT_STARS_FFTSPLUS_HCCL_WITHOUT_AICAIV_FLAG) &&
        (fftsplusSqe->fftsPlusSqe.subType != RT_STARS_FFTSPLUS_HCCL_WITH_AICAIV_FLAG)) {
        return;
    }
    // update Plan A
    Stream *strm = taskInfo->stream;
    const uint16_t realStreamId = fftsplusSqe->fftsPlusSqe.sqeHeader.rtStreamId;
    const uint16_t realTaskId = fftsplusSqe->fftsPlusSqe.sqeHeader.taskId;
    if (strm->hcclIndex_ == static_cast<uint16_t>(UINT16_MAX)) {
        const std::lock_guard<std::mutex> lk(device->GetHcclStreamIndexMutex());
        uint16_t allocIndex = static_cast<uint16_t>(UINT16_MAX);
        if (!device->AllocHcclIndex(allocIndex, static_cast<uint16_t>(strm->Id_()))) {
            return;
        }
        strm->hcclIndex_ = allocIndex;
        RT_LOG(RT_LOG_DEBUG, "stream_id=%d, hcclIndex_=%hu.", strm->Id_(), strm->hcclIndex_);
    }
    // streamid[0:11] + updateflag + taskid[13:15]
    fftsplusSqe->fftsPlusSqe.sqeHeader.rtStreamId = (realStreamId & RT_MASK_BIT0_BIT11) |
            (0x1U << RT_TASK_UPDATE_FLAG_BIT12) | (realTaskId & RT_MASK_BIT13_BIT15);
    // taskid[0:12] + (index) The hccl index occupies the highest three bits of taskid.
    fftsplusSqe->fftsPlusSqe.sqeHeader.taskId = ((realTaskId & (RT_MASK_BIT0_BIT11 | RT_MASK_BIT12))
            | ((taskInfo->stream->hcclIndex_) << RT_BEGIN_INDEX_OF_HCCL_INDEX));
    RT_LOG(RT_LOG_DEBUG, "Update fftsplus sqe, real_stream_id=%hu, real_task_id=%hu, "
        "new_stream_id=%hu, new_task_id=%hu", realStreamId, realTaskId,
        fftsplusSqe->fftsPlusSqe.sqeHeader.rtStreamId, fftsplusSqe->fftsPlusSqe.sqeHeader.taskId);
}

uint32_t GetSendSqeNumForFftsPlusTask(const TaskInfo * const taskInfo)
{
    if ((taskInfo->u.fftsPlusTask.kernelFlag & RT_KERNEL_FFTSPLUS_DYNAMIC_SHAPE_DUMPFLAG) != 0U) {
        return 3U; // ffts dump for dynamic shape need 3 sqe
    }

    return 1U; // others need 1 sqe
}

static const std::string GetErrMsgStrForFftsPlusTask(const uint32_t errType)
{
    const std::map<uint32_t, std::string> fftsPlusErrMsgMap = {
        {FFTS_PLUS_AICORE_ERROR, "fftsplus aicore error"},
        {FFTS_PLUS_AIVECTOR_ERROR, "fftsplus aivector error"},
        {FFTS_PLUS_SDMA_ERROR, "fftsplus sdma error"},
        {FFTS_PLUS_AICPU_ERROR, "fftsplus aicpu error"},
        {FFTS_PLUS_DSA_ERROR, "fftsplus dsa error"},
        {HCCL_FFTSPLUS_TIMEOUT_ERROR, "hccl fftsplus timeout"},
    };
    const auto it = fftsPlusErrMsgMap.find(errType);
    if (it != fftsPlusErrMsgMap.end()) {
        return it->second;
    } else {
        return "undefined errType";
    }
}

static bool ReportFftsPlusCurrentContextDetail(TaskInfo *taskInfo, const uint32_t devId,
    const rtFftsPlusTaskErrInfo_t &info)
{
    alignas(uint64_t) uint8_t ctxInfo[CONTEXT_LEN] = {};
    const rtError_t ret = CopyFftsPlusContextToHost(taskInfo, info.contextId, ctxInfo);
    if (ret != RT_ERROR_NONE) {
        Stream *const reportStream = GetReportStream(taskInfo->stream);
        STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_RTS,
            "FftsPlus context copy failed, dev_id=%u, stream_id=%d, task_id=%u, context_id=%u, "
            "thread_id=%u, err_type=%u[%s], error_code=%u, retCode=%#x.", devId, taskInfo->stream->Id_(),
            taskInfo->id, info.contextId, info.threadId, info.errType,
            GetErrMsgStrForFftsPlusTask(info.errType).c_str(), taskInfo->errorCode, ret);
        return false;
    }
    LogFftsPlusContextDetail(taskInfo, devId, info.contextId, ctxInfo);
    return true;
}

static void UpdateSqeSubTypeForMix(TaskInfo *taskInfo)
{
    FftsPlusTaskInfo *fftPlusTask = &taskInfo->u.fftsPlusTask;
    if ((fftPlusTask->fftsSqe.subType == RT_CTX_TYPE_MIX_AIC) ||
        (fftPlusTask->fftsSqe.subType == RT_CTX_TYPE_MIX_AIV)) {
        fftPlusTask->fftsSqe.subType = 0;
    }
    RT_LOG(RT_LOG_INFO, "fftsSqe subType=%u", fftPlusTask->fftsSqe.subType);
}

void ConstructSqeForFftsPlusTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    FftsPlusTaskInfo *fftsPlusTask = &taskInfo->u.fftsPlusTask;
    if ((fftsPlusTask->kernelFlag & RT_KERNEL_FFTSPLUS_DYNAMIC_SHAPE_DUMPFLAG) != 0U) {
        // fisrt is load dump info sqe
        ConstructFftsPlusDumpInfoSqe(taskInfo, command, fftsPlusTask->loadDumpInfo,
                                     fftsPlusTask->loadDumpInfoLen, 0U);

        UpdateSqeSubTypeForMix(taskInfo);
        // sencond is fftsplus sqe, offset is 1
        ConstructFftsPlusSqe(taskInfo, command + 1);
        // task_id must be different for different stream in hccl(ffts+).
        SqeTaskUpdateForFftsPlus(taskInfo, command + 1);

        // third is unload dump info sqe, offset is 2
        ConstructFftsPlusDumpInfoSqe(taskInfo, command + 2, fftsPlusTask->unloadDumpInfo,
                                     fftsPlusTask->unloadDumpInfoLen, STARS_DATADUMP_LOADINFO_END_BITMAP);
    } else {
        if ((fftsPlusTask->kernelFlag & RT_KERNEL_FFTSPLUS_STATIC_SHAPE_DUMPFLAG) != 0U) {
            UpdateSqeSubTypeForMix(taskInfo);
        }
        ConstructFftsPlusSqe(taskInfo, command);
        // task_id must be different for different stream in hccl(ffts+).
        SqeTaskUpdateForFftsPlus(taskInfo, command);
    }
}

void PrintAicAivErrorInfoForFftsPlusTask(TaskInfo* taskInfo, const rtFftsPlusTaskErrInfo_t &info, uint32_t devId)
{
    rtFftsPlusAicAivCtx_t contextInfo = {};
    Stream *const reportStream = GetReportStream(taskInfo->stream);
    // AIC/AIV 场景保留原有的 pcStart 到 kernelName 关联能力，
    // 命中后再补充与其他 FFTS 异常一致的当前 context 紧凑信息。
    const rtError_t ret = CopyFftsPlusContextToHost(taskInfo, info.contextId, &contextInfo);
    if (ret != RT_ERROR_NONE) {
        STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_RTS,
            "FftsPlus task execution failed, dev_id=%u, stream_id=%d, task_id=%u, "
            "context_id=%u, thread_id=%u, err_type=%u[%s], error_code=%u.", devId, taskInfo->stream->Id_(),
            taskInfo->id, info.contextId, info.threadId, info.errType,
            GetErrMsgStrForFftsPlusTask(info.errType).c_str(), taskInfo->errorCode);
        STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_RTS,
            "FftsPlus context copy failed, dev_id=%u, stream_id=%d, task_id=%u, context_id=%u, "
            "thread_id=%u, err_type=%u[%s], error_code=%u, retCode=%#x.", devId, taskInfo->stream->Id_(),
            taskInfo->id, info.contextId, info.threadId, info.errType,
            GetErrMsgStrForFftsPlusTask(info.errType).c_str(), taskInfo->errorCode, ret);
        return;
    }

    std::vector<uint64_t> mapAddr;
    uint16_t blockDim = 0U;
    if ((contextInfo.contextType == RT_CTX_TYPE_AICORE) || (contextInfo.contextType == RT_CTX_TYPE_AIV)) {
        mapAddr.emplace_back(CombineTo64Bit(contextInfo.nonTailTaskStartPcH, contextInfo.nonTailTaskStartPcL));
        mapAddr.emplace_back(CombineTo64Bit(contextInfo.tailTaskStartPcH, contextInfo.tailTaskStartPcL));
        blockDim = contextInfo.tailBlockdim;
    } else if ((contextInfo.contextType == RT_CTX_TYPE_MIX_AIC) || (contextInfo.contextType == RT_CTX_TYPE_MIX_AIV)) {
        const auto * const mixCtx = reinterpret_cast<const rtFftsPlusMixAicAivCtx_t *>(&contextInfo);
        mapAddr.emplace_back(CombineTo64Bit(mixCtx->nonTailAicTaskStartPcH, mixCtx->nonTailAicTaskStartPcL));
        mapAddr.emplace_back(CombineTo64Bit(mixCtx->tailAicTaskStartPcH, mixCtx->tailAicTaskStartPcL));
        mapAddr.emplace_back(CombineTo64Bit(mixCtx->nonTailAivTaskStartPcH, mixCtx->nonTailAivTaskStartPcL));
        mapAddr.emplace_back(CombineTo64Bit(mixCtx->tailAivTaskStartPcH, mixCtx->tailAivTaskStartPcL));
        blockDim = mixCtx->tailBlockdim;
    }

    std::string kernelName;
    for (uint32_t i = 0U; i < mapAddr.size(); i++) {
        RT_LOG(RT_LOG_DEBUG, "contextype=%u, map[%u]=%#" PRIx64 ".", contextInfo.contextType, i, mapAddr[i]);
        if (mapAddr[i] == info.pcStart) {
            kernelName = taskInfo->stream->Device_()->LookupKernelNameByAddr(mapAddr[i]);
            break;
        }
    }
    if (!kernelName.empty()) {
        STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_RTS,
            "FftsPlus task execution failed, dev_id=%u, stream_id=%d, task_id=%u, context_id=%u, "
            "thread_id=%u, err_type=%u[%s], error_code=%u, pc start=%#" PRIx64 ". "
            "fault kernel_name=%s, blockDim=%u.", devId,
            taskInfo->stream->Id_(), taskInfo->id, info.contextId, info.threadId, info.errType,
            GetErrMsgStrForFftsPlusTask(info.errType).c_str(), taskInfo->errorCode,
            info.pcStart, kernelName.c_str(), blockDim);
    } else {
        STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_RTS,
            "FftsPlus task execution failed, dev_id=%u, stream_id=%d, task_id=%u, "
            "context_id=%u, thread_id=%u, err_type=%u[%s], error_code=%u.", devId, taskInfo->stream->Id_(),
            taskInfo->id, info.contextId, info.threadId, info.errType,
            GetErrMsgStrForFftsPlusTask(info.errType).c_str(), taskInfo->errorCode);
    }
    LogFftsPlusContextDetail(taskInfo, devId, info.contextId, reinterpret_cast<const uint8_t *>(&contextInfo));
}

static void PrintSdmaErrorInfoForFftsPlusTask(TaskInfo* taskInfo, const rtFftsPlusTaskErrInfo_t &info, const uint32_t devId)
{
    Stream *const reportStream = GetReportStream(taskInfo->stream);
    STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_RTS,
        "FftsPlus task execution failed, dev_id=%u, stream_id=%d, task_id=%u, "
        "context_id=%u, thread_id=%u, err_type=%u[%s], error_code=%u.", devId, taskInfo->stream->Id_(),
        taskInfo->id, info.contextId, info.threadId, info.errType,
        GetErrMsgStrForFftsPlusTask(info.errType).c_str(), taskInfo->errorCode);
    (void)ReportFftsPlusCurrentContextDetail(taskInfo, devId, info);
}

void PrintDsaErrorInfoForFftsPlusTask(TaskInfo* taskInfo, const rtFftsPlusTaskErrInfo_t &info, const uint32_t devId)
{
    TaskInfo dsaTaskInfo = {};
    InitByStream(&dsaTaskInfo, taskInfo->stream);
    (void)StarsCommonTaskInit(&dsaTaskInfo, info.dsaSqe, 0U);
    (void)PrintDsaErrorInfoForStarsCommonTask(&dsaTaskInfo);
    Stream *const reportStream = GetReportStream(taskInfo->stream);
    STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_FE,
        "FftsPlus task execution failed, dev_id=%u, stream_id=%d, task_id=%u, "
        "context_id=%u, thread_id=%u, err_type=%u[%s], error_code=%u.", devId, taskInfo->stream->Id_(),
        taskInfo->id, info.contextId, info.threadId, info.errType,
        GetErrMsgStrForFftsPlusTask(info.errType).c_str(), taskInfo->errorCode);
    (void)ReportFftsPlusCurrentContextDetail(taskInfo, devId, info);
}

void GetExceptionArgsForFftsPlus(TaskInfo* taskInfo, const rtExceptionExpandInfo_t * const expandInfo,
                                 uint32_t errType, rtExceptionArgsInfo_t *argsInfo)
{
    (void)memset_s(argsInfo, sizeof(rtExceptionArgsInfo_t), 0, sizeof(rtExceptionArgsInfo_t));

    FftsPlusTaskInfo *fftsPlusTask = &taskInfo->u.fftsPlusTask;
    if ((fftsPlusTask->errInfo->empty()) || ((errType != FFTS_PLUS_AICORE_ERROR) &&
        (errType != FFTS_PLUS_AIVECTOR_ERROR))) {
        RT_LOG(RT_LOG_WARNING, "FftsPlus get err failed or no need report, errType:%u.", errType);
        return;
    }

    if ((fftsPlusTask->fftsSqe.subType == RT_STARS_FFTSPLUS_HCCL_WITHOUT_AICAIV_FLAG) ||
        (fftsPlusTask->fftsSqe.subType == RT_STARS_FFTSPLUS_HCCL_WITH_AICAIV_FLAG)) {
        return;
    }

    const uint64_t offset = static_cast<uint64_t>(expandInfo->u.fftsPlusInfo.contextId) * CONTEXT_LEN;
    if ((fftsPlusTask->inputArgsSize.infoAddr == nullptr) || (fftsPlusTask->descAlignBuf == nullptr) ||
        ((offset + CONTEXT_LEN) > fftsPlusTask->descBufLen)) {
        RT_LOG(RT_LOG_WARNING, "FftsPlus get args failed, maxctx_num:%u, offset=%llu.",
               fftsPlusTask->descBufLen / CONTEXT_LEN, offset);
        return;
    }

    rtFftsPlusMixAicAivCtx_t contextInfo;
    const rtError_t ret = taskInfo->stream->Device_()->Driver_()->MemCopySync(&contextInfo, CONTEXT_LEN,
        static_cast<void *>((reinterpret_cast<uint8_t *>(fftsPlusTask->descAlignBuf)) + offset),
        CONTEXT_LEN, RT_MEMCPY_DEVICE_TO_HOST);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "FftsPlus MemCopySync failed, retCode=%#x, offset=%llu.", ret, offset);
        return;
    }

    if ((contextInfo.contextType != RT_CTX_TYPE_MIX_AIC) && (contextInfo.contextType != RT_CTX_TYPE_MIX_AIV)) {
        RT_LOG(RT_LOG_WARNING, "FftsPlus contextType no need report, contextType:%u.", contextInfo.contextType);
        return;
    }

    argsInfo->argAddr = reinterpret_cast<void *>(CombineTo64Bit(contextInfo.aicTaskParamPtrH,
        contextInfo.aicTaskParamPtrL)); // aicTaskParamPtr = aivTaskParamPtr, fill in any one
    argsInfo->sizeInfo.infoAddr = fftsPlusTask->inputArgsSize.infoAddr;
    argsInfo->sizeInfo.atomicIndex = fftsPlusTask->inputArgsSize.atomicIndex;
    RT_LOG(RT_LOG_INFO, "FftsPlus argAddr=%p, infoAddr=%p, atomicIndex=%u.",
        argsInfo->argAddr, argsInfo->sizeInfo.infoAddr, argsInfo->sizeInfo.atomicIndex);
}

static void TaskFailCallBackForFftsPlusTask(TaskInfo* taskInfo, const uint32_t deviceId,
    const rtExceptionExpandInfo_t * const expandInfo, const rtFftsPlusTaskErrInfo_t &info)
{
    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = taskInfo->stream->Id_();
    const uint32_t threadId = taskInfo->tid;
    const uint32_t retCode = taskInfo->errorCode;

    COND_RETURN_NORMAL(retCode == static_cast<uint32_t>(RT_ERROR_NONE),
                       "task ok, stream_id=%u, task_id=%u, retCode=%#x.", streamId, taskId, retCode);
    COND_RETURN_NORMAL(((retCode == TS_ERROR_END_OF_SEQUENCE) || (retCode == TS_MODEL_ABORT_NORMAL)),
                       "task ok, stream_id=%u, task_id=%u, retCode=%#x.", streamId, taskId, retCode);

    rtExceptionInfo_t exceptionInfo;
    rtError_t rtErrCode = RT_ERROR_NONE;
    const char_t *const retDes = GetTsErrCodeMap(retCode, &rtErrCode);

    exceptionInfo.retcode = static_cast<uint32_t>(RT_TRANS_EXT_ERRCODE(rtErrCode));
    exceptionInfo.taskid = CovertToFlipTaskId(streamId, taskId, taskInfo->stream->Device_());
    exceptionInfo.streamid = static_cast<uint32_t>(streamId);
    exceptionInfo.tid = threadId;
    exceptionInfo.deviceid = deviceId;
    exceptionInfo.expandInfo = *expandInfo;
    GetExceptionArgsForFftsPlus(taskInfo, expandInfo, info.errType, &(exceptionInfo.expandInfo.u.fftsPlusInfo.exceptionArgs));

    const auto dev = taskInfo->stream->Device_();
    const std::string kernelName = dev->LookupKernelNameByAddr(info.pcStart);
    auto &kernelInfo = exceptionInfo.expandInfo.u.fftsPlusInfo.exceptionArgs.exceptionKernelInfo;
    kernelInfo.kernelName = kernelName.c_str();
    kernelInfo.kernelNameSize = static_cast<uint32_t>(kernelName.size());
    kernelInfo.bin = dev->LookupBinHandleByAddr(info.pcStart);
    Program *programHdl = nullptr;
    const rtError_t handleRet = GetValidatedObject<Program>(kernelInfo.bin, programHdl);
    if ((handleRet == RT_ERROR_NONE) && (programHdl != nullptr)) {
        kernelInfo.binSize = programHdl->GetBinarySize();
    } else if (handleRet != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "FftsPlus get program from bin handle failed, retCode=%#x.", handleRet);
    }
    RT_LOG(RT_LOG_ERROR, "fftsplus streamId=%d, taskId=%u, context_id=%u, expandType=%u, rtCode=%#x,[%s], "
        "psStart=0x%llx, kernel_name=%s, binHandle=%p, binSize=%u.", streamId, exceptionInfo.taskid,
        exceptionInfo.expandInfo.u.fftsPlusInfo.contextId, exceptionInfo.expandInfo.type, rtErrCode,
        retDes, info.pcStart, kernelName.c_str(), kernelInfo.bin, kernelInfo.binSize);
    TaskFailCallBackNotify(&exceptionInfo);
}

static void DumpContext(TaskInfo *taskInfo)
{
    FftsPlusTaskInfo *fftsPlusTask = &taskInfo->u.fftsPlusTask;
    if ((fftsPlusTask->descAlignBuf == nullptr) || (fftsPlusTask->descBufLen == 0ULL)) {
        return;
    }
    const uint32_t totalCtxNum = static_cast<uint32_t>(fftsPlusTask->descBufLen / CONTEXT_LEN);
    const uint32_t printNum = (totalCtxNum < 10U) ? totalCtxNum : 10U;
    const uint32_t copySize = printNum * CONTEXT_LEN;

    RT_LOG(RT_LOG_ERROR, "dump contexts begin, stream_id=%d, task_id=%u, "
        "total_ctx_num=%u, print_num=%u, descAlignBuf=%p, descBufLen=%llu",
        taskInfo->stream->Id_(), taskInfo->id, totalCtxNum, printNum,
        fftsPlusTask->descAlignBuf, fftsPlusTask->descBufLen);

    std::vector<uint8_t> ctxBuf(copySize);
    const rtError_t ret = taskInfo->stream->Device_()->Driver_()->MemCopySync(
        ctxBuf.data(), copySize, fftsPlusTask->descAlignBuf, copySize, RT_MEMCPY_DEVICE_TO_HOST);
    if (ret != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "MemCopySync failed, retCode=%#x.", ret);
        return;
    }

    for (uint32_t ctxId = 0U; ctxId < printNum; ctxId++) {
        const uint32_t *buf = RtPtrToPtr<const uint32_t *>(ctxBuf.data() + ctxId * CONTEXT_LEN);
        const auto *comCtx = RtPtrToPtr<const rtFftsPlusComCtx_t *>(buf);
        RT_LOG(RT_LOG_ERROR, "context[%u] stream_id=%d task_id=%u "
            "context_id=%u contextType=%u successorNum=%u predCntInit=%u.",
            ctxId, taskInfo->stream->Id_(), taskInfo->id, ctxId, comCtx->contextType,
            comCtx->successorNum, comCtx->predCntInit);
        for (uint32_t row = 0U; row < 4U; row++) {
            const uint32_t start = row * 8U;
            RT_LOG(RT_LOG_ERROR, "context[%u] buf[%02u-%02u]="
                "%08x %08x %08x %08x %08x %08x %08x %08x",
                ctxId, start, start + 7U,
                buf[start], buf[start + 1U], buf[start + 2U], buf[start + 3U],
                buf[start + 4U], buf[start + 5U], buf[start + 6U], buf[start + 7U]);
        }
    }

    RT_LOG(RT_LOG_ERROR, "dump contexts end, stream_id=%d, task_id=%u",
        taskInfo->stream->Id_(), taskInfo->id);
}

void PrintErrorInfoForFftsPlusTask(TaskInfo* taskInfo, const uint32_t devId)
{
    const uint32_t taskId = taskInfo->id;
    const int32_t streamId = taskInfo->stream->Id_();
    rtExceptionExpandInfo_t expandInfo = {};
    FftsPlusTaskInfo *fftsPlusTask = &taskInfo->u.fftsPlusTask;
    bool needDumpCtx = false;
    for (auto loop : *fftsPlusTask->errInfo) {
        if ((loop.errType == FFTS_PLUS_AICORE_ERROR) || (loop.errType == FFTS_PLUS_AIVECTOR_ERROR)) {
            PrintAicAivErrorInfoForFftsPlusTask(taskInfo, loop, devId);
        } else if (loop.errType == FFTS_PLUS_DSA_ERROR) {
            PrintDsaErrorInfoForFftsPlusTask(taskInfo, loop, devId);
        } else if (loop.errType == FFTS_PLUS_SDMA_ERROR) {
            PrintSdmaErrorInfoForFftsPlusTask(taskInfo, loop, devId);
        } else {
            // 未知或新增的 FFTS errType 也沿用同样的轻量摘要和当前 context 展开，
            // 这样即使不属于 AIC/AIV、SDMA、DSA，也还能继续做定界。
            Stream *const reportStream = GetReportStream(taskInfo->stream);
            STREAM_REPORT_ERR_MSG(reportStream, ERR_MODULE_RTS,
                "FftsPlus task execution failed, dev_id=%u, stream_id=%d, task_id=%u, "
                "context_id=%u, thread_id=%u, err_type=%u[%s], error_code=%u.", devId, streamId, taskId,
                loop.contextId, loop.threadId, loop.errType, GetErrMsgStrForFftsPlusTask(loop.errType).c_str(),
                taskInfo->errorCode);
            (void)ReportFftsPlusCurrentContextDetail(taskInfo, devId, loop);
            needDumpCtx = true;
        }
        expandInfo.type = RT_EXCEPTION_FFTS_PLUS;
        expandInfo.u.fftsPlusInfo.contextId = static_cast<uint16_t>(loop.contextId);
        expandInfo.u.fftsPlusInfo.threadId = loop.threadId;
        TaskFailCallBackForFftsPlusTask(taskInfo, devId, &expandInfo, loop);
    }
    if (needDumpCtx) {
        DumpContext(taskInfo);
    }
    if (unlikely(fftsPlusTask->errInfo->empty())) {
        rtExceptionExpandInfo_t expandTmpInfo = {};
        expandTmpInfo.type = RT_EXCEPTION_FFTS_PLUS;
        expandTmpInfo.u.fftsPlusInfo.contextId = 0xFFFFU;
        expandTmpInfo.u.fftsPlusInfo.threadId = 0xFFFFU;
        rtFftsPlusTaskErrInfo_t info = {};
        info.errType = static_cast<uint32_t>(ERROR_TYPE_BUTT);
        TaskFailCallBackForFftsPlusTask(taskInfo, devId, &expandTmpInfo, info);
    }
    fftsPlusTask->errInfo->clear();
}

void DoCompleteSuccForFftsPlusTask(TaskInfo* taskInfo, const uint32_t devId)
{
    if (unlikely(taskInfo->errorCode != static_cast<uint32_t>(RT_ERROR_NONE))) {
        Stream * const stream = taskInfo->stream;
        uint32_t errorCode = taskInfo->errorCode;
        taskInfo->stream->Device_()->PrintExceedLimitHcclStream();
        RT_LOG(RT_LOG_ERROR, "fftsplus report error, retCode=%#x, [%s].",
               taskInfo->errorCode, GetTsErrCodeDesc(taskInfo->errorCode));

        RT_LOG(RT_LOG_INFO, "mte_error=%u, errcode=0x%x", taskInfo->mte_error, taskInfo->stream->GetErrCode());
        if (MEM_ERROR_CODE.find(taskInfo->mte_error) != MEM_ERROR_CODE.end()) {
            errorCode = static_cast<int32_t>(taskInfo->mte_error);
            taskInfo->mte_error = 0U;
        } else {
            taskInfo->errorCode = errorCode;
        }
        stream->SetErrCode(errorCode);
        PrintErrorInfoForFftsPlusTask(taskInfo, devId);
    }
    ReleaseArgsHandleForFftsPlusTask(taskInfo);
}

void PushBackErrInfoForFftsPlusTask(TaskInfo* taskInfo, const void *errInfo, uint32_t len)
{
    if (errInfo == nullptr) {
        RT_LOG(RT_LOG_ERROR, "fftsplus pushback errinfo input invalid");
        return;
    }
    rtFftsPlusTaskErrInfo_t taskErrInfo;
    if (memcpy_s(&taskErrInfo, sizeof(rtFftsPlusTaskErrInfo_t), errInfo, len) != EOK) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Failed to call memcpy_s to copy errInfo, src=%p, dest=%p,"
            " dest_max=%zu, count=%u.", errInfo, &taskErrInfo, sizeof(rtFftsPlusTaskErrInfo_t), len);
        return;
    }
    taskInfo->u.fftsPlusTask.errInfo->push_back(taskErrInfo);
}

void SetStarsResultForFftsPlusTask(TaskInfo* taskInfo, const rtLogicCqReport_t &logicCq)
{
    if ((logicCq.errorType & RT_STARS_EXIST_ERROR) != 0U) {
        uint32_t errMap[] = {
            TS_ERROR_FFTSPLUS_TASK_EXCEPTION,
            TS_ERROR_FFTSPLUS_TASK_TRAP,
            TS_ERROR_FFTSPLUS_TASK_TIMEOUT,
            TS_ERROR_TASK_SQE_ERROR,
            TS_ERROR_FFTSPLUS_TASK_EXCEPTION,
            logicCq.errorCode};
        const uint32_t errorIndex = static_cast<uint32_t>(BitScan(static_cast<uint64_t>(logicCq.errorType)));
        taskInfo->errorCode = errMap[errorIndex];
        RT_LOG(RT_LOG_ERROR, "FftsPlusTask errorCode=%u, logicCq:err=%u, errCode=%u, "
               "stream_id=%hu, task_id=%hu", taskInfo->errorCode, logicCq.errorType, logicCq.errorCode,
               logicCq.streamId, logicCq.taskId);
    }
}

#endif

}
}
