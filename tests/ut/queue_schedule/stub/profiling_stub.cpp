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
namespace aicpu {

void UpdateModelMode(const bool mode) {}

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
