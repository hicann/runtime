/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <string>
#include "adx_device.h"
#include "log/adx_log.h"
namespace Adx {
void AdxDevice::EnableNotify(const std::string &devId)
{
    auto it = devices_.find(devId);
    if (it != devices_.end() && it->second != DeviceState::ENABLE_STATE) {
        IDE_LOGI("device %s going up.", devId.c_str());
        devices_[devId] = DeviceState::ENABLE_STATE;
    }
}

void AdxDevice::DisableNotify(const std::string &devId)
{
    auto it = devices_.find(devId);
    if (it != devices_.end() && it->second != DeviceState::DISABLE_STATE) {
        IDE_LOGI("device %s going suspend.", devId.c_str());
        devices_[devId] = DeviceState::DISABLE_STATE;
    }
}

void AdxDevice::GetEnableDevices(std::vector<std::string> &devices) const
{
    auto it = devices_.begin();
    for (; it != devices_.end(); it++) {
        if (it->second == DeviceState::ENABLE_STATE) {
            devices.push_back(it->first);
        }
    }
}

void AdxDevice::GetDisableDevices(std::vector<std::string> &devices) const
{
    devices.clear();
    auto it = devices_.begin();
    for (; it != devices_.end(); it++) {
        if (it->second == DeviceState::DISABLE_STATE) {
            devices.push_back(it->first);
        }
    }
}

bool AdxDevice::NoDevice() const
{
    return devices_.empty();
}

void AdxDevice::InitDevice(const std::string &devId)
{
    auto it = devices_.find(devId);
    if (it == devices_.end()) {
        devices_[devId] = DeviceState::ENABLE_STATE;
    }
}
}
