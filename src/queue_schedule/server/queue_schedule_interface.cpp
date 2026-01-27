/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "queue_schedule_interface.h"
#include "qs_interface_process.h"
#include "common/bqs_status.h"
#include "common/bqs_log.h"
#include "queue_schedule/qs_client.h"

extern "C" {
int32_t InitQueueScheduler(const uint32_t deviceId, const uint32_t reschedInterval)
{
    BQS_LOG_RUN_INFO("QueueSchedule begin.");
    const uint32_t enqueGroupId = static_cast<uint32_t>(bqs::EventGroupId::ENQUEUE_GROUP_ID);
    const uint32_t f2nfGroupId = static_cast<uint32_t>(bqs::EventGroupId::F2NF_GROUP_ID);

    const bqs::InitQsParams initQsParams = {
        .deviceId = deviceId,
        .enqueGroupId = enqueGroupId,
        .f2nfGroupId = f2nfGroupId,
        .reschedInterval = reschedInterval,
        .runMode = bqs::QueueSchedulerRunMode::MULTI_THREAD,
        .pid = 0U,
        .vfId = 0U,
        .pidSign = "",
        .qsInitGrpName = "",
        .schedPolicy = 0UL,
        .starter = bqs::QsStartType::START_BY_TSD,
        .profCfgData = "",
        .abnormalInterVal = 0U,
        .profFlag = false,
        .enqueGroupIdExtra = 0U,
        .f2nfGroupIdExtra = 0U,
        .deviceIdExtra = 0U,
        .numaFlag = false,
        .devIdVec = {},
        .needAttachGroup = false,
    };
    const auto bsqStatus = bqs::QueueScheduleInterface::GetInstance().InitQueueScheduler(initQsParams);
    if (bsqStatus != static_cast<int32_t>(bqs::BQS_STATUS_OK)) {
        BQS_LOG_ERROR("QueueSchedule start failed, ret[%d].", bsqStatus);
        return static_cast<int32_t>(bsqStatus);
    }
    BQS_LOG_RUN_INFO("QueueSchedule start success.");
    return static_cast<int32_t>(bqs::BQS_STATUS_OK);
}
}
