/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_COMMON_CONFIG_MANAGER_H
#define ANALYSIS_DVVP_COMMON_CONFIG_MANAGER_H

#include <string>
#include <map>
#include "singleton/singleton.h"
#include "errno/error_code.h"
#include "utils/utils.h"
#include "message/prof_params.h"

namespace Analysis {
namespace Dvvp {
namespace Common {
namespace Config {

#define HELPER_DEVICE_TYPE MDC_TYPE
constexpr uint32_t VER_310M = 5;
enum class PlatformType {
    MINI_TYPE = 0,
    CLOUD_TYPE,
    MDC_TYPE,
    DC_TYPE = 4,
    CHIP_V4_1_0,
    MINI_V3_TYPE = 7,
    CHIP_TINY_V1 = 8,
    CHIP_NANO_V1 = 9,
    CHIP_MDC_MINI_V3 = 11,
    CHIP_MDC_LITE = 12,
    CHIP_CLOUD_V3 = 15,
    CHIP_CLOUD_V4 = 16,
    END_TYPE
};

const std::map<PlatformType, std::string> FREQUENCY_TYPE = {
    {PlatformType::MINI_TYPE, "19.2"},
    {PlatformType::CLOUD_TYPE, "100"},
    {PlatformType::DC_TYPE, "38.4"},
    {PlatformType::MDC_TYPE, "38.4"},
    {PlatformType::CHIP_V4_1_0, "50"},
    {PlatformType::MINI_V3_TYPE, "48"},
    {PlatformType::CHIP_MDC_MINI_V3, "48"},
    {PlatformType::CHIP_TINY_V1, "48"},
    {PlatformType::CHIP_MDC_LITE, "38.4"},
    {PlatformType::CHIP_CLOUD_V3, "50"},
    {PlatformType::CHIP_CLOUD_V4, "1000"}
};

const std::map<PlatformType, std::string> AIC_TYPE = {
    {PlatformType::MINI_TYPE, "680"},
    {PlatformType::CLOUD_TYPE, "800"},
    {PlatformType::DC_TYPE, "1150"},
    {PlatformType::MDC_TYPE, "960"},
    {PlatformType::CHIP_V4_1_0, "800"},
    {PlatformType::MINI_V3_TYPE, "1250"},
    {PlatformType::CHIP_MDC_MINI_V3, "1250"},
    {PlatformType::CHIP_TINY_V1, "1250"},
    {PlatformType::CHIP_MDC_LITE, "1250"},
    {PlatformType::CHIP_CLOUD_V3, "800"},
    {PlatformType::CHIP_CLOUD_V4, "1650"}
};

class ConfigManager : public analysis::dvvp::common::singleton::Singleton<ConfigManager> {
public:
    ConfigManager();
    ~ConfigManager() override;
    int32_t Init();
    void Uninit();
    std::string GetFrequency() const;
    std::string GetChipIdStr();
    PlatformType GetPlatformType() const;
    std::string GetAicDefFrequency() const;
    bool IsDriverSupportLlc() const;
    std::string GetPerfDataDir(const int32_t devId = 0) const;
    std::string GetDefaultWorkDir() const;
    void GetVersionSpecificMetrics(std::string &aicMetrics) const;

private:
    void InitFrequency();

    bool isInit_;
    std::map<std::string, std::string> configMap_;
};
}
}
}
}
#endif
