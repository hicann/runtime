/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "device_state_callback_manager.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
DeviceStateCallbackManager &DeviceStateCallbackManager::Instance()
{
    static DeviceStateCallbackManager insManager;
    return insManager;
}

rtError_t DeviceStateCallbackManager::RegDeviceStateCallback(const char_t *regName, void *callback, void *args,
    DeviceStateCallback type, rtDevCallBackDir_t notifyPos)
{
    const std::unique_lock<std::mutex> cbMapLock(mapMutex_);
    std::string tmpName(regName);
    if (callback == nullptr) {
        (void) callbackMap_.erase(tmpName);
        RT_LOG(RT_LOG_DEBUG, "unregister device state callback finish, name:%s.", regName);
        return RT_ERROR_NONE;
    }

    if (type == DeviceStateCallback::RT_DEVICE_STATE_CALLBACK) {
        callbackMap_[regName].callback = RtPtrToPtr<rtDeviceStateCallback>(callback);
        callbackMap_[regName].callbackV2 = nullptr;
        callbackMap_[regName].args = nullptr;
        callbackMap_[regName].notifyPos = notifyPos;
    } else if(type == DeviceStateCallback::RTS_DEVICE_STATE_CALLBACK) {
        COND_RETURN_OUT_ERROR_MSG_CALL(callbackMap_.count(regName) > 0, RT_ERROR_INVALID_VALUE,
            "regName:%s has already been registered.", regName);
        callbackMap_[regName].callback = nullptr;
        callbackMap_[regName].callbackV2 = RtPtrToPtr<rtsDeviceStateCallback>(callback);
        callbackMap_[regName].args = args;
        callbackMap_[regName].notifyPos = DEV_CB_POS_END;
    } else {
        RT_LOG(RT_LOG_ERROR, "register device state type:%u is invalid.", type);
        return RT_ERROR_INVALID_VALUE;
    }

    callbackMap_[regName].type = type;
    RT_LOG(RT_LOG_DEBUG, "register device state callback finish, name:%s, notifyPos:%d, type:%u.", regName, notifyPos, type);
    return RT_ERROR_NONE;
}

void DeviceStateCallbackManager::ProfNotify(const uint32_t deviceId, const bool isOpen) const
{
    RT_LOG(RT_LOG_DEBUG, "notify device:%u isOpen:%d.", deviceId, isOpen);
    const auto profRet = MsprofNotifySetDevice(0, deviceId, isOpen);
    if (profRet != MSPROF_ERROR_NONE) {
        RT_LOG(RT_LOG_WARNING, "MsprofNotifySetDevice maybe profiling is closed, ret = %u", profRet);
    }
}

void DeviceStateCallbackManager::Notify(const uint32_t deviceId, const bool isOpen, const rtDevCallBackDir_t notifyPos,
    rtDeviceState deviceState)
{
    std::string isOpenStr;
    if (isOpen) {
        isOpenStr = "true";
    } else {
        isOpenStr = "false";
    }
    RT_LOG(RT_LOG_DEBUG, "notify device:%u isOpen:%s, notifyPos=%d.", deviceId, isOpenStr.c_str(), notifyPos);
    if (notifyPos == DEV_CB_POS_BACK) {
        const auto profRet = MsprofNotifySetDevice(0, deviceId, isOpen);
        if (profRet != MSPROF_ERROR_NONE) {
            RT_LOG(RT_LOG_WARNING, "MsprofNotifySetDevice maybe profiling is closed, ret = %#x", static_cast<uint32_t>(profRet));
        }
    }
    uint32_t userDeviceId = 0U;
    const rtError_t error = Runtime::Instance()->GetUserDevIdByDeviceId(deviceId, &userDeviceId);
    COND_RETURN_VOID(error != RT_ERROR_NONE, "Get logicDeviceId:%u failed, err:%#x",
        deviceId, static_cast<uint32_t>(error));

    // Avoid callback function use long time lock,so copy to tmp map to call callback function.
    std::unordered_map<std::string, DeviceStateCallbackInfo> notifyMap;
    {
        const std::unique_lock<std::mutex> cbMapLock(mapMutex_);
        notifyMap.insert(callbackMap_.cbegin(), callbackMap_.cend());
    }
    for (const auto &info:notifyMap) {
        RT_LOG(RT_LOG_DEBUG, "notify [%s] device state start.", info.first.c_str());
        const DeviceStateCallback type = info.second.type;
        if (type == DeviceStateCallback::RT_DEVICE_STATE_CALLBACK) {
            if ((notifyPos != info.second.notifyPos) || (deviceState == RT_DEVICE_STATE_RESET_POST)) {
                continue;
            }
            auto callback = info.second.callback;
            callback(userDeviceId, isOpen);
        } else if (type == DeviceStateCallback::RTS_DEVICE_STATE_CALLBACK) {
            auto callback = info.second.callbackV2;
            void *args = info.second.args;
            callback(userDeviceId, deviceState, args);
        } else {
            RT_LOG(RT_LOG_ERROR, "notify device state type:%u is invalid.", type);
            return;
        }
        RT_LOG(RT_LOG_DEBUG, "notify [%s] device state end.", info.first.c_str());
    }
}
}
}
