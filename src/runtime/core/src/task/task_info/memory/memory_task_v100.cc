/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_info_v100.h"
#include "memory_task.h"
#include "stream.hpp"
#include "runtime.hpp"
#include "context.hpp"
#include "task_manager.h"
#include "error_code.h"
#include "task_execute_time.h"
#include "davinci_kernel_task.h"
#include "stars_cond_isa_helper.hpp"
#include "inner_thread_local.hpp"
#include "model_update_task.h"
#include "event.hpp"
#include "kernel_utils.hpp"

namespace cce {
namespace runtime {
namespace {
constexpr uint8_t MEM_WAIT_SQE_INDEX_0 = 0U;
constexpr uint8_t MEM_WAIT_SQE_INDEX_1 = 1U;
constexpr uint8_t MEM_WAIT_SQE_INDEX_2 = 2U;
constexpr uint8_t MEM_WAIT_SQE_INDEX_3 = 3U;
} // namespace

#if F_DESC("MemcpyAsyncTask")
TIMESTAMP_EXTERN(rtMemcpyAsync_drvMemDestroyAddr);

#ifdef __RT_CFG_HOST_CHIP_HI3559A__
static void ReleaseCpyTmpMem(TaskInfo * const taskInfo)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = taskInfo->stream->Device_()->Driver_();

    if (memcpyAsyncTaskInfo->srcPtr != nullptr) {
        if (driver->GetRunMode() == RT_RUN_MODE_ONLINE) {
            driver->HostMemFree(memcpyAsyncTaskInfo->srcPtr);
        } else {
            driver->DevMemFree(memcpyAsyncTaskInfo->srcPtr, stream->Device_()->Id_());
        }
        memcpyAsyncTaskInfo->srcPtr = nullptr;
    }

    if (memcpyAsyncTaskInfo->desPtr != nullptr) {
        if (driver->GetRunMode() == RT_RUN_MODE_ONLINE) {
            driver->HostMemFree(memcpyAsyncTaskInfo->desPtr);
        } else {
            driver->DevMemFree(memcpyAsyncTaskInfo->desPtr, stream->Device_()->Id_());
        }
        memcpyAsyncTaskInfo->desPtr = nullptr;
    }
}
#else
static void ReleaseCpyTmpMem(TaskInfo * const taskInfo)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = taskInfo->stream->Device_()->Driver_();

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
#endif

static bool IsSdmaMteErrorCode(const int32_t errCode)
{
    return (errCode == TS_ERROR_SDMA_LINK_ERROR) || (errCode == TS_ERROR_SDMA_POISON_ERROR);
}

static void ConstructPlaceHolderSqe(TaskInfo * const taskInfo, rtStarsSqe_t * const command)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;

    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->wr_cqe = stream->GetStarsWrCqeFlag();
    sqe->rt_streamID = static_cast<uint16_t>(stream->Id_());
    sqe->task_id = taskInfo->id;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->task_type = TS_TASK_TYPE_MEMCPY_ASYNC_WITHOUT_SDMA;
    sqe->pre_p = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    sqe->post_p = RT_STARS_SQE_INT_DIR_NO;

    sqe->u.memcpy_async_without_sdma_info.src = RtPtrToValue(memcpyAsyncTaskInfo->src);
    sqe->u.memcpy_async_without_sdma_info.dest = RtPtrToValue(memcpyAsyncTaskInfo->destPtr);
    sqe->u.memcpy_async_without_sdma_info.size = memcpyAsyncTaskInfo->size;
    if (!stream->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_TASK_MEMCPY_ASYNC_DOT_BY_PLACEHOLDER)) {
        sqe->u.memcpy_async_without_sdma_info.pid = static_cast<uint32_t>(drvDeviceGetBareTgid());
    }
    PrintSqe(command, "MemCopyAsyncByPlaceHolder");
    RT_LOG(RT_LOG_INFO, "ConstructSqe, size_=%" PRIu64 ", pid=%u.",
        memcpyAsyncTaskInfo->size, sqe->u.memcpy_async_without_sdma_info.pid);
}

