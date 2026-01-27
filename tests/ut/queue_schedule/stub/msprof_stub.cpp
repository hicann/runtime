/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "msprof_stub.h"

#include <atomic>
#include "common/bqs_log.h"
#include "toolchain/prof_api.h"

namespace qstest {
ProfCommandHandle g_profCallback = nullptr;

int32_t RunMsprofCallback(uint32_t type, void *data, uint32_t len)
{
    if (g_profCallback == nullptr) {
        BQS_LOG_ERROR("Prof callback is nullptr, type=%u", type);
        return 1;
    }
    BQS_LOG_INFO("Start call prof callback, type=%u", type);
    return g_profCallback(type, data, len);
}
} // namespace qstest


int32_t MsprofInit(uint32_t dataType, void *data, uint32_t dataLen)
{
    BQS_LOG_INFO("In %s, dataType=%u", __func__, dataType);

    return 0;
}

int32_t MsprofFinalize()
{
    return 0;
}

int32_t MsprofRegTypeInfo(uint16_t level, uint32_t typeId, const char *typeName)
{
    BQS_LOG_INFO("In %s, typeId=%u", __func__, typeId);

    return 0;
}

int32_t MsprofRegisterCallback(uint32_t moduleId, ProfCommandHandle handle)
{
    BQS_LOG_INFO("In %s, moduleId=%u", __func__, moduleId);
    qstest::g_profCallback = handle;

    return 0;
}

int32_t MsprofReportApi(uint32_t agingFlag, const MsprofApi *api)
{
    BQS_LOG_INFO("In %s, agingFlag=%u", __func__, agingFlag);

    BQS_LOG_INFO("level=%u, type=%u, threadId=%u, beginTime=%u, endTime=%lu, itemId=%u",
                 api->level, api->type, api->threadId, api->beginTime, api->endTime, api->itemId);

    return 0;
}

int32_t MsprofReportEvent(uint32_t agingFlag, const MsprofEvent *event)
{
    BQS_LOG_INFO("In %s, agingFlag=%u", __func__, agingFlag);

    BQS_LOG_INFO("level=%u, type=%u, threadId=%u, requestId=%u, timeStamp=%lu, itemId=%u",
                 event->level, event->type, event->threadId, event->requestId, event->timeStamp, event->itemId);
    return 0;
}

uint64_t MsprofSysCycleTime()
{
    static std::atomic<uint64_t> tick(0);
    tick += 10;
    return tick.load();
}
