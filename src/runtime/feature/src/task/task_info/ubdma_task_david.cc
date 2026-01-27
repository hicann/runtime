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
void ConstructDavidSqeForUbDirectSendTask(TaskInfo *taskInfo, rtDavidSqe_t * const command, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    Stream * const stream = taskInfo->stream;
    rtDavidSqe_t *sqeAddr = command;
    ConstructDavidSqeForHeadCommon(taskInfo, sqeAddr);
    RtDavidStarsUbdmaDirectWqemodeSqe * const sqe = &(command->davidUbdmaDirectSqe);
    sqe->header.type = RT_DAVID_SQE_TYPE_UBDMA;
    sqe->mode = RT_DAVID_SQE_DIRECTWQE_MODE;
    sqe->dieId = taskInfo->u.directSendTask.dieId;
    sqe->wqeSize =taskInfo->u.directSendTask.wqeSize;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->sqeLength = (taskInfo->u.directSendTask.wqeSize == 1) ? 2U : 1U;
    sqe->jettyId = taskInfo->u.directSendTask.jettyId;
    sqe->funcId = taskInfo->u.directSendTask.funcId;
    PrintDavidSqe(sqeAddr, "UbDirectSend Part0");
    constexpr size_t ubWqesize = 64UL;
    uint8_t *wqe = taskInfo->u.directSendTask.wqe;
    for (uint32_t i = 0U; i <= taskInfo->u.directSendTask.wqeSize; i++) {
        sqeAddr = command + i + 1U;
        if (sqBaseAddr != 0ULL) {
            const uint32_t pos = taskInfo->id + i + 1U;
            sqeAddr = GetSqPosAddr(sqBaseAddr, pos);
        }
        const errno_t ret = memcpy_s(sqeAddr, sizeof(rtDavidSqe_t), wqe + (i * ubWqesize), ubWqesize);
        if (ret != EOK) {
            RT_LOG(RT_LOG_INFO, "Memcpy_s failed,i=%lu, retCode=%d,Size=%d(bytes).", i, ret, ubWqesize);
            sqe->header.type = RT_DAVID_SQE_TYPE_END;
            break;
        }
        std::stringstream descInfo;
        descInfo << "UbDirectSend Part " << (i + 1U); 
        PrintDavidSqe(sqeAddr, descInfo.str().c_str());
    }
    RT_LOG(RT_LOG_INFO, "UbDirectSendTask stream_id=%d task_id=%hu wqeSize=%u",
        stream->Id_(), taskInfo->id, sqe->wqeSize);
}

void ConstructDavidSqeForUbDbSendTask(TaskInfo *taskInfo, rtDavidSqe_t * const command, uint64_t sqBaseAddr)
{
    UNUSED(sqBaseAddr);
    ConstructDavidSqeForHeadCommon(taskInfo, command);
    RtDavidStarsUbdmaDBmodeSqe * const sqe = &(command->davidUbdmaDbSqe);
    Stream * const stream = taskInfo->stream;
    sqe->header.type = RT_DAVID_SQE_TYPE_UBDMA;
    sqe->header.wrCqe = 0U;
    sqe->mode = RT_DAVID_SQE_DOORBELL_MODE;
    sqe->doorbellNum = taskInfo->u.ubSendTask.dbNum;
    sqe->kernelCredit = RT_STARS_DEFAULT_KERNEL_CREDIT_DAVID;
    sqe->sqeLength = 0U;
    sqe->jettyId1 = taskInfo->u.ubSendTask.info[0].jettyId;
    sqe->funcId1 = taskInfo->u.ubSendTask.info[0].funcId;
    sqe->piValue1 = taskInfo->u.ubSendTask.info[0].piVal;
    sqe->dieId1 = taskInfo->u.ubSendTask.info[0].dieId;
    if (taskInfo->u.ubSendTask.dbNum == UB_DOORBELL_NUM_MAX) {
        sqe->jettyId2 = taskInfo->u.ubSendTask.info[1].jettyId;
        sqe->funcId2 = taskInfo->u.ubSendTask.info[1].funcId;
        sqe->piValue2 = taskInfo->u.ubSendTask.info[1].piVal;
        sqe->dieId2 = taskInfo->u.ubSendTask.info[1].dieId;
    }
    PrintDavidSqe(command, "UbDbSend");
    RT_LOG(RT_LOG_INFO, "UbDbSendTask stream_id=%d taskId=%hu dbNum=%u",
        stream->Id_(), taskInfo->id, taskInfo->u.ubSendTask.dbNum);
}

}  // namespace runtime
}  // namespace cce