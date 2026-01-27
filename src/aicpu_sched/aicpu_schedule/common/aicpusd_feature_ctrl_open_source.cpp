/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpusd_feature_ctrl.h"

#include <cstring>
#include "aicpusd_hal_interface_ref.h"
#include "aicpusd_status.h"
#include "aicpusd_common.h"
#define AICPU_PLAT_GET_CHIP(type)           (((type) >> 8U) & 0xffU)
namespace AicpuSchedule {
constexpr uint32_t SOC_VERSION_LEN = 50U;

typedef enum tagChipType {
    CHIP_ASCEND_910A = 1,
    CHIP_ASCEND_910B = 5,
    CHIP_ASCEND_950 = 15,
    CHIP_CLOUD_V5 = 16,
} ChipType_t;

void FeatureCtrl::Init(const int64_t hardwareVersion, const uint32_t deviceId)
{
    const ChipType_t chipType = static_cast<ChipType_t>(AICPU_PLAT_GET_CHIP(static_cast<uint64_t>(hardwareVersion)));
    if (chipType == CHIP_CLOUD_V5) {
        aicpuFeatureUseMsqV2_ = true;
    }

    if ((chipType == CHIP_ASCEND_910A) || (chipType == CHIP_ASCEND_910B) || (chipType == CHIP_ASCEND_950)) {
        aicpuFeatureBindPidByHal_ = true;
    }

    if ((chipType == CHIP_ASCEND_910B) && (&halGetSocVersion != nullptr)) {
        char_t socVersion[SOC_VERSION_LEN] = {};
        const auto drvRet = halGetSocVersion(deviceId, &socVersion[0U], SOC_VERSION_LEN);
        aicpusd_info("socVersion is %s", &socVersion[0U]);
        if ((drvRet == DRV_ERROR_NONE) &&
            (strncmp(&socVersion[0U], "Ascend910_93", strnlen("Ascend910_93", SOC_VERSION_LEN)) == 0)) {
            aicpuFeatureDoubleDieProduct_ = true;
            aicpusd_info("set isDoubleDieProduct_");
        }
    }

    if (chipType == CHIP_ASCEND_910B) {
        aicpuFeatureCheckEventSender_ = true;
    }
}

bool FeatureCtrl::IsAosCore()
{
    return false;
}

bool FeatureCtrl::ShouldAddtocGroup()
{
    return aicpuFeatureAddToCGroup_;
}

bool FeatureCtrl::ShouldSkipSupplyEvent()
{
    return false;
}

bool FeatureCtrl::IsBindPidByHal()
{
    return aicpuFeatureBindPidByHal_;
}

bool FeatureCtrl::IsHeterogeneousProduct()
{
    return false;
}

bool FeatureCtrl::IsNoNeedDumpOpDebugProduct()
{
    return false;
}

bool FeatureCtrl::IsDoubleDieProduct()
{
    return aicpuFeatureDoubleDieProduct_;
}

bool FeatureCtrl::BindCpuOnlyOneDevice()
{
    return false;
}

bool FeatureCtrl::LoadKernelSo()
{
    return true;
}

bool FeatureCtrl::IfCheckEventSender()
{
    return aicpuFeatureCheckEventSender_;
}

bool FeatureCtrl::IsUseMsqV2()
{
    return aicpuFeatureUseMsqV2_;
}

bool FeatureCtrl::ShouldInitDrvThread()
{
    return aicpuFeatureInitDrvScheModule_;
}

bool FeatureCtrl::ShouldLoadExtendKernelSo()
{
    return aicpuFeatureLoadExtendKernelSo_;
}

bool FeatureCtrl::ShouldSubmitTaskOneByOne()
{
    return aicpuFeatureSubmitTaskOneByOne_;
}

bool FeatureCtrl::ShouldMonitorWork()
{
    return aicpuFeatureMonitorWork_;
}

bool FeatureCtrl::ShouldSetModuleNullData()
{
    return aicpuFeatureSetModelNullData_;
}

} // namespace AicpuSchedule

