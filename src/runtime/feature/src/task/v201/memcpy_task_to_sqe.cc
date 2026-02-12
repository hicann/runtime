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
    if (cmoModel == nullptr) {
        if ((cmoTsk->cmoSqeInfo.opCode == RT_CMO_PREFETCH) || (cmoTsk->cmoSqeInfo.opCode == RT_CMO_WRITEBACK)) {
            ConstructDavidCmoSqe(taskInfo, davidSqe, sqBaseAddr);
        } else {
            ConstructDavidCmoSdmaSqe(taskInfo, davidSqe, sqBaseAddr);
        }
    } else {
        // CmoTask for model stream.
        ConstructDavidCmoAddrSqe(taskInfo, davidSqe, sqBaseAddr);
    }
}

void ConstructDavidSqeForMemcpyAsyncTask(TaskInfo *const taskInfo, rtDavidSqe_t *const davidSqe, uint64_t sqBaseAddr)
{
    MemcpyAsyncTaskInfo * const memcpyAsyncTaskInfo = &(taskInfo->u.memcpyAsyncTaskInfo);
    Stream * const stream = taskInfo->stream;
    ConstructDavidMemcpySqe(taskInfo, davidSqe, sqBaseAddr);

    const uint32_t copyKind = memcpyAsyncTaskInfo->copyKind;
    const bool isReduce = ((copyKind == RT_MEMCPY_SDMA_AUTOMATIC_ADD) || (copyKind == RT_MEMCPY_SDMA_AUTOMATIC_MAX) ||
                           (copyKind == RT_MEMCPY_SDMA_AUTOMATIC_MIN) || (copyKind == RT_MEMCPY_SDMA_AUTOMATIC_EQUAL));

    RtDavidStarsMemcpySqe *const sqe = &(davidSqe->memcpyAsyncSqe);
    sqe->opcode = isReduce ? GetOpcodeForReduce(taskInfo) : 0U;
    if (isReduce && (memcpyAsyncTaskInfo->copyDataType == RT_DATA_TYPE_UINT32)) {
        sqe->opcode = 0U;
        sqe->opcode |= static_cast<uint8_t>(RT_STARS_MEMCPY_ASYNC_DATA_TYPE_UINT32);
        sqe->opcode |= ReduceOpcodeLow(taskInfo);
    }

    RT_LOG(RT_LOG_INFO, "copyKind=%u, Opcode=0x%x.", static_cast<uint32_t>(copyKind),
        static_cast<uint32_t>(sqe->opcode));

    PrintDavidSqe(davidSqe, "sdmaTask");
    RT_LOG(RT_LOG_INFO, "ConstructMemcpySqe, size=%u, qos=%u, partid=%u, copyType=%u, deviceId=%u, streamId=%d,"
        "taskId=%hu", static_cast<uint32_t>(memcpyAsyncTaskInfo->size), sqe->qos, sqe->mapamPartId, memcpyAsyncTaskInfo->copyType,
        taskInfo->stream->Device_()->Id_(), stream->Id_(), taskInfo->id);

    RT_LOG(RT_LOG_INFO, "MemcpyAsyncTask, deviceId=%u, streamId=%d, taskId=%u, copyType=%u",
        taskInfo->stream->Device_()->Id_(), static_cast<int32_t>(stream->Id_()), static_cast<uint32_t>(taskInfo->id),
        memcpyAsyncTaskInfo->copyType);
}

}  // namespace runtime
}  // namespace cce