static void ConstructMemcpySqePtr(TaskInfo * const taskInfo, rtStarsSqe_t * const command)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;

    RT_LOG(RT_LOG_INFO, "ConstructMemcpySqePtr, memcpyAddrInfo=%p.", memcpyAsyncTaskInfo->memcpyAddrInfo);
    RtStarsMemcpyAsyncPtrSqe * const sqe = &(command->memcpyAsyncPtrSqe);
    if (memcpyAsyncTaskInfo->memcpyAddrInfo == nullptr) {
        RT_LOG(RT_LOG_ERROR, "ConstructMemcpySqePtr, memcpyAddrInfo is null.");
        sqe->header.type = RT_STARS_SQE_TYPE_INVALID;
        return;
    }

    sqe->header.type = RT_STARS_SQE_TYPE_SDMA;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;

    sqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wr_cqe = 1U;

    sqe->header.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    sqe->header.task_id = taskInfo->id;

    sqe->kernelCredit = GetSdmaKernelCredit();
    sqe->ptrMode = 1U;
    sqe->va = 1U;
    sqe->sdmaSqeBaseAddrLow = static_cast<uint32_t>(
        RtPtrToValue(memcpyAsyncTaskInfo->memcpyAddrInfo) & 0x00000000FFFFFFFFUL);
    sqe->sdmaSqeBaseAddrHigh = static_cast<uint32_t>(
        (RtPtrToValue(memcpyAsyncTaskInfo->memcpyAddrInfo) & 0x0001FFFF00000000UL) >> UINT32_BIT_NUM);
    PrintSqe(command, "MemcpyAsyncPtr");
}

void ConstructPcieDmaSqe(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    taskInfo->isNoRingbuffer = 1U;
    Stream * const stream = taskInfo->stream;
    RtStarsPcieDmaSqe *sqe = &(command->pcieDmaSqe);

    sqe->header.type = RT_STARS_SQE_TYPE_PCIE_DMA;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;
    // single-operator stream set wr_cqe for ts_agent recycle
    sqe->header.wr_cqe = stream->GetBindFlag() ? 0U : memcpyAsyncTaskInfo->dmaKernelConvertFlag;
    sqe->header.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    sqe->header.task_id = taskInfo->id;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT;

    if (memcpyAsyncTaskInfo->dmaKernelConvertFlag) {
        sqe->src = RtPtrToValue(memcpyAsyncTaskInfo->src);
        sqe->dst = RtPtrToValue(memcpyAsyncTaskInfo->destPtr);
        sqe->length = memcpyAsyncTaskInfo->size;
        sqe->isDsaUpdate = 0U;
        sqe->isSqeUpdate = 0U;
        // 1980C reserved for debug
        PrintSqe(command, "pcieDmaTask");
        RT_LOG(RT_LOG_INFO, "stream_id=%d, task_id=%hu, copyType=%u, src=%#" PRIx64 ", dst=%#" PRIx64 ", len=%#" PRIx64,
               stream->Id_(), taskInfo->id, memcpyAsyncTaskInfo->copyType, sqe->src, sqe->dst, sqe->length);
        return;
    }

    if (memcpyAsyncTaskInfo->dsaSqeUpdateFlag || memcpyAsyncTaskInfo->isSqeUpdateD2H) {
        sqe->src = RtPtrToValue(memcpyAsyncTaskInfo->src);
        sqe->dst = (static_cast<uint64_t>(memcpyAsyncTaskInfo->sqId) << 32U) +
            static_cast<uint64_t>(memcpyAsyncTaskInfo->taskPos);
        sqe->length = memcpyAsyncTaskInfo->size;
        sqe->offset = memcpyAsyncTaskInfo->sqeOffset;
        sqe->isConverted = 0U;
        sqe->isDsaUpdate = memcpyAsyncTaskInfo->dsaSqeUpdateFlag;
        sqe->isSqeUpdate = memcpyAsyncTaskInfo->isSqeUpdateD2H;
        PrintSqe(command, "sqe update task");
        RT_LOG(RT_LOG_INFO, "stream_id=%d, type=%u, task_id=%hu, sqId=%u, pos=%u, "
                "copyType=%u, src=%#" PRIx64 ", dst=%#" PRIx64 ", len=%#" PRIx64,
                stream->Id_(), sqe->header.type, taskInfo->id, memcpyAsyncTaskInfo->sqId,
                memcpyAsyncTaskInfo->taskPos, memcpyAsyncTaskInfo->copyType, sqe->src, sqe->dst, sqe->length);
        return;
    }

    // 2D copy
    sqe->isConverted = 1U;
    sqe->isDsaUpdate = 0U;
    sqe->isSqeUpdate = 0U;
    const uint64_t sqAddr = RtPtrToValue(memcpyAsyncTaskInfo->dmaAddr.phyAddr.src);
    sqe->sq_addr_low = static_cast<uint32_t>(sqAddr & MASK_32_BIT);
    sqe->sq_addr_high = static_cast<uint32_t>(sqAddr >> UINT32_BIT_NUM);
    sqe->sq_tail_ptr = static_cast<uint16_t>(memcpyAsyncTaskInfo->dmaAddr.phyAddr.len);
    PrintSqe(command, "2D pcieDmaTask");
    RT_LOG(RT_LOG_INFO, "stream_id=%d, task_id=%hu, copyType=%u, sq_addr_low=%p sq_tail_ptr=%hu.",
           stream->Id_(), taskInfo->id, memcpyAsyncTaskInfo->copyType,
           memcpyAsyncTaskInfo->dmaAddr.phyAddr.src, sqe->sq_tail_ptr);
}

