/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <stdint.h>
void FiniMarker();

void InitMarker();

namespace Hiva {
#ifndef QUEUE_SCHEDULE_TRACK_TAG_DEFINE
#define QUEUE_SCHEDULE_TRACK_TAG_DEFINE
typedef struct QueueScheduleTrackTag {
    uint64_t schedDelay;
    uint64_t startStamp;
    uint64_t schedTimes;
    uint32_t event;
    uint32_t state;
    uint32_t recordThreshold;
    uint64_t dequeueNum;
    uint64_t dequeueCost;
    uint64_t enqueueNum;
    uint64_t enqueueCost;
    uint64_t copyCost;
    uint64_t statusAndDepthCost;
    uint32_t fullQueueNum;
    uint32_t srcQueueNum;
    uint64_t relationCost;
    uint64_t f2NFCost;
    uint64_t totalCost;
} QueueScheduleTrack;
#endif
}