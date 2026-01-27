/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "queue_schedule_feature_ctrl.h"

namespace bqs {
    typedef enum tagChipType {
        CHIP_ASCEND_910A = 1,
        CHIP_ASCEND_910B = 5,
        CHIP_ASCEND_950 = 15,
        CHIP_CLOUD_V5 = 16,
    } ChipType_t;

    bool QSFeatureCtrl::IsSupportSetVisibleDevices(int64_t chip) {
        ChipType_t g_chipType = static_cast<ChipType_t>(chip);
        switch (g_chipType) {
            case CHIP_ASCEND_910A:
            case CHIP_ASCEND_910B:
            case CHIP_ASCEND_950:
                return true;
            default:
                return false;
        }
    }

    bool QSFeatureCtrl::ShouldSetThreadFIFO(uint32_t deviceId) {
        return false;
    }

    bool QSFeatureCtrl::ShouldAddToCGroup(uint32_t deviceId) {
        return true;
    }

    bool QSFeatureCtrl::UseErrorLogThreshold(uint32_t deviceId) {
        return false;
    }

    bool QSFeatureCtrl::ShouldDisableRecvRequestEvent(uint32_t deviceId) {
        return false;
    }

    bool QSFeatureCtrl::ShouldSetPidPriority(uint32_t deviceId) {
        return false;
    }
}