static void ConstructMemcpySqe(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    const uint32_t copyType = memcpyAsyncTaskInfo->copyType;
    const uint32_t copyKind = memcpyAsyncTaskInfo->copyKind;

    if (unlikely((copyType == RT_MEMCPY_ADDR_D2D_SDMA) && (copyKind == RT_MEMCPY_RESERVED))) {
        ConstructMemcpySqePtr(taskInfo, command);
        return;
    }

    RtStarsMemcpyAsyncSqe *const sqe = &(command->memcpyAsyncSqe);
    sqe->header.type = RT_STARS_SQE_TYPE_SDMA;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;

    /* b605-b606 do not support ADDR D2D SDMA */
    if (copyType == RT_MEMCPY_ADDR_D2D_SDMA) {
        sqe->header.pre_p = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    }

    if (stream->IsDebugRegister() && (!stream->GetBindFlag())) {
        sqe->header.post_p = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    }
    sqe->header.wr_cqe = stream->GetStarsWrCqeFlag();

    sqe->header.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    sqe->header.task_id = taskInfo->id;

    sqe->kernelCredit = GetSdmaKernelCredit();
    sqe->ptrMode = 0;

    const bool isReduce = ((copyKind == RT_MEMCPY_SDMA_AUTOMATIC_ADD) || (copyKind == RT_MEMCPY_SDMA_AUTOMATIC_MAX) ||
                          (copyKind == RT_MEMCPY_SDMA_AUTOMATIC_MIN) || (copyKind == RT_MEMCPY_SDMA_AUTOMATIC_EQUAL));

    sqe->opcode = isReduce ? GetOpcodeForReduce(taskInfo) : 0U;
    sqe->src_streamid = 0U; // get sid and ssid from sq, leave 0 here
    sqe->dst_streamid = 0U;
    sqe->src_sub_streamid = 0U;
    sqe->dstSubStreamId = 0U;
    sqe->length = static_cast<uint32_t>(memcpyAsyncTaskInfo->size & MAX_UINT32_NUM);
    sqe->src_addr_low  =
        static_cast<uint32_t>(RtPtrToValue(memcpyAsyncTaskInfo->src) & 0x00000000FFFFFFFFU);
    sqe->src_addr_high =
        static_cast<uint32_t>((RtPtrToValue(memcpyAsyncTaskInfo->src) & 0xFFFFFFFF00000000U) >> UINT32_BIT_NUM);
    sqe->dst_addr_low  =
        static_cast<uint32_t>(RtPtrToValue(memcpyAsyncTaskInfo->destPtr) & 0x00000000FFFFFFFFU);
    sqe->dst_addr_high =
        static_cast<uint32_t>((RtPtrToValue(memcpyAsyncTaskInfo->destPtr) & 0xFFFFFFFF00000000U) >> UINT32_BIT_NUM);

    sqe->ie2  = 0U;
    sqe->sssv = 1U;
    sqe->dssv = 1U;
    sqe->sns  = 1U;
    sqe->dns  = 1U;
    sqe->qos  = memcpyAsyncTaskInfo->qos;
    sqe->sro  = 0U;
    sqe->dro  = 0U;
    sqe->partid = memcpyAsyncTaskInfo->partId;
    sqe->mpam = 0U;
    if ((taskInfo->stream->Device_()->GetDevProperties().memcpyAsyncTaskD2DQos != UINT32_MAX) &&
        (copyType == RT_MEMCPY_DIR_D2D_SDMA || copyType == RT_MEMCPY_ADDR_D2D_SDMA) &&
        (memcpyAsyncTaskInfo->isD2dCross == false)) {
        sqe->qos = 6U;
    }
    sqe->res3 = 0U;
    sqe->res4 = 0U;
    sqe->res5 = 0U;
    sqe->res6 = 0U;

    sqe->d2dOffsetFlag = 0U;
    sqe->srcOffsetLow = 0U;
    sqe->dstOffsetLow = 0U;
    sqe->srcOffsetHigh = 0U;
    sqe->dstOffsetHigh = 0U;
    if ((copyType == RT_MEMCPY_ADDR_D2D_SDMA) && memcpyAsyncTaskInfo->d2dOffsetFlag) {
        sqe->d2dOffsetFlag = 1U;
        sqe->srcOffsetLow = static_cast<uint32_t>(memcpyAsyncTaskInfo->srcOffset);
        sqe->dstOffsetLow = static_cast<uint32_t>(memcpyAsyncTaskInfo->dstOffset);
        sqe->srcOffsetHigh = static_cast<uint16_t>((memcpyAsyncTaskInfo->srcOffset) >> UINT32_BIT_NUM);
        sqe->dstOffsetHigh = static_cast<uint16_t>((memcpyAsyncTaskInfo->dstOffset) >> UINT32_BIT_NUM);
    }
    RT_LOG(RT_LOG_INFO, "ConstructSqe size=%llu, qos=%u, partid=%u, copyType=%u, kernelCredit=%u, dstSubStreamId=%u, "
        "copyKind=%u, Opcode=0x%x, taskType=%d.", memcpyAsyncTaskInfo->size, sqe->qos,
        sqe->partid, copyType, sqe->kernelCredit, static_cast<uint32_t>(sqe->dstSubStreamId),
        static_cast<uint32_t>(copyKind), static_cast<uint32_t>(sqe->opcode), taskInfo->type);
    PrintSqe(command, "sdmaTask");
}

void ConstructSqeForMemcpyAsyncTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = taskInfo->stream->Device_()->Driver_();

    bool isMemcpyAsyncTaskSqeType = taskInfo->stream->Device_()->GetDevProperties().isMemcpyAsyncTaskSqeType;
    if (!isMemcpyAsyncTaskSqeType) {
        ConstructPlaceHolderSqe(taskInfo, command);
        RT_LOG(RT_LOG_INFO, "MemcpyAsyncTask in 1910b tiny using PH SQE. stream_id=%d, task_id=%u",
               static_cast<int32_t>(stream->Id_()), static_cast<uint32_t>(taskInfo->id));
        return;
    }

    if ((driver->GetRunMode() == RT_RUN_MODE_ONLINE) && IsPcieDma(memcpyAsyncTaskInfo->copyType)) {
        ConstructPcieDmaSqe(taskInfo, command);
    } else {
        ConstructMemcpySqe(taskInfo, command);
    }

    RT_LOG(RT_LOG_INFO, "MemcpyAsyncTask, stream_id=%d, task_id=%u, copyType=%u",
        static_cast<int32_t>(stream->Id_()), static_cast<uint32_t>(taskInfo->id), memcpyAsyncTaskInfo->copyType);
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
        // except for david, free pcie-dma desc in ts_agent
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

