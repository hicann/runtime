/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADUMP_COMMON_PLATFORM_CLOUD_V6_PLATFORM_H
#define ADUMP_COMMON_PLATFORM_CLOUD_V6_PLATFORM_H

#include "cloud_v4_platform.h"

namespace Adx {

// CHIP_CLOUD_V6 (DV100Lite) 各特性域实现。各域行为与 V4 一致，通过继承 V4 实现复用；
// 仅平台类型不同，需独立派生类以便平台注册。
class CloudV6Features : public CloudV4Features {};

class CloudV6Coredump : public CloudV4Coredump {
public:
    uint16_t ConvertCoreId(uint8_t coreType, uint16_t coreId) const override;
};

class CloudV6Exception : public CloudV4Exception {};

class CloudV6DataDump : public CloudV4DataDump {
public:
    uint64_t GetKfcStackSize() const override;
    size_t GetCoreTypeIDOffset() const override;
    size_t GetBlockNum() const override;
};

} // namespace Adx
#endif // ADUMP_COMMON_PLATFORM_CLOUD_V6_PLATFORM_H
