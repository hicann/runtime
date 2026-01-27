/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpu_context.h"
#include "aicpu_sched/common/type_def.h"
#include <string>
#include <map>

namespace {
std::map<std::string, std::string> g_ctx;
}

namespace aicpu {
bool HasErrorLog()
{
    return false;
}

status_t SetOpname(const std::string &opname)
{
    return AICPU_ERROR_NONE;
}

status_t InitTaskMonitorContext(uint32_t aicpuCoreCnt)
{
    return AICPU_ERROR_NONE;
}

uint32_t GetAicpuThreadIndex()
{
    return 0;
}

status_t SetAicpuThreadIndex(uint32_t threadIndex)
{
    return AICPU_ERROR_NONE;
}

status_t GetOpname(uint32_t threadIndex, std::string &opname)
{
    return AICPU_ERROR_NONE;
}

status_t SetThreadLocalCtx(const std::string &key, const std::string &value)
{
    return AICPU_ERROR_NONE;
}

status_t SetTaskAndStreamId(uint64_t taskId, uint32_t streamId)
{
    return AICPU_ERROR_NONE;
}

const std::map<std::string, std::string> &GetAllThreadCtxInfo(aicpu::CtxType type, uint32_t threadIndex)
{
    return g_ctx;
}

void UpdateModelMode(const bool mode) {}

void InitAicpuErrorLog()
{
    return;
}

void RestoreErrorLog(const char_t * const funcName, const char_t * const filePath, const int32_t lineNumber,
                     const uint64_t tid, const char_t * const format, ...)
{
    return;
}

class ProfModelMessage {
public:
    explicit ProfModelMessage(const char *tag) {};
    virtual ~ProfModelMessage() = default;
    ProfModelMessage *SetDataTagId(const uint16_t dataTagId)
    {
        return this;
    }
    ProfModelMessage *SetAicpuModelIterId(const uint16_t indexId)
    {
        return this;
    }
    ProfModelMessage *SetAicpuModelTimeStamp(const uint64_t timeStamp)
    {
        return this;
    }
    ProfModelMessage *SetAicpuModelId(const uint32_t modelId)
    {
        return this;
    }
    ProfModelMessage *SetAicpuTagId(const uint16_t tagId)
    {
        return this;
    }
    ProfModelMessage *SetEventId(const uint16_t eventId)
    {
        return this;
    }
    ProfModelMessage *SetDeviceId(const uint32_t deviceId)
    {
        return this;
    }
    int32_t ReportProfModelMessage();
private:
    ProfModelMessage(const ProfModelMessage&) = delete;
    ProfModelMessage& operator=(const ProfModelMessage&) = delete;
};
}  // namespace aicpu
