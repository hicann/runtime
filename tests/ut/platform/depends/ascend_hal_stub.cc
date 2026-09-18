/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstdio>
#include "securec.h"
#include "driver/ascend_hal_base.h"

extern "C" {

drvError_t drvGetDevIDs(uint32_t* devices, uint32_t len)
{
    if (devices == nullptr || len < 2) {
        return DRV_ERROR_INVALID_VALUE;
    }
    devices[0] = 0;
    devices[1] = 0xFFFFFFFF;
    return DRV_ERROR_NONE;
}

drvError_t halGetSocVersion(uint32_t devId, char* socVersion, uint32_t len)
{
    (void)devId;
    const char* kStubSoc = "Ascend960PR_8399";
    if (socVersion == nullptr || len < 16) {
        return DRV_ERROR_INVALID_VALUE;
    }
    (void)sprintf_s(socVersion, len, "%s", kStubSoc);
    return DRV_ERROR_NONE;
}

drvError_t halGetDeviceInfo(uint32_t devId, int32_t moduleType, int32_t infoType, int64_t* value)
{
    (void)devId;
    if (value == nullptr) {
        return DRV_ERROR_INVALID_VALUE;
    }
    if (moduleType == static_cast<int32_t>(MODULE_TYPE_AICORE) &&
        infoType == static_cast<int32_t>(INFO_TYPE_CORE_NUM)) {
        *value = 32;
        return DRV_ERROR_NONE;
    }
    if (moduleType == static_cast<int32_t>(MODULE_TYPE_AICPU) && infoType == static_cast<int32_t>(INFO_TYPE_CORE_NUM)) {
        *value = 8;
        return DRV_ERROR_NONE;
    }
    return DRV_ERROR_NOT_SUPPORT;
}

} // extern "C"
