/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef COMMON_BQS_FEATURE_CTRL_H
#define COMMON_BQS_FEATURE_CTRL_H
#include "driver/ascend_hal_define.h"
namespace bqs {
const std::string AOSCORE_PREFIX = "sea_";
// min number of vDeviceId
constexpr const uint32_t VDEVICE_MIN_CPU_NUM = 32U;
// mid number of vDeviceId
constexpr const uint32_t VDEVICE_MID_CPU_NUM = 48U;
// max number of vDeviceId
constexpr const uint32_t VDEVICE_MAX_CPU_NUM = 64U;

class FeatureCtrl {
public:
    static inline bool IsAosCore()
    {
#ifdef _AOSCORE_
        return true;
#else
        return false;
#endif
    }

    static inline bool BindCpuOnlyOneDevice()
    {
#ifdef BIND_CPU_ONLY_ONE_DEVICE
        return true;
#else
        return false;
#endif
    }

    static inline bool IsVfModeCheckedByDeviceId(const uint32_t deviceId)
    {
        if ((deviceId >= VDEVICE_MIN_CPU_NUM) && (deviceId < VDEVICE_MAX_CPU_NUM)) {
            return true;
        } else {
            return false;
        }
    }

    static inline bool IsVfModeDie1(const uint32_t deviceId)
    {
        if ((deviceId >= VDEVICE_MID_CPU_NUM) && (deviceId < VDEVICE_MAX_CPU_NUM)) {
            return true;
        } else {
            return false;
        }
    }

    static inline bool IsHostQs()
    {
#ifdef QS_DEPLOY_ON_HOST
        return true;
#else
        return false;
#endif
    }

private:
    FeatureCtrl() = default;
    ~FeatureCtrl() = default;

    FeatureCtrl(FeatureCtrl const&) = delete;
    FeatureCtrl& operator=(FeatureCtrl const&) = delete;
    FeatureCtrl(FeatureCtrl&&) = delete;
    FeatureCtrl& operator=(FeatureCtrl&&) = delete;
};

} // namespace bqs

#endif // COMMON_BQS_FEATURE_CTRL_H
