/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DVVP_TEST_STUB_PLATFORM_RC_V2_PLATFORM_STUB_H
#define DVVP_TEST_STUB_PLATFORM_RC_V2_PLATFORM_STUB_H
#include "platform_interface.h"

namespace Dvvp {
namespace Collect {
namespace Platform {
// RC v2形态桩平台类：能力与扩展仓v2平台实现对齐，数值注册chip id 17
class RcV2PlatformStub : public PlatformInterface {
public:
    RcV2PlatformStub();
    ~RcV2PlatformStub() override {}
    std::string GetDeviceOscDefaultFreq() override;
    std::string GetAicDefaultFreq() override;
    uint16_t GetMaxMonitorNumber() const override;
    uint16_t GetQosMonitorNumber() const override;
    std::vector<BiuPerfChannelInfo> GetBiuPerfChannelInfos(
        const std::vector<uint32_t>& groupVector, uint32_t groupNum) const override;
    std::vector<std::string> GetHiddenCliArgs() const override;

protected:
    std::string GetPipeUtilizationMetrics() override;
    std::string GetMemoryMetrics() override;
    std::string GetMemoryL0Metrics() override;
    std::string GetMemoryUBMetrics() override;
    std::string GetArithmeticUtilizationMetrics() override;
    std::string GetResourceConflictRatioMetrics() override;
    std::string GetL2CacheMetrics() override;
    std::string GetL2CacheEvents() override;
    std::string GetNtsPipeUtilizationMetrics() override;
};
} // namespace Platform
} // namespace Collect
} // namespace Dvvp
#endif
