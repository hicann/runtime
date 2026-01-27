/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream.hpp"
#include "runtime.hpp"
#include "event_david.hpp"
#include "task_manager.h"
#include "stars.hpp"
#include "stars_david.hpp"
#include "device.hpp"
#include "task_info.h"
#include "error_code.h"
namespace cce {
namespace runtime {

void ConstructDavidCmoSqe(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsCmoSqe * const sqe = &(davidSqe->cmoSqe);
    CmoTaskInfo * const cmoTsk = &(taskInfo->u.cmoTask);
    sqe->header.type = RT_DAVID_SQE_TYPE_CMO;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->cmoType = cmoTsk->cmoSqeInfo.cmoType;
    // The cmoid is not used in the cmo task, but is used in the cmo task kill process.
    sqe->cmoId = static_cast<uint8_t>(static_cast<uint32_t>(taskInfo->stream->Id_()) + 1U);
    sqe->opcode = cmoTsk->cmoSqeInfo.opCode;
    sqe->u.strideMode0.lengthMove = cmoTsk->cmoSqeInfo.lengthInner;
    sqe->u.strideMode0.srcAddrLow  = static_cast<uint32_t>(cmoTsk->cmoSqeInfo.sourceAddr & 0x00000000FFFFFFFFU);
    sqe->u.strideMode0.srcAddrHigh =
        static_cast<uint32_t>((cmoTsk->cmoSqeInfo.sourceAddr & 0xFFFFFFFF00000000U) >> UINT32_BIT_NUM);
    sqe->qos  = cmoTsk->cmoSqeInfo.qos;
    sqe->mapamPartId = cmoTsk->cmoSqeInfo.partId;
    sqe->srcStreamId = 0U;
    sqe->srcSubStreamId = 0U;
    sqe->ie2  = 0U;
    sqe->sssv = 1U;
    sqe->dssv = 1U;
    sqe->sns  = 1U;
    sqe->dns  = 1U;
    sqe->sro  = 0U;
    sqe->dro  = 0U;
    sqe->mpamns = 0U;
    sqe->stride = 0U;
    sqe->compEn = 0U;
    sqe->pmg = cmoTsk->cmoSqeInfo.pmg;
    RT_LOG(RT_LOG_INFO, "ptrMode=%u, lengthInner=%u, opcode=0x%x, deviceId=%u, streamId=%d, taskId=%hu cmoId=%u.",
        static_cast<uint32_t>(sqe->header.ptrMode), static_cast<uint32_t>(sqe->u.strideMode2.lengthInner),
        static_cast<uint32_t>(sqe->opcode), taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(),
        taskInfo->id, sqe->cmoId);
    PrintDavidSqe(davidSqe, "CmoTask");
}

void ConstructDavidCmoAddrSqe(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    CmoAddrTaskInfo * const cmoAddrInfo = &(taskInfo->u.cmoAddrTaskInfo);
    Stream * const stream = taskInfo->stream;
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsMemcpyPtrSqe * const sqe = &(davidSqe->memcpyAsyncPtrSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_SDMA;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->header.ptrMode = 1U;
    sqe->va = 1U;
    sqe->sdmaSqeBaseAddrLow = static_cast<uint32_t>(RtPtrToValue(cmoAddrInfo->cmoAddrInfo) & 0x00000000FFFFFFFFU);
    sqe->sdmaSqeBaseAddrHigh =
        static_cast<uint32_t>((RtPtrToValue(cmoAddrInfo->cmoAddrInfo) & 0x0001FFFF00000000U) >> UINT32_BIT_NUM);
    RT_LOG(RT_LOG_INFO, "ConstructCmoAddrSqe, cmoAddrTaskInfo=%p, deviceId=%u, streamId=%d, taskId=%hu.",
        cmoAddrInfo->cmoAddrInfo, stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id);
    PrintDavidSqe(davidSqe, "CmoAddrTask");
}

void ConstructDavidCmoSdmaSqe(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsMemcpySqe * const sqe = &(davidSqe->memcpyAsyncSqe);
    CmoTaskInfo * const cmoTsk = &(taskInfo->u.cmoTask);
    sqe->header.type = RT_DAVID_SQE_TYPE_SDMA;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->opcode = cmoTsk->cmoSqeInfo.opCode;
    sqe->u.strideMode0.lengthMove = cmoTsk->cmoSqeInfo.lengthInner;
    sqe->u.strideMode0.srcAddrLow  = static_cast<uint32_t>(cmoTsk->cmoSqeInfo.sourceAddr & 0x00000000FFFFFFFFU);
    sqe->u.strideMode0.srcAddrHigh =
        static_cast<uint32_t>((cmoTsk->cmoSqeInfo.sourceAddr & 0xFFFFFFFF00000000U) >> UINT32_BIT_NUM);
    sqe->qos  = cmoTsk->cmoSqeInfo.qos;
    sqe->mapamPartId = cmoTsk->cmoSqeInfo.partId;
    sqe->srcStreamId = 0U;
    sqe->srcSubStreamId = 0U;
    sqe->ie2  = 0U;
    sqe->sssv = 1U;
    sqe->dssv = 1U;
    sqe->sns  = 1U;
    sqe->dns  = 1U;
    sqe->sro  = 0U;
    sqe->dro  = 0U;
    sqe->mpamns = 0U;
    sqe->stride = 0U;
    sqe->compEn = 0U;
    sqe->pmg = cmoTsk->cmoSqeInfo.pmg;
    RT_LOG(RT_LOG_INFO, "ptrMode=%u, lengthInner=%u, opcode=0x%x, deviceId=%u, streamId=%d, taskId=%hu.",
        static_cast<uint32_t>(sqe->header.ptrMode), static_cast<uint32_t>(sqe->u.strideMode2.lengthInner),
        static_cast<uint32_t>(sqe->opcode), taskInfo->stream->Device_()->Id_(), taskInfo->stream->Id_(), taskInfo->id);
    PrintDavidSqe(davidSqe, "CmoTask");
}

static void ConstructDavidMemcpySqePtr(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    MemcpyAsyncTaskInfo * const memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsMemcpyPtrSqe * const sqe = &(davidSqe->memcpyAsyncPtrSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_SDMA;
    sqe->header.ptrMode = 1U;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->va = 1U;
    sqe->sdmaSqeBaseAddrLow =
        static_cast<uint32_t>(RtPtrToValue(memcpyAsyncTaskInfo->memcpyAddrInfo) & 0x00000000FFFFFFFFU);
    sqe->sdmaSqeBaseAddrHigh = static_cast<uint32_t>(
        (RtPtrToValue(memcpyAsyncTaskInfo->memcpyAddrInfo) & 0x0001FFFF00000000U) >> UINT32_BIT_NUM);
    PrintDavidSqe(davidSqe, "MemcpyAsyncPtr");
    RT_LOG(RT_LOG_INFO, "deviceId=%u, streamId=%d, taskId=%hu, memcpyAddrInfo=%p .",
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->id, memcpyAsyncTaskInfo->memcpyAddrInfo);
}

void ConstructDavidMemcpySqe(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr)
{
    MemcpyAsyncTaskInfo * const memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    const uint32_t copyType = memcpyAsyncTaskInfo->copyType;
    const uint32_t copyKind = memcpyAsyncTaskInfo->copyKind;

    if (unlikely((copyType == RT_MEMCPY_ADDR_D2D_SDMA) && (copyKind == RT_MEMCPY_RESERVED))) {
        ConstructDavidMemcpySqePtr(taskInfo, davidSqe, sqBaseAddr);
        return;
    }

    RT_LOG(RT_LOG_INFO, "ConstructDavidMemcpySqe, type=%d.", taskInfo->type);
    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsMemcpySqe *const sqe = &(davidSqe->memcpyAsyncSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_SDMA;
    /* b605-b606 do not support ADDR D2D SDMA */
    if (copyType == RT_MEMCPY_ADDR_D2D_SDMA) {
        sqe->header.preP = 1U;
    }

    if (stream->IsDebugRegister() && (!stream->GetBindFlag())) {
        sqe->header.postP = RT_STARS_SQE_INT_DIR_TO_TSCPU;
    }
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;

    const bool isReduce = ((copyKind == RT_MEMCPY_SDMA_AUTOMATIC_ADD) || (copyKind == RT_MEMCPY_SDMA_AUTOMATIC_MAX) ||
                           (copyKind == RT_MEMCPY_SDMA_AUTOMATIC_MIN) || (copyKind == RT_MEMCPY_SDMA_AUTOMATIC_EQUAL));

    sqe->opcode = isReduce ? GetOpcodeForReduce(taskInfo) : 0U;
    RT_LOG(RT_LOG_INFO, "copyKind=%u Opcode=0x%x.", static_cast<uint32_t>(copyKind),
        static_cast<uint32_t>(sqe->opcode));
    sqe->srcStreamId = 0x1FU; // get sid and ssid from sq, leave 0 here
    sqe->u.strideMode0.dstStreamId =  0x1FU;
    sqe->srcSubStreamId = 1U;
    sqe->u.strideMode0.dstSubStreamId = 1U;
    RT_LOG(RT_LOG_INFO, "ConstructDavidSqe, dstSubStreamId=%u",
        static_cast<uint32_t>(sqe->u.strideMode0.dstSubStreamId));
    sqe->u.strideMode0.lengthMove = memcpyAsyncTaskInfo->size;
    sqe->u.strideMode0.srcAddrLow = static_cast<uint32_t>(RtPtrToValue(memcpyAsyncTaskInfo->src) & 0x00000000FFFFFFFFU);
    sqe->u.strideMode0.srcAddrHigh =
        static_cast<uint32_t>((RtPtrToValue(memcpyAsyncTaskInfo->src) & 0xFFFFFFFF00000000U) >> UINT32_BIT_NUM);
    sqe->u.strideMode0.dstAddrLow =
        static_cast<uint32_t>(RtPtrToValue(memcpyAsyncTaskInfo->destPtr) & 0x00000000FFFFFFFFU);
    sqe->u.strideMode0.dstAddrHigh =
        static_cast<uint32_t>((RtPtrToValue(memcpyAsyncTaskInfo->destPtr) & 0xFFFFFFFF00000000U) >> UINT32_BIT_NUM);
    sqe->vaValid = 0U;
    sqe->ie2  = 0U;
    sqe->sssv = 1U;
    sqe->dssv = 1U;
    sqe->sns  = 1U;
    sqe->dns  = 1U;
    sqe->qos  = memcpyAsyncTaskInfo->qos;
    sqe->sro  = 0U;
    sqe->dro  = 0U;
    sqe->mapamPartId = memcpyAsyncTaskInfo->partId;
    sqe->mpamns = 0U;
    sqe->stride = 0U;
    sqe->compEn = 0U;
    sqe->pmg = 0U;
    if ((copyType == RT_MEMCPY_DIR_D2D_SDMA) || (copyType == RT_MEMCPY_ADDR_D2D_SDMA)) {
        sqe->qos = 6U;
    }
    sqe->res1 = 0U;
    sqe->res2 = 0U;
    sqe->res3 = 0U;
    sqe->res4 = 0U;

    sqe->d2dOffsetFlag = 0U;
    sqe->u.strideMode0.srcOffsetLow = 0U;
    sqe->u.strideMode0.dstOffsetLow = 0U;
    sqe->u.strideMode0.srcOffsetHigh = 0U;
    sqe->u.strideMode0.dstOffsetHigh = 0U;
    if ((copyType == RT_MEMCPY_ADDR_D2D_SDMA) && memcpyAsyncTaskInfo->d2dOffsetFlag) {
        sqe->d2dOffsetFlag = 1U;
        sqe->u.strideMode0.srcOffsetLow = static_cast<uint32_t>(memcpyAsyncTaskInfo->srcOffset);
        sqe->u.strideMode0.dstOffsetLow = static_cast<uint32_t>(memcpyAsyncTaskInfo->dstOffset);
        sqe->u.strideMode0.srcOffsetHigh = static_cast<uint16_t>((memcpyAsyncTaskInfo->srcOffset) >> UINT32_BIT_NUM);
        sqe->u.strideMode0.dstOffsetHigh = static_cast<uint16_t>((memcpyAsyncTaskInfo->dstOffset) >> UINT32_BIT_NUM);
    }
    PrintDavidSqe(davidSqe, "sdmaTask");
    RT_LOG(RT_LOG_INFO, "ConstructMemcpySqe, size=%u, qos=%u, partid=%u, copyType=%u, deviceId=%u, streamId=%d,"
        "taskId=%hu", static_cast<uint32_t>(memcpyAsyncTaskInfo->size), sqe->qos, sqe->mapamPartId, copyType,
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->id);
}

void InitStarsSdmaSqeForDavid(RtDavidStarsMemcpySqe *sdmaSqe, const rtTaskCfgInfo_t * const cfgInfo, const Stream *stm)
{
    sdmaSqe->header.type = RT_DAVID_SQE_TYPE_SDMA;
    if (cfgInfo != nullptr) {
        sdmaSqe->mapamPartId = cfgInfo->partId;
    } else {
        sdmaSqe->mapamPartId = 0U;
    }
    sdmaSqe->opcode = 0U;
    sdmaSqe->qos = 6U;
    sdmaSqe->sssv = 1U;
    sdmaSqe->dssv = 1U;
    sdmaSqe->sns  = 1U;
    sdmaSqe->dns  = 1U;
    sdmaSqe->sro  = 0U;
    sdmaSqe->dro  = 0U;
    sdmaSqe->mpamns = 0U;
    sdmaSqe->stride = 0U;
    sdmaSqe->compEn = 0U;
    sdmaSqe->pmg = 0U;

    sdmaSqe->srcStreamId = static_cast<uint16_t>(RT_SMMU_STREAM_ID_1FU);
    sdmaSqe->u.strideMode0.dstStreamId = static_cast<uint16_t>(RT_SMMU_STREAM_ID_1FU);
    sdmaSqe->srcSubStreamId = static_cast<uint16_t>(stm->Device_()->GetSSID_());
    sdmaSqe->u.strideMode0.dstSubStreamId = static_cast<uint16_t>(stm->Device_()->GetSSID_());
}
}  // namespace runtime
}  // namespace cce