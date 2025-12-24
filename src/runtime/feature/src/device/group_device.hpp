/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_GROUP_DEVICE_HPP
#define CCE_RUNTIME_GROUP_DEVICE_HPP

#include "device.hpp"

namespace cce {
namespace runtime {
constexpr uint8_t UNINIT_GROUP_ID = 255U;
class GroupDevice : public Device {
public:
    uint8_t GetGroupId() const override
    {
        return groupId_;
    }

    uint32_t GetPoolId() const override
    {
        return poolId_;
    }
 
    uint32_t GetPoolIdMax() const override
    {
        return poolIdMax_;
    }

    uint32_t GetVfId() const override
    {
        return vfId_;
    }

    rtError_t SetGroup(const int32_t grpId) override;
    rtError_t ResetGroup() override;

    rtError_t GroupInfoSetup() override;

    rtError_t GetGroupInfo(const int32_t grpId, rtGroupInfo_t * const info, const uint32_t cnt) override;

    rtError_t GetGroupCount(uint32_t * const cnt) override;

    int32_t DefaultGroup() const override
    {
        return defaultGroup_;
    }

    rtFloatOverflowMode_t GetSatMode() const override
    {
        return satMode_;
    }

    void SetSatMode(rtFloatOverflowMode_t floatOverflowMode) override
    {
        satMode_ = floatOverflowMode;
    }

    void SetMonitorExitFlag(const bool value) override
    {
        monitorExitFlag_ = value;
    }

    bool GetMonitorExitFlag(void) override
    {
        return monitorExitFlag_;
    }

    void SetHasTaskError(const bool value) override
    {
        isHasTaskError_ = value;
    }

    bool GetHasTaskError(void) override
    {
        return isHasTaskError_;
    }

    void SetAtraceHandle(TraHandle handle) override
    {
        runtimeAtrace_ = handle;
    }
    TraHandle GetAtraceHandle(void) const override
    {
        return runtimeAtrace_;
    }

    void SetAtraceEventHandle(TraEventHandle handle) override
    {
        runtimeAtraceEventHandle_ = handle;
    }

    TraEventHandle GetAtraceEventHandle(void) const override
    {
        return runtimeAtraceEventHandle_;
    }

    void SetDeviceRas(const bool value) override
    {
        isHasHbmRas_ = value;
    }

    bool GetDeviceRas(void) const override
    {
        return isHasHbmRas_;
    }

private:
    rtError_t FillCache(struct capability_group_info capGroupInfos[], const uint32_t groupCount);
    rtError_t QueryGroupInfo();
    uint8_t groupId_ = UNINIT_GROUP_ID;
    int32_t defaultGroup_ = -1;
    std::map<int32_t, rtGroupInfo_t> groupInfoCache_;
    rtFloatOverflowMode_t satMode_ = RT_OVERFLOW_MODE_SATURATION;
    bool isFirstQryGrpInfo_ = true;
    std::mutex isFirstQryGrpInfoMux_;
    std::atomic<bool> monitorExitFlag_{false};
    std::atomic<bool> isHasTaskError_{false};
    std::atomic<bool> isHasHbmRas_{false};
    TraHandle runtimeAtrace_{-1};
    TraEventHandle runtimeAtraceEventHandle_{-1};
    uint8_t lastGroupId_ = UNINIT_GROUP_ID;
    uint32_t lastVfId_ = UINT32_MAX; // UINT32_MAX stands for physical machine
    uint32_t lastPoolId_ = 0U;
    uint32_t lastPoolIdMax_ = 0U;
    uint32_t vfId_ = UINT32_MAX; // UINT32_MAX stands for physical machine
    uint32_t poolId_ = 0U;
    uint32_t poolIdMax_ = 0U;
};
}
}
#endif // CCE_RUNTIME_GROUP_DEVICE_HPP