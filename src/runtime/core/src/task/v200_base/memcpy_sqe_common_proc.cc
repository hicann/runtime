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
#include "task_execute_time.h"
namespace cce {
namespace runtime {

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
    RT_LOG(RT_LOG_INFO, "device_id=%u, stream_id=%d, task_id=%hu, memcpyAddrInfo=%p .",
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
    sqe->kernelCredit = GetSdmaKernelCredit();

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