rtError_t WaitAsyncCopyCompleteForMemcpyTask(TaskInfo* taskInfo)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    if (memcpyAsyncTaskInfo->updateArgHandle == nullptr) {
        return RT_ERROR_NONE;
    }
    Handle *argHdl = static_cast<Handle *>(memcpyAsyncTaskInfo->updateArgHandle);
    if (!(argHdl->freeArgs) || argHdl->argsAlloc == nullptr || argHdl->kerArgs == nullptr) {
        return RT_ERROR_NONE;
    }
    const rtError_t error = argHdl->argsAlloc->H2DMemCopyWaitFinish(argHdl->kerArgs);
    if (error != RT_ERROR_NONE) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "H2DMemCopyWaitFinish for args cpy result failed, retCode=%#x.", static_cast<uint32_t>(error));
        return error;
    }

    return RT_ERROR_NONE;
}
#endif

#if F_DESC("MemWriteValueTask")
void ConstructSqeForMemWriteValueTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    Stream * const stream = taskInfo->stream;
    RtStarsWriteValueSqe * const sqe = &(command->writeValueSqe);

    (void)memset_s(sqe, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    sqe->header.type = RT_STARS_SQE_TYPE_WRITE_VALUE;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wr_cqe = stream->GetStarsWrCqeFlag();
    sqe->header.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    sqe->header.task_id = taskInfo->id;

    sqe->va = 1U;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->awsize = taskInfo->u.memWriteValueTask.awSize;

    const uint64_t value = taskInfo->u.memWriteValueTask.value;
    const uint64_t devAddr = taskInfo->u.memWriteValueTask.devAddr;
    if (devAddr == 0ULL) {
        sqe->header.type = RT_STARS_SQE_TYPE_INVALID;
        return;
    }
    sqe->write_value_part0 = static_cast<uint32_t>(value & MASK_32_BIT);
    sqe->write_value_part1 = static_cast<uint32_t>((value >> UINT32_BIT_NUM) & MASK_32_BIT);
    sqe->write_addr_low = static_cast<uint32_t>(devAddr & MASK_32_BIT);
    sqe->write_addr_high = static_cast<uint32_t>((devAddr >> UINT32_BIT_NUM) & MASK_17_BIT);

    PrintSqe(command, "MemWriteValueTask");
    RT_LOG(RT_LOG_INFO, "MemWriteValueTask stream_id=%d, task_id=%hu, devAddr=%#" PRIx64
        ", value:%#" PRIx64, stream->Id_(), taskInfo->id, devAddr, value);
}
#endif

#if F_DESC("MemWaitValueTask")
static void ConstructSecondSqeForMemWaitValueTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    Stream * const stream = taskInfo->stream;
    RtStarsWriteValueSqe * const sqe = &(command->writeValueSqe);

    (void)memset_s(sqe, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));
    sqe->header.type = RT_STARS_SQE_TYPE_WRITE_VALUE;
    sqe->header.ie = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.pre_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.post_p = RT_STARS_SQE_INT_DIR_NO;
    sqe->header.wr_cqe = stream->GetStarsWrCqeFlag();
    sqe->header.rt_stream_id = static_cast<uint16_t>(stream->Id_());
    sqe->header.task_id = taskInfo->id;

    sqe->va = 1U;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->awsize = taskInfo->u.memWaitValueTask.awSize;

    constexpr uint64_t value = 0ULL;
    const uint64_t devAddr =
        RtPtrToValue(taskInfo->u.memWaitValueTask.writeValueAddr);
    if (devAddr == 0ULL) {
        sqe->header.type = RT_STARS_SQE_TYPE_INVALID;
        return;
    }
    sqe->write_value_part0 = static_cast<uint32_t>(value & MASK_32_BIT);
    sqe->write_value_part1 = static_cast<uint32_t>(value >> UINT32_BIT_NUM);
    sqe->write_addr_low = static_cast<uint32_t>(devAddr & MASK_32_BIT);
    sqe->write_addr_high = static_cast<uint32_t>((devAddr >> UINT32_BIT_NUM) & MASK_17_BIT);

    PrintSqe(command, "MemWaitValueTask second sqe");
    RT_LOG(RT_LOG_INFO, "MemWaitValueTask second sqe, stream_id=%d, task_id=%hu, devAddr=0x%llx, "
        "value=0x%llx", stream->Id_(), taskInfo->id, devAddr, value);
}

