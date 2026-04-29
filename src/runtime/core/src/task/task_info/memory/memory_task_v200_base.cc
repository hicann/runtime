/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stars_david.hpp"
#include "memory_task.h"
#include "stream.hpp"
#include "runtime.hpp"
#include "task_manager.h"
#include "error_code.h"
#include "task_info.h"
#include "stream_david.hpp"
#include "stars_cond_isa_define.hpp"
#include "stars_cond_isa_helper.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {

#if F_DESC("MemcpyAsyncTask")
void ReleaseCpyTmpMemForDavid(TaskInfo * const taskInfo)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Driver * const driver = taskInfo->stream->Device_()->Driver_();

    if (memcpyAsyncTaskInfo->srcPtr != nullptr) {
        (void)driver->HostMemFree(memcpyAsyncTaskInfo->srcPtr);
        memcpyAsyncTaskInfo->srcPtr = nullptr;
    }
    if (memcpyAsyncTaskInfo->desPtr != nullptr) {
        (void)driver->HostMemFree(memcpyAsyncTaskInfo->desPtr);
        memcpyAsyncTaskInfo->desPtr = nullptr;
    }
}

void StarsV2DoCompleteSuccessForMemcpyAsyncTask(TaskInfo * const taskInfo, const uint32_t devId)
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

rtError_t ConvertAsyncDmaBatch(TaskInfo * const taskInfo, void** const dsts, 
    void** const srcs, const uint64_t* const sizes, const uint64_t count, const uint64_t fixedCnt)
{
    bool isUbMode = Runtime::Instance()->GetConnectUbFlag() ? true : false;
    if (!isUbMode) {
        RT_LOG(RT_LOG_ERROR, "pcie does not support");
        return RT_ERROR_INVALID_VALUE;
    }   

    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = taskInfo->stream->Device_()->Driver_();
    const uint32_t devId = stream->Device_()->Id_();
    AsyncDmaWqeInputInfoBatch input;
    (void)memset_s(&input, sizeof(AsyncDmaWqeInputInfoBatch), 0, sizeof(AsyncDmaWqeInputInfoBatch));
    memcpyAsyncTaskInfo->ubDma.isUbAsyncMode = true;

    input.tsId = stream->Device_()->DevGetTsId();
    input.sqId = stream->GetSqId();
    input.dsts = dsts;
    input.srcs = srcs;
    input.lens = const_cast<uint64_t *>(sizes);    
    input.count = count;
    input.fixedCnt = fixedCnt;
    AsyncDmaWqeOutputInfo output;
    (void)memset_s(&output, sizeof(AsyncDmaWqeOutputInfo), 0, sizeof(AsyncDmaWqeOutputInfo));
    const rtError_t error = driver->CreateAsyncDmaWqeBatch(devId, input, &output);
    ERROR_RETURN_MSG_INNER(error, "drv create asyncDmaWqeBatch failed, retCode=%#x.", static_cast<uint32_t>(error));

    memcpyAsyncTaskInfo->ubDma.jettyId = output.jettyId;
    memcpyAsyncTaskInfo->ubDma.functionId = output.functionId;
    memcpyAsyncTaskInfo->ubDma.dieId = output.dieId;
    memcpyAsyncTaskInfo->ubDma.pi = output.pi;
    memcpyAsyncTaskInfo->ubDma.fixedCnt = output.fixedCnt;
    memcpyAsyncTaskInfo->size = output.fixedCnt;
    return RT_ERROR_NONE;
}

rtError_t MemcpyAsyncBatchTaskInit(TaskInfo * const taskInfo, void** const dsts, 
    void** const srcs, const uint64_t* const sizes, const uint64_t count, const uint64_t fixedSize)
{
    rtError_t error = MemcpyAsyncTaskCommonInit(taskInfo);
    ERROR_RETURN_MSG_INNER(error, "MemcpyAsyncTaskCommonInit V3 failed, retCode=%#x.", error);

    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);

    if (IsDavidUbDma(memcpyAsyncTaskInfo->copyType)) { 
        error = ConvertAsyncDmaBatch(taskInfo, dsts, srcs, sizes, count, fixedSize);
        ERROR_RETURN_MSG_INNER(error, "ConvertAsyncDmaBatch failed, retCode=%#x.", error);
        memcpyAsyncTaskInfo->dmaKernelConvertFlag = true;
    } else {
        // 除DavidUbDma之外的其他情况不处理
    }
    
    return RT_ERROR_NONE;
}

