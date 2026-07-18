/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADUMP_COMMON_FEATURES_SUPPORT_INTERFACE_H
#define ADUMP_COMMON_FEATURES_SUPPORT_INTERFACE_H

#include <set>

namespace Adx {

// 大颗粒用户特性能力矩阵。每个平台都注册 FeaturesSupportInterface，通过 supported_ 声明
// 它支持哪些大颗粒特性（即使全平台一致也显式声明）。
enum class AdumpPlatformFeature {
    FEATURE_INVALID = 0,
    FEATURE_DATA_DUMP,         // Data Dump（tensor + stats 合并）
    FEATURE_OVERFLOW_DUMP,     // overflow dump
    FEATURE_EXCEPTION_DUMP_L0, // L0 exception dump
    FEATURE_EXCEPTION_DUMP_L1, // L1 exception dump
    FEATURE_CORE_DUMP,         // coredump（仅 V2/V4）
};

class FeaturesSupportInterface {
public:
    virtual ~FeaturesSupportInterface() = default;

    bool FeatureIsSupport(AdumpPlatformFeature feature) const
    {
        return supported_.count(feature) > 0;
    }

protected:
    std::set<AdumpPlatformFeature> supported_;
};

} // namespace Adx
#endif // ADUMP_COMMON_FEATURES_SUPPORT_INTERFACE_H