static void ConstructLastSqeForMemWaitValueTask(TaskInfo* taskInfo, rtStarsSqe_t *const command,
                                                const RtStarsMemWaitValueInstrFcPara &fcPara)
{
    MemWaitValueTaskInfo *memWaitValueTask = &taskInfo->u.memWaitValueTask;
    RtStarsFunctionCallSqe &sqe = command->fuctionCallSqe;
    Stream *const stm = taskInfo->stream;
    rtError_t ret;
    uint64_t funcCallSize;

    (void)memset_s(&sqe, sizeof(rtStarsSqe_t), 0, sizeof(rtStarsSqe_t));

    if (taskInfo->stream->IsSoftwareSqEnable()) {
        RtStarsMemWaitValueLastInstrFcEx fcEx = {};
        funcCallSize = static_cast<uint64_t>(sizeof(RtStarsMemWaitValueLastInstrFcEx));
        ConstructMemWaitValueInstr2Ex(fcEx, fcPara);
        ret = taskInfo->stream->Device_()->Driver_()->MemCopySync(memWaitValueTask->funcCallSvmMem2,
            memWaitValueTask->funCallMemSize2, &fcEx, funcCallSize,
            RT_MEMCPY_HOST_TO_DEVICE);
    } else {
        RtStarsMemWaitValueLastInstrFc fc = {};
        funcCallSize = static_cast<uint64_t>(sizeof(RtStarsMemWaitValueLastInstrFc));
        ConstructMemWaitValueInstr2(fc, fcPara);
        ret = taskInfo->stream->Device_()->Driver_()->MemCopySync(memWaitValueTask->funcCallSvmMem2,
            memWaitValueTask->funCallMemSize2, &fc, funcCallSize,
            RT_MEMCPY_HOST_TO_DEVICE);
    }
    if (ret != RT_ERROR_NONE) {
        sqe.sqeHeader.type = RT_STARS_SQE_TYPE_INVALID;
        return;
    }

    sqe.kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe.csc = 1U;
    sqe.sqeHeader.l1_lock = 0U;
    sqe.sqeHeader.l1_unlock = 0U;
    sqe.sqeHeader.type = RT_STARS_SQE_TYPE_COND;
    sqe.sqeHeader.wr_cqe = stm->GetStarsWrCqeFlag();
    sqe.sqeHeader.block_dim = 0U;
    sqe.sqeHeader.rt_stream_id = static_cast<uint16_t>(stm->Id_());
    sqe.sqeHeader.task_id = taskInfo->id;
    sqe.conds_sub_type = CONDS_SUB_TYPE_MEM_WAIT_VALUE;

    const uint64_t funcAddr = RtPtrToValue(memWaitValueTask->funcCallSvmMem2);

    // func call size is rs2[19:0]*4Byte
    ConstructFunctionCallInstr(funcAddr, (funcCallSize / 4UL), sqe);

    PrintSqe(command, "MemWaitValueTask last sqe");
    RT_LOG(RT_LOG_INFO, "MemWaitValueTask last sqe, stream_id=%d, task_id=%hu, devAddr=0x%llx, "
        "value=0x%llx, sqHeadPre=%u, flag=%u", stm->Id_(), taskInfo->id,
        fcPara.devAddr, fcPara.value, fcPara.sqHeadPre, fcPara.flag);
}

void ConstructPhSqeForMemWaitValueTask(TaskInfo * const taskInfo, rtStarsSqe_t *const command)
{
    Stream * const stream = taskInfo->stream;
    const uint32_t taskPosTail = stream->GetBindFlag() ?
        stream->GetCurSqPos() : stream->GetTaskPosTail();
    const uint32_t firstSqePos = taskPosTail;
    const uint32_t sqDepth = stream->GetSqDepth();

    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->ie = 0U;
    sqe->pre_p = 1U;
    sqe->post_p = 0U;
    sqe->wr_cqe = 0U;
    sqe->res0 = 0U;
    sqe->task_type = TS_TASK_TYPE_MEM_WAIT_PROF;
    sqe->rt_streamID = static_cast<uint16_t>(stream->Id_());
    sqe->task_id = taskInfo->id;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->u.memWaitTask.dest_sqe_pos = (firstSqePos + 1U) % sqDepth;

    PrintSqe(command, "MemWaitValueTask ph sqe");
    RT_LOG(RT_LOG_INFO, "MemWaitValueTask ph sqe, stream_id:%d task_id:%u.",
        stream->Id_(), static_cast<uint32_t>(taskInfo->id));
}