static void AsyncDmaWqe2DProc(MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo, const Stream * const stream)
{
    bool ubFlag = IsDavidUbDma(memcpyAsyncTaskInfo->copyType);
    if (!ubFlag) {
        return;     
    }

    AsyncDmaWqeDestroyInfo2D destroyParm;
    (void)memset_s(&destroyParm, sizeof(AsyncDmaWqeDestroyInfo2D), 0, sizeof(AsyncDmaWqeDestroyInfo2D));
    destroyParm.tsId = stream->Device_()->DevGetTsId();
    destroyParm.sqId = stream->GetSqId();
    destroyParm.ci = memcpyAsyncTaskInfo->ubDma.pi;
    
    rtError_t error = stream->Device_()->Driver_()->DestroyAsyncDmaWqe2D(stream->Device_()->Id_(), &destroyParm);
    COND_RETURN_VOID(error != RT_ERROR_NONE, "drv destroy asyncDmaWqe2d failed, retCode=%#x.", error);
    RT_LOG(RT_LOG_INFO, "ub wqe async 2d release success, ci=%u, sq_id=%u.",
            destroyParm.ci, destroyParm.sqId);
}

static void AsyncDmaWqeBatchProc(MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo, const Stream * const stream)
{
    bool ubFlag = IsDavidUbDma(memcpyAsyncTaskInfo->copyType);
    if (!ubFlag) {
        return;     
    }

    AsyncDmaWqeDestroyInfoBatch destroyParm;
    (void)memset_s(&destroyParm, sizeof(AsyncDmaWqeDestroyInfoBatch), 0, sizeof(AsyncDmaWqeDestroyInfoBatch));
    destroyParm.tsId = stream->Device_()->DevGetTsId();
    destroyParm.sqId = stream->GetSqId();
    destroyParm.ci = memcpyAsyncTaskInfo->ubDma.pi;
    
    rtError_t error = stream->Device_()->Driver_()->DestroyAsyncDmaWqeBatch(stream->Device_()->Id_(), &destroyParm);
    COND_RETURN_VOID(error != RT_ERROR_NONE, "drv destroy asyncDmaWqeBatch failed, retCode=%#x.", error);
    RT_LOG(RT_LOG_INFO, "ub wqe async batch release success, ci=%u, sq_id=%u.",
            destroyParm.ci, destroyParm.sqId);
}


static void AsyncDmaWqeBasicProc(MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo, const Stream * const stream)
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

static void AsyncDmaWqeProc(MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo, const Stream * const stream)
{
    if (memcpyAsyncTaskInfo->copyMethod == RT_ASYNC_CPY_2D) {
        AsyncDmaWqe2DProc(memcpyAsyncTaskInfo, stream);
    } else if (memcpyAsyncTaskInfo->copyMethod == RT_ASYNC_CPY_BATCH) {
        AsyncDmaWqeBatchProc(memcpyAsyncTaskInfo, stream);
    } else {
        AsyncDmaWqeBasicProc(memcpyAsyncTaskInfo, stream);
    }
}

void StarsV2MemcpyAsyncTaskUnInit(TaskInfo * const taskInfo)
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

