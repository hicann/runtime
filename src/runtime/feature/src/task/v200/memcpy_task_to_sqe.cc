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

void ConstructDavidSqeForCmoTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    Stream * const stm = taskInfo->stream;
    Model *cmoModel = stm->Model_();
    CmoTaskInfo * const cmoTsk = &(taskInfo->u.cmoTask);
    if ((cmoModel != nullptr) && (cmoModel->GetModelType() == RT_MODEL_NORMAL)){
        // CmoTask for model stream.
        ConstructDavidCmoAddrSqe(taskInfo, davidSqe, sqBaseAddr);
    } else {
        if ((cmoTsk->cmoSqeInfo.opCode == RT_CMO_PREFETCH) || (cmoTsk->cmoSqeInfo.opCode == RT_CMO_WRITEBACK)) {
            ConstructDavidCmoSqe(taskInfo, davidSqe, sqBaseAddr);
        } else {
            ConstructDavidCmoSdmaSqe(taskInfo, davidSqe, sqBaseAddr);
        }
    }
}

static void ConstructDavidPcieDmaSqe(TaskInfo * const taskInfo, rtDavidSqe_t * const davidSqe, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    MemcpyAsyncTaskInfo * const memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, davidSqe);
    RtDavidStarsPcieDmaSqe * const sqe = &(davidSqe->pcieDmaSqe);

    sqe->header.type = RT_DAVID_SQE_TYPE_ASYNCDMA;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->sqeLength = 0U;
    sqe->isConverted = 1U;
    sqe->dieId = 0U; // The default value of dieId in pcie sqe is 0.
    const uint64_t sqAddr = RtPtrToValue(memcpyAsyncTaskInfo->dmaAddr.phyAddr.src);
    sqe->pcieDmaSqAddrLow = static_cast<uint32_t>(sqAddr & MASK_32_BIT);
    sqe->pcieDmaSqAddrHigh = static_cast<uint32_t>(sqAddr >> UINT32_BIT_NUM);
    sqe->pcieDmaSqTailPtr = static_cast<uint16_t>(memcpyAsyncTaskInfo->dmaAddr.phyAddr.len);
    PrintDavidSqe(davidSqe, "david pcieDmaTask");
    RT_LOG(RT_LOG_INFO, "PcieDma, deviceId=%u, streamId=%d, taskId=%hu, copyType=%u, sqAddrLow=%p sqTailPtr = %hu.",
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->id, memcpyAsyncTaskInfo->copyType,
        memcpyAsyncTaskInfo->dmaAddr.phyAddr.src, sqe->pcieDmaSqTailPtr);
}

static void ConstructDavidAsyncDmaSqe(TaskInfo * const taskInfo, rtDavidSqe_t *const command, uint64_t sqBaseAddr)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, command);
    RtDavidStarsAsyncDmaSqe * const sqe = &(command->davidAsyncDmaDirectSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_ASYNCDMA;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->sqeLength = 1U;
    sqe->wqeSize = 0U;
    sqe->mode = RT_DAVID_SQE_DIRECTWQE_MODE;
    sqe->jettyId = memcpyAsyncTaskInfo->ubDma.jettyId;
    sqe->funcId = memcpyAsyncTaskInfo->ubDma.functionId;
    sqe->dieId = memcpyAsyncTaskInfo->ubDma.dieId;
    rtDavidSqe_t *sqeAddr = command + 1U;
    if (sqBaseAddr != 0ULL) {
        const uint32_t pos = taskInfo->id + 1U;
        sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
    }

    const errno_t ret = memcpy_s(sqeAddr, sizeof(rtDavidSqe_t), memcpyAsyncTaskInfo->ubDma.wqe.data(),
        static_cast<size_t>(memcpyAsyncTaskInfo->ubDma.wqeLen));

    COND_LOG_ERROR(ret != EOK, "Memcpy_s failed,retCode=%d,Size=%d(bytes).", ret, memcpyAsyncTaskInfo->ubDma.wqeLen);
    PrintDavidSqe(command, "AsyncDmaTaskPart1");
    PrintDavidSqe(sqeAddr, "AsyncDmaTaskPart2");

    RT_LOG(RT_LOG_INFO, "stream_id=%d, task_id=%hu, copyType=%u, src=%#" PRIx64 ", dst=%#" PRIx64,
            stream->Id_(), taskInfo->id, memcpyAsyncTaskInfo->copyType, memcpyAsyncTaskInfo->src,
            memcpyAsyncTaskInfo->destPtr);
    return;
}

static void ConstructDavidAsyncUbDbSqe(TaskInfo * const taskInfo, rtDavidSqe_t *const command)
{
    MemcpyAsyncTaskInfo *memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;

    ConstructDavidSqeForHeadCommon(taskInfo, command);
    RtDavidStarsUbdmaDBmodeSqe * const sqe = &(command->davidUbdmaDbSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_UBDMA;
    sqe->header.wrCqe = 0U;
    sqe->mode = RT_DAVID_SQE_DOORBELL_MODE;
    sqe->doorbellNum = UB_DOORBELL_NUM_MIN;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->sqeLength = 0U;
    sqe->jettyId1 = memcpyAsyncTaskInfo->ubDma.jettyId;
    sqe->funcId1 = memcpyAsyncTaskInfo->ubDma.functionId;
    sqe->dieId1 = memcpyAsyncTaskInfo->ubDma.dieId;
    sqe->piValue1 = 1U;

    PrintDavidSqe(command, "ModelByUb UbDbSend");

    RT_LOG(RT_LOG_INFO,
        "AsyncUbDb, stream_id=%d, task_id=%hu, copyType=%u, src=%#" PRIx64 ", dst=%#" PRIx64,
        stream->Id_(),
        taskInfo->id,
        memcpyAsyncTaskInfo->copyType,
        memcpyAsyncTaskInfo->src,
        memcpyAsyncTaskInfo->destPtr);
    return;
}

void ConstructDavidSqeForMemcpyAsyncTask(TaskInfo * const taskInfo, rtDavidSqe_t *const davidSqe,
    uint64_t sqBaseAddr)
{
    MemcpyAsyncTaskInfo * const memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    Driver * const driver = taskInfo->stream->Device_()->Driver_();

    if (driver->GetRunMode() == RT_RUN_MODE_ONLINE) {
        if (IsDavidUbDma(memcpyAsyncTaskInfo->copyType)) {
            if (stream->GetBindFlag()) {
                ConstructDavidAsyncUbDbSqe(taskInfo, davidSqe);
            } else {
                ConstructDavidAsyncDmaSqe(taskInfo, davidSqe, sqBaseAddr);
            }
        } else if (IsPcieDma(memcpyAsyncTaskInfo->copyType)) {
            ConstructDavidPcieDmaSqe(taskInfo, davidSqe, sqBaseAddr);
        } else {
            ConstructDavidMemcpySqe(taskInfo, davidSqe, sqBaseAddr);
        }
    } else {
        ConstructDavidMemcpySqe(taskInfo, davidSqe, sqBaseAddr);
    }

    RT_LOG(RT_LOG_INFO, "MemcpyAsyncTask, deviceId=%u, streamId=%d, taskId=%u, copyType=%u",
        taskInfo->stream->Device_()->Id_(), static_cast<int32_t>(stream->Id_()), static_cast<uint32_t>(taskInfo->id),
        memcpyAsyncTaskInfo->copyType);
}
}  // namespace runtime
}  // namespace cce