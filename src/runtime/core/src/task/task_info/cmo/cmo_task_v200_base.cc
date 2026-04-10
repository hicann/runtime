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
#include "stream.hpp"
#include "device.hpp"

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

void PrintErrorInfoForDavidCmoTask(TaskInfo* taskInfo, const uint32_t devId)
{
    const auto dev = taskInfo->stream->Device_();
    CmoAddrTaskInfo *cmoAddrTaskInfo = &(taskInfo->u.cmoAddrTaskInfo);
    Stream * const stream = taskInfo->stream;
    const int32_t streamId = stream->Id_();
    const uint32_t taskId = taskInfo->id;
    if (stream->Model_() == nullptr) {
        return;
    }
    constexpr size_t cmoInfoSize = sizeof(rtDavidCmoAddrInfo) / sizeof(uint32_t);
    std::array<uint32_t, cmoInfoSize> cmoInfo = {0};
    
    const rtError_t error = dev->Driver_()->MemCopySync(RtPtrToPtr<void *>(cmoInfo.data()), sizeof(rtDavidCmoAddrInfo),
        cmoAddrTaskInfo->cmoAddrInfo, sizeof(rtDavidCmoAddrInfo), RT_MEMCPY_DEVICE_TO_HOST);
    if (error != RT_ERROR_NONE) {
        RT_LOG(RT_LOG_ERROR, "Memcpy failed, size=%lu(Bytes), type=%d(RT_MEMCPY_DEVICE_TO_HOST), retCode=%#x",
            sizeof(rtDavidCmoAddrInfo), static_cast<int32_t>(RT_MEMCPY_DEVICE_TO_HOST), static_cast<uint32_t>(error));
        return;
    }

    RT_LOG(RT_LOG_ERROR, "Sdma for CmoAddrTask in model stream execute failed, device_id=%u, stream_id=%d, task_id=%u,"
           "cmoAddrInfo=0x%llx.", devId, streamId, taskId, RtPtrToValue(cmoAddrTaskInfo->cmoAddrInfo));
    for (size_t i = 0UL; i < cmoInfoSize; i += 8U) {
        RT_LOG(RT_LOG_ERROR, "%s: %08x %08x %08x %08x %08x %08x %08x %08x", "rtCmoAddrInfo",
            cmoInfo[i], cmoInfo[i + 1U], cmoInfo[i + 2U], cmoInfo[i + 3U], cmoInfo[i + 4U], cmoInfo[i + 5U],
            cmoInfo[i + 6U], cmoInfo[i + 7U]);
    }
}
}  // namespace runtime
}  // namespace cce
