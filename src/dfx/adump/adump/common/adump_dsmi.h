/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADUMP_COMMON_ADUMP_DSMI_H
#define ADUMP_COMMON_ADUMP_DSMI_H
#include <cstdint>
#include <vector>
#if !defined(ADUMP_SOC_HOST) || ADUMP_SOC_HOST == 1
#include <string>
#endif

namespace Adx {
constexpr uint32_t DEFAULT_CHIP_TYPE    = 2;
constexpr int32_t SUPPORTED_DRV_VERSION = 467735; // 2024.5.16
enum class SysPlatformType {
    DEVICE = 0,
    HOST = 1,
    INVALID = 2
};

enum class PlatformType : uint32_t{
    CHIP_MINI_TYPE = 0,
    CHIP_CLOUD_TYPE,
    CHIP_MDC_TYPE,
    CHIP_DC_TYPE = 4,
    CHIP_CLOUD_V2,
    CHIP_MINI_V3_TYPE = 7,
    CHIP_TINY_V1 = 8,
    CHIP_NANO_V1 = 9,
    CHIP_MDC_MINI_V3 = 11,
    CHIP_MDC_LITE = 12,
    CHIP_CLOUD_V3 = 13,
    CHIP_CLOUD_V4 = 15,
    END_TYPE
};

class AdumpDsmi {
public:
    static uint32_t DrvGetDevNum();
    static std::vector<uint32_t> DrvGetDeviceList();
    static bool DrvGetDevIds(uint32_t numDevices, std::vector<uint32_t> &devIds);
    static bool DrvGetDeviceStatus(const uint32_t deviceId);
    static bool DrvGetPlatformType(uint32_t &platformType);
    static bool DrvGetPlatformInfo(uint32_t &platformInfo);
#if !defined(ADUMP_SOC_HOST) || ADUMP_SOC_HOST == 1
    static int32_t DrvGetAPIVersion();
#endif
};
} // namespace Adx
#endif // ADUMP_COMMON_ADUMP_DSMI_H