static void InitFuncCallParaForMemWaitTask(TaskInfo* taskInfo, RtStarsMemWaitValueInstrFcPara &fcPara)
{
    MemWaitValueTaskInfo *memWaitValueTask = &taskInfo->u.memWaitValueTask;
    Stream * const stream = taskInfo->stream;
    const uint32_t rtsqDepth = stream->GetSqDepth();
    const uint32_t taskPosTail = stream->GetBindFlag() ?
        stream->GetCurSqPos() : stream->GetTaskPosTail();
    const uint32_t firstSqePos = taskPosTail;
    const uint32_t sqDepth = stream->GetSqDepth();

    fcPara.devAddr = memWaitValueTask->devAddr;
    fcPara.value = memWaitValueTask->value;
    fcPara.flag = memWaitValueTask->flag;
    fcPara.maxLoop = 15ULL;  /* the max loop num */
    fcPara.sqId = stream->GetSqId();
    fcPara.sqIdMemAddr = stream->GetSqIdMemAddr();
    fcPara.sqHeadPre = (firstSqePos + 1U) % rtsqDepth;
    fcPara.awSize = memWaitValueTask->awSize;
    fcPara.sqHeadNext = (firstSqePos + MEM_WAIT_SQE_NUM) % sqDepth;
    fcPara.lastSqePos = (firstSqePos + MEM_WAIT_SQE_NUM - 1U) % sqDepth;
    fcPara.profSwitchAddr = stream->Device_()->GetProfSwitchAddr();
    fcPara.profSwitchValue = 0x1;
    fcPara.sqTailOffset = stream->Device_()->GetDevProperties().sqTailOffset;
    fcPara.sqRegAddrArray = RtPtrToValue(stream->Device_()->GetSqVirtualArrBaseAddr_());
    if (stream->IsSoftwareSqEnable()) {
        fcPara.sqTailRegAddr = UINT64_MAX;
    } else {
        fcPara.sqTailRegAddr = stream->GetSqRegVirtualAddr() + fcPara.sqTailOffset;
    }

    fcPara.profDisableAddr = memWaitValueTask->profDisableStatusAddr;
    fcPara.bindFlag = stream->GetBindFlag();

    RT_LOG(RT_LOG_INFO, "device_id=%u, stream_id=%d, task_id=%u, sqHeadPre=%u, sqHeadNext=%u, "
        "lastSqePos=%u, profDisableAddr=0x%lx, "
        "profSwitchAddr=0x%lx, sqIdMemAddr=0x%lx, sqRegAddrArray=0x%lx.",
        stream->Device_()->Id_(), stream->Id_(), static_cast<uint32_t>(taskInfo->id),
        fcPara.sqHeadPre, fcPara.sqHeadNext, fcPara.lastSqePos, fcPara.profDisableAddr,
        fcPara.profSwitchAddr, fcPara.sqIdMemAddr, fcPara.sqRegAddrArray);

    return;
}

void ConstructSqeForMemWaitValueTask(TaskInfo* taskInfo, rtStarsSqe_t *const command)
{
    RtStarsMemWaitValueInstrFcPara fcPara = {};
    InitFuncCallParaForMemWaitTask(taskInfo, fcPara);

    ConstructSqeForNopTask(taskInfo, &(command[MEM_WAIT_SQE_INDEX_0]));
    ConstructSecondSqeForMemWaitValueTask(taskInfo, &(command[MEM_WAIT_SQE_INDEX_1]));
    ConstructLastSqeForMemWaitValueTask(taskInfo, &(command[MEM_WAIT_SQE_INDEX_2]), fcPara);
    ConstructPhSqeForMemWaitValueTask(taskInfo, &(command[MEM_WAIT_SQE_INDEX_3]));
    return;
}
#endif