#if F_DESC("MemWaitValueTask")
void ConstructDavidSqeForMemWaitValueTask(TaskInfo* taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr)
{
    constexpr uint8_t MEM_WAIT_SQE_INDEX_1 = 1U;
    constexpr uint8_t MEM_WAIT_SQE_INDEX_2 = 2U;

    RtStarsMemWaitValueInstrFcPara fcPara = {};
    MemWaitValueTaskInfo *memWaitValueTask = &taskInfo->u.memWaitValueTask;
    Stream * const stream = taskInfo->stream;

    const uint32_t taskPosTail = (stream->taskResMang_ == nullptr) ? (static_cast<Stream *>(stream))->GetCurSqPos() : taskInfo->id;
    fcPara.devAddr = memWaitValueTask->devAddr;
    fcPara.value = memWaitValueTask->value;
    fcPara.flag = memWaitValueTask->flag;
    fcPara.maxLoop = 15ULL;  /* the max loop num */
    fcPara.sqId = stream->GetSqId();
    fcPara.sqHeadPre = (taskPosTail + 1) % stream->GetSqDepth();
    fcPara.awSize = memWaitValueTask->awSize;
    fcPara.sqIdMemAddr = stream->GetSqIdMemAddr();

    // two sqes probably trigger a software constraint when the stream is full, add a nop sqe to evade
    ConstructNopSqeForMemWaitValueTask(taskInfo, davidSqe);

    rtDavidSqe_t *writeSqeAddr = &davidSqe[MEM_WAIT_SQE_INDEX_1];
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + MEM_WAIT_SQE_INDEX_1;
        writeSqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    ConstructFirstDavidSqeForMemWaitValueTask(taskInfo, writeSqeAddr);

    rtDavidSqe_t *condSqeAddr = &davidSqe[MEM_WAIT_SQE_INDEX_2];
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + MEM_WAIT_SQE_INDEX_2;
        condSqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }
    ConstructSecondDavidSqeForMemWaitValueTask(taskInfo, condSqeAddr, fcPara);
}

void ConstructNopSqeForMemWaitValueTask(TaskInfo* taskInfo, rtDavidSqe_t *const davidSqe)
{
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);

    RtDavidPlaceHolderSqe *const sqe = &(davidSqe->phSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_PLACE_HOLDER;
    sqe->taskType = TS_TASK_TYPE_NOP;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    PrintDavidSqe(davidSqe, "MemWaitValueTask nop sqe");
}

void ConstructFirstDavidSqeForMemWaitValueTask(TaskInfo* taskInfo, rtDavidSqe_t *const davidSqe)
{
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);

    Stream * const stream = taskInfo->stream;
    RtDavidStarsWriteValueSqe *sqe = &(davidSqe->writeValueSqe);

    sqe->header.type = RT_DAVID_SQE_TYPE_WRITE_VALUE;
    sqe->va = 1U;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->awsize = taskInfo->u.memWaitValueTask.awSize;

    constexpr uint64_t value = 0ULL;
    const uint64_t devAddr = RtPtrToValue(taskInfo->u.memWaitValueTask.writeValueAddr);
    if (devAddr == 0ULL) {
        sqe->header.type = RT_DAVID_SQE_TYPE_INVALID;
        return;
    }
    sqe->writeValuePart[0] = static_cast<uint32_t>(value & MASK_32_BIT);
    sqe->writeValuePart[1] = static_cast<uint32_t>(value >> UINT32_BIT_NUM);
    sqe->writeAddrLow = static_cast<uint32_t>(devAddr & MASK_32_BIT);
    sqe->writeAddrHigh = static_cast<uint32_t>((devAddr >> UINT32_BIT_NUM) & MASK_17_BIT);

    PrintDavidSqe(davidSqe, "MemWaitValueTask value write sqe");
    RT_LOG(RT_LOG_INFO, "MemWaitValueTask value write sqe, stream_id=%d, task_id=%hu, devAddr=0x%llx, "
        "value=0x%llx, taskSn=%u", stream->Id_(), taskInfo->id, devAddr, value, taskInfo->taskSn);
}

