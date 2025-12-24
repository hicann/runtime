/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_DEVICE_STATE_CALLBACK_MANAGER_HPP
#define CCE_RUNTIME_DEVICE_STATE_CALLBACK_MANAGER_HPP

#include <unordered_map>
#include "base.hpp"
#include "runtime.hpp"

namespace cce {
namespace runtime {
class DeviceStateCallbackManager {

struct DeviceStateCallbackInfo{
    DeviceStateCallback     type;
    rtDeviceStateCallback   callback;
    rtsDeviceStateCallback  callbackV2;
    void                    *args;
    rtDevCallBackDir_t      notifyPos;
};

public:
    static DeviceStateCallbackManager &Instance();

    rtError_t RegDeviceStateCallback(const char_t *regName, void *callback, void *args,
        DeviceStateCallback type, rtDevCallBackDir_t notifyPos = DEV_CB_POS_BACK);

    void Notify(const uint32_t deviceId, const bool isOpen, const rtDevCallBackDir_t notifyPos, rtDeviceState deviceState);
    void ProfNotify(const uint32_t deviceId, const bool isOpen) const;

private:
    DeviceStateCallbackManager() = default;

    ~DeviceStateCallbackManager() = default;

    DeviceStateCallbackManager(const DeviceStateCallbackManager &other) = delete;

    DeviceStateCallbackManager &operator=(const DeviceStateCallbackManager &other) = delete;

    DeviceStateCallbackManager(DeviceStateCallbackManager &&other) = delete;

    DeviceStateCallbackManager &operator=(DeviceStateCallbackManager &&other) = delete;

private:
    std::unordered_map<std::string, DeviceStateCallbackInfo> callbackMap_;
    std::mutex mapMutex_;
};

}
}

#endif // CCE_RUNTIME_DEVICE_STATE_CALLBACK_MANAGER_HPP