#if F_DESC("UpdateAddressTask")
// Construct the update address sqe.
void ConstructSqeForUpdateAddressTask(TaskInfo * const taskInfo, rtStarsSqe_t * const command)
{
    UpdateAddressTaskInfo *updateAddrTask = &(taskInfo->u.updateAddrTask);
    Stream *const stream = taskInfo->stream;

    RtStarsPhSqe *const sqe = &(command->phSqe);
    sqe->type = RT_STARS_SQE_TYPE_PLACE_HOLDER;
    sqe->wr_cqe = stream->GetStarsWrCqeFlag();
    sqe->rt_streamID = static_cast<uint16_t>(stream->Id_());
    sqe->task_id = taskInfo->id;
    sqe->kernel_credit = RT_STARS_DEFAULT_KERNEL_CREDIT;
    sqe->task_type = TS_TASK_TYPE_UPDATE_ADDRESS;
    sqe->pre_p = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    sqe->post_p = RT_STARS_SQE_INT_DIR_NO;

    sqe->u.updateAddrInfo.dev_addr = updateAddrTask->devAddr;
    sqe->u.updateAddrInfo.len = updateAddrTask->len;
    PrintSqe(command, "UpdateAddressByPlaceHolder");
    RT_LOG(RT_LOG_INFO, "ConstructSqe, len=%" PRIu64 ", stream_id=%d.", updateAddrTask->len, stream->Id_());
}
#endif

static bool MemoryTaskRegister()
{
    TaskFuncSingle memcpyFuncs = {
        .toCommandFunc = &ToCommandBodyForMemcpyAsyncTask,
        .toSqeFunc = &ConstructSqeForMemcpyAsyncTask,
        .doCompleteSuccFunc = &DoCompleteSuccessForMemcpyAsyncTask,
        .taskUnInitFunc = &MemcpyAsyncTaskUnInit,
        .waitAsyncCpCompleteFunc = &WaitAsyncCopyCompleteForMemcpyTask,
        .printErrorInfoFunc = &PrintErrorInfoForMemcpyAsyncTask,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultForMemcpyAsyncTask,
    };
    TaskFuncSingle createL2AddrFuncs = {
        .toCommandFunc = &ToCommandBodyForCreateL2AddrTask,
        .toSqeFunc = &ConstructSqeBase,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle updateAddressFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForUpdateAddressTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle memWriteValueFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForMemWriteValueTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle memWaitValueFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForMemWaitValueTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &MemWaitTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle captureRecordFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForMemWriteValueTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle captureWaitFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForMemWaitValueTask,
        .doCompleteSuccFunc = &DoCompleteSuccess,
        .taskUnInitFunc = &MemWaitTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle ipcRecordFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForMemWriteValueTask,
        .doCompleteSuccFunc = &DoCompleteSuccessForIpcRecordTask,
        .taskUnInitFunc = nullptr,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };
    TaskFuncSingle ipcWaitFuncs = {
        .toCommandFunc = nullptr,
        .toSqeFunc = &ConstructSqeForMemWaitValueTask,
        .doCompleteSuccFunc = &DoCompleteSuccessForIpcWaitTask,
        .taskUnInitFunc = &MemWaitTaskUnInit,
        .waitAsyncCpCompleteFunc = nullptr,
        .printErrorInfoFunc = &PrintErrorInfoCommon,
        .setResultFunc = &SetResultCommon,
        .setStarsResultFunc = &SetStarsResultCommon,
    };

    const auto& chips = GetV100Chips();
    for (auto chip : chips) {
        RegTaskFunc(chip, TS_TASK_TYPE_MEMCPY, memcpyFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_MEM_WRITE_VALUE, memWriteValueFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_MEM_WAIT_VALUE, memWaitValueFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_CAPTURE_RECORD, captureRecordFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_CAPTURE_WAIT, captureWaitFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_IPC_RECORD, ipcRecordFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_IPC_WAIT, ipcWaitFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_CREATE_L2_ADDR, createL2AddrFuncs);
        RegTaskFunc(chip, TS_TASK_TYPE_UPDATE_ADDRESS, updateAddressFuncs);
    }

    return true;
}

static bool g_memoryTaskRegister = MemoryTaskRegister();

}  // namespace runtime
}  // namespace cce
