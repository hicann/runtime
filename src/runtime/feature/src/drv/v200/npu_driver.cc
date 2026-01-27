/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "driver.hpp"
#include "driver/ascend_hal.h"
#include "npu_driver_base.hpp"
#include "errcode_manage.hpp"

namespace cce {
namespace runtime {
rtError_t GetConnectUbFlagFromDrv(bool &connectUbFlag)
{
    drvError_t drvRet = DRV_ERROR_NONE;
    int64_t hdConnectType = 0;
    drvRet = halGetDeviceInfo(RT_DEV_ZERO, MODULE_TYPE_SYSTEM, INFO_TYPE_HD_CONNECT_TYPE, &hdConnectType);
    if (drvRet != DRV_ERROR_NONE) {
        DRV_ERROR_PROCESS(drvRet, "Call halGetDeviceInfo failed: drvRetCode=%u, module type=%d, info type=%d.",
            static_cast<uint32_t>(drvRet), static_cast<int32_t>(MODULE_TYPE_SYSTEM),
            static_cast<int32_t>(INFO_TYPE_HD_CONNECT_TYPE));
        return RT_GET_DRV_ERRCODE(drvRet);
    }
    connectUbFlag = (hdConnectType == 2 ? true : false); // 2: ub, 0: pcie, 1: hccs
    RT_LOG(RT_LOG_DEBUG, "hdConnectType = %lld, connectUbFlag = %d.", hdConnectType,
        static_cast<int32_t>(connectUbFlag));
    return RT_GET_DRV_ERRCODE(drvRet);
}

rtError_t InitDrvEventThread(const uint32_t deviceId)
{
    UNUSED(deviceId);
    return RT_ERROR_NONE;
}

rtError_t GetDrvSentinelMode(void)
{
    return RT_ERROR_NONE;
}

bool IsOfflineSupportMemType(const rtMemType_t &type)
{
    UNUSED(type);
    return true;
}
}  // namespace runtime
}  // namespace cce
