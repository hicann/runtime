/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADX_DEVICE_H
#define ADX_DEVICE_H
#include <vector>
#include <map>
#include <string>
namespace Adx {
enum class DeviceState {
    NO_DEVICE_STATE,
    ENABLE_STATE,
    DISABLE_STATE,
};

class AdxDevice {
public:
    virtual ~AdxDevice() {}
    virtual void GetAllEnableDevices(int32_t mode, int32_t devId, std::vector<std::string> &devices) = 0;
    void EnableNotify(const std::string &devId);
    void DisableNotify(const std::string &devId);
    void GetEnableDevices(std::vector<std::string> &devices) const;
    void GetDisableDevices(std::vector<std::string> &devices) const;
    bool NoDevice() const;
    void InitDevice(const std::string &devId);
private:
    std::map<std::string, DeviceState> devices_;
};
}
#endif

