/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "adx_hdc_device.h"
#include <memory>
#include <vector>
#include "log/adx_log.h"
#include "ascend_hal.h"
#include "adx_dsmi.h"
using AdxDrvStateInfoPt = devdrv_state_info_t *;
namespace Adx {
void AdxHdcDevice::GetAllEnableDevices(int32_t mode, int32_t devId, std::vector<std::string> &devices)
{
    devices.clear();
    std::lock_guard<std::mutex> lk(this->deviceNotifyMtx_);
    if (AdxHdcDevice::NoDevice()) {
        if (mode == 0) {
            std::vector<uint32_t> devLogIds(DEVICE_NUM_MAX, 0);
            uint32_t nums = 0;
            if (IdeGetDevList(&nums, devLogIds, DEVICE_NUM_MAX) == IDE_DAEMON_ERROR) {
                return;
            }
            for (uint32_t i = 0; i < nums && i < DEVICE_NUM_MAX; i++) {
                AdxHdcDevice::InitDevice(std::to_string(devLogIds[i]));
            }
        } else {
            if (!CheckVfId(devId)) {
                return;
            }
            AdxHdcDevice::InitDevice(std::to_string(devId));
        }
    }
    AdxHdcDevice::GetEnableDevices(devices);
}
}