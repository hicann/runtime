/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADUMP_COMMON_PLATFORM_CLOUD_V5_PLATFORM_H
#define ADUMP_COMMON_PLATFORM_CLOUD_V5_PLATFORM_H

#include "cloud_v4_platform.h"

namespace Adx {

// CHIP_CLOUD_V5 各特性域实现。寄存器/异常/数据 dump 行为当前与 V4 一致，通过继承 V4 实现复用；
// coredump 域使用 V5 专用的 PcFixer/Register。
class CloudV5Features : public FeaturesSupportInterface {
public:
    CloudV5Features();
};

class CloudV5Coredump : public CloudV4Coredump {
public:
    std::unique_ptr<PcFixerInterface> CreatePcFixer() const override;
    std::shared_ptr<RegisterInterface> CreateRegister() const override;
};

// 异常/数据 dump 行为与 V4 一致，直接复用 V4 实现。
class CloudV5Exception : public CloudV4Exception {
};

class CloudV5DataDump : public CloudV4DataDump {
};

} // namespace Adx
#endif // ADUMP_COMMON_PLATFORM_CLOUD_V5_PLATFORM_H