void ConstructSecondDavidSqeForMemWaitValueTask(TaskInfo* taskInfo, rtDavidSqe_t *const davidSqe,
    const RtStarsMemWaitValueInstrFcPara &fcPara)
{
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);

    MemWaitValueTaskInfo *memWaitValueTask = &taskInfo->u.memWaitValueTask;
    RtDavidStarsFunctionCallSqe &sqe = davidSqe->fuctionCallSqe;

    rtError_t ret;
    uint64_t funcCallSize;
    if (taskInfo->stream->IsSoftwareSqEnable()) {
        RtStarsMemWaitValueLastInstrFcExWithoutProf fcEx = {};
        funcCallSize = static_cast<uint64_t>(sizeof(RtStarsMemWaitValueLastInstrFcExWithoutProf));
        ConstructMemWaitValueInstr2ExWithoutProf(fcEx, fcPara);
        ret = taskInfo->stream->Device_()->Driver_()->MemCopySync(memWaitValueTask->funcCallSvmMem2,
            memWaitValueTask->funCallMemSize2, &fcEx, funcCallSize,
            RT_MEMCPY_HOST_TO_DEVICE);
    } else {
        RtStarsMemWaitValueLastInstrFcWithoutProf fc = {};
        funcCallSize = static_cast<uint64_t>(sizeof(RtStarsMemWaitValueLastInstrFcWithoutProf));
        ConstructMemWaitValueInstr2WithoutProf(fc, fcPara);
        ret = taskInfo->stream->Device_()->Driver_()->MemCopySync(memWaitValueTask->funcCallSvmMem2,
            memWaitValueTask->funCallMemSize2, &fc, funcCallSize,
            RT_MEMCPY_HOST_TO_DEVICE);
    }    
    if (ret != RT_ERROR_NONE) {
        sqe.header.type = RT_DAVID_SQE_TYPE_INVALID;
        return;
    }

    sqe.header.type = RT_DAVID_SQE_TYPE_COND;
    sqe.kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe.csc = 1U;
    sqe.condsSubType = CONDS_SUB_TYPE_MEM_WAIT_VALUE;

    const uint64_t funcAddr = RtPtrToValue(memWaitValueTask->funcCallSvmMem2);

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintDavidSqe(davidSqe, "MemWaitValueTask condition sqe");
    RT_LOG(RT_LOG_INFO, "MemWaitValueTask condition sqe, stream_id=%d, task_id=%hu, devAddr=0x%llx, "
        "value=0x%llx, sqHeadPre=%u, flag=%u, taskSn=%u", taskInfo->stream->Id_(), taskInfo->id,
        fcPara.devAddr, fcPara.value, fcPara.sqHeadPre, fcPara.flag, taskInfo->taskSn);
}
#endif

#if F_DESC("MemWriteValueTask")
void ConstructDavidSqeForMemWriteValueTask(TaskInfo *const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    MemWriteValueTaskInfo *const writeValTsk = &(taskInfo->u.memWriteValueTask);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);

    RtDavidStarsWriteValueSqe * const sqe = &(davidSqe->writeValueSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_WRITE_VALUE;
    sqe->va = 1U;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->awsize = writeValTsk->awSize;
    sqe->snoop = 0U;
    sqe->awcache = 2U;
    sqe->awprot = 0U;

    const uint64_t value = taskInfo->u.memWriteValueTask.value;
    const uint64_t devAddr = taskInfo->u.memWriteValueTask.devAddr;
    if (devAddr == 0ULL) {
        sqe->header.type = RT_DAVID_SQE_TYPE_INVALID;
        return;
    }
    
    sqe->writeAddrLow = static_cast<uint32_t>(devAddr & MASK_32_BIT);
    sqe->writeAddrHigh = static_cast<uint32_t>((devAddr >> UINT32_BIT_NUM) & MASK_17_BIT);
    sqe->writeValuePart[0] = static_cast<uint32_t>(value & MASK_32_BIT);
    sqe->writeValuePart[1] = static_cast<uint32_t>((value >> UINT32_BIT_NUM) & MASK_32_BIT);

    PrintDavidSqe(davidSqe, "MemWriteValueTask");
    RT_LOG(RT_LOG_INFO, "MemWriteValueTask stream_id=%d, awsize=%d ,task_id=%hu, devAddr=%#" PRIx64
        ", value:%#" PRIx64, taskInfo->stream->Id_(), sqe->awsize, taskInfo->id, devAddr, value);
}
#endif

}  // namespace runtime
}  // namespace cce
