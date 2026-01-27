/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "marker.h"
#include "bqs_log.h"

namespace Hiva {
void Marker(const QueueScheduleTrack enqueEventTrack) {
    BQS_LOG_ERROR("Time out info:{event:%u, state:%u, schedTimes:%lu, schedDelay:%lu, startStamp:%lu, "
        "dequeueNum:%lu, dequeueCost:%lu, enqueueNum:%lu, enqueueCost:%lu, copyCost:%lu, statusAndDepthCost:%lu, "
        "fullQueueNum:%u, srcQueueNum:%u, relationCost:%lu, f2NFCost:%lu, totalCost:%lu}",
        enqueEventTrack.event, enqueEventTrack.state, enqueEventTrack.schedTimes, enqueEventTrack.schedDelay,
        enqueEventTrack.startStamp, enqueEventTrack.dequeueNum, enqueEventTrack.dequeueCost,
        enqueEventTrack.enqueueNum, enqueEventTrack.enqueueCost, enqueEventTrack.copyCost,
        enqueEventTrack.statusAndDepthCost, enqueEventTrack.fullQueueNum, enqueEventTrack.srcQueueNum,
        enqueEventTrack.relationCost, enqueEventTrack.f2NFCost, enqueEventTrack.totalCost);
}
}