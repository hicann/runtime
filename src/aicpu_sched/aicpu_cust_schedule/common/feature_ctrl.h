/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef COMMON_AICPUSD_FEATURE_CTRL_H
#define COMMON_AICPUSD_FEATURE_CTRL_H

#include <cstdint>
#include <atomic>

namespace AicpuSchedule {
// min number of vDeviceId
constexpr const uint32_t VDEVICE_MIN_CPU_NUM = 32U;
// mid number of vDeviceId
constexpr const uint32_t VDEVICE_MID_CPU_NUM = 48U;
// max number of vDeviceId
constexpr const uint32_t VDEVICE_MAX_CPU_NUM = 64U;

class FeatureCtrl {
public:

    static void Init(const int64_t hardwareVersion, const uint32_t deviceId);

    static bool IsDoubleDieProduct();

    static bool IsBindPidByHal();

    static bool IsAosCore();

    static bool ShouldInitDrvThread();

    static bool ShouldSubmitTaskOneByOne();

    static inline bool IsVfMode(const uint32_t deviceId, const uint32_t vfId)
    {
        if ((IsVfModeCheckedByDeviceId(deviceId)) || (vfId > 0)) {
            return true;
        } else {
            return false;
        }
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

    static inline void SetTsMsgVersion(uint16_t version)         
    {
        if (isSetTsMsgVersion_) {
            return;
        }
        tsMsgVersion_ = version;
        isSetTsMsgVersion_ = true;
        return;
    }

    static inline uint16_t GetTsMsgVersion() 
    {
        return tsMsgVersion_;
    }

    static inline void ClearTsMsgVersionInfo() 
    {
        tsMsgVersion_ = 0;
        isSetTsMsgVersion_ = false;
    }

private:
    FeatureCtrl() = default;
    ~FeatureCtrl() = default;

    FeatureCtrl(FeatureCtrl const&) = delete;
    FeatureCtrl& operator=(FeatureCtrl const&) = delete;
    FeatureCtrl(FeatureCtrl&&) = delete;
    FeatureCtrl& operator=(FeatureCtrl&&) = delete;

    static bool aicpuFeatureBindPidByHal_;
    static bool aicpuFeatureDoubleDieProduct_;
    static bool aicpuFeatureInitDrvScheModule_;
    static bool aicpuFeatureSubmitTaskOneByOne_;
    static uint16_t tsMsgVersion_;
    static std::atomic<bool> isSetTsMsgVersion_;
};

} // namespace AicpuSchedule

#endif // COMMON_AICPUSD_FEATURE_CTRL_H
