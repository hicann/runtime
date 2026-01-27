/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DVVP_COLLECT_PLATFORM_DAVID_PLATFORM_H
#define DVVP_COLLECT_PLATFORM_DAVID_PLATFORM_H
#include "platform_interface.h"

namespace Dvvp {
namespace Collect {
namespace Platform {
class DavidPlatform : public PlatformInterface {
public:
    DavidPlatform();
    ~DavidPlatform() override {}
    uint16_t GetMaxMonitorNumber() const override;

protected:
    std::string GetPipeUtilizationMetrics() override;
    std::string GetMemoryMetrics() override;
    std::string GetMemoryL0Metrics() override;
    std::string GetMemoryUBMetrics() override;
    std::string GetArithmeticUtilizationMetrics() override;
    std::string GetResourceConflictRatioMetrics() override;
    std::string GetL2CacheMetrics() override;
    int32_t InitOnlineAnalyzer() override;
    std::string GetL2CacheEvents() override;
    uint16_t GetQosMonitorNumber() const override;

private:
    void InsertSysFeature();
};
}}}
#endif