/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef PROFILE_COMMON_H
#define PROFILE_COMMON_H

#include <time.h>

namespace Hiva {
struct KernelTrack {
    uint64_t opStamp;
    int     pid;
    int     tid;
    int32_t eventId;
    int32_t uniqueId;
    int32_t sensorId;
    int32_t modelId;
    int32_t streamId;
    int32_t queueId;
    uint64_t dqStart;
    uint64_t dqEnd;
    uint64_t modelStart;
    uint64_t prepareOutStart;
    uint64_t prepareOutEnd;
    uint64_t activeStream;
    uint64_t endGraph;
    uint64_t eqStart;
    uint64_t eqEnd;
    uint64_t modelEnd;
    uint64_t repeatStart;
    uint64_t repeatEnd;
    timespec rawStamp;
    uint32_t errorCode;
    uint64_t procEventStart;
    uint64_t procEventEnd;
    uint32_t tsStreamId;
};
}
#endif
