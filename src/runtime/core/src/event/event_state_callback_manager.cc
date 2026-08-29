/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "event_state_callback_manager.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
EventStateCallbackManager& EventStateCallbackManager::Instance()
{
    static EventStateCallbackManager insEventStateCallbackManager;
    return insEventStateCallbackManager;
}

rtError_t EventStateCallbackManager::RegEventStateCallback(
    const char_t* regName, void* callback, void* args, EventStateCallbackType cbType)
{
    const std::unique_lock<std::mutex> cbMapLock(mapMutex_);
    std::string tmpName(regName);
    if (callback == nullptr) {
        (void)callbackMap_.erase(tmpName);
        RT_LOG(RT_LOG_DEBUG, "Unregister event state callback finish, name:%s.", regName);
        return RT_ERROR_NONE;
    }

    if (cbType != EventStateCallbackType::RT_EVENT_STATE_CALLBACK) {
        RT_LOG(RT_LOG_ERROR, "Register event state cbType=UNKNOWN(%u) is invalid.", static_cast<uint32_t>(cbType));
        return RT_ERROR_INVALID_VALUE;
    }
    callbackMap_[regName].callback = RtPtrToPtr<rtEventStateCallback>(callback);
    callbackMap_[regName].args = args;
    callbackMap_[regName].type = cbType;
    RT_LOG(RT_LOG_DEBUG, "Register event state callback finish, name:%s, cbType:%u.", regName, cbType);
    return RT_ERROR_NONE;
}

void EventStateCallbackManager::Notify(Stream* stream, Event* event, EventStatePeriod period)
{
    RT_LOG(RT_LOG_DEBUG, "Notify event:%u.", period);

    // Avoid callback function use long time lock,so copy to tmp map to call callback function.
    std::unordered_map<std::string, EventStateCallbackInfo> notifyMap;
    {
        const std::unique_lock<std::mutex> cbMapLock(mapMutex_);
        notifyMap.insert(callbackMap_.cbegin(), callbackMap_.cend());
    }
    for (const auto& info : notifyMap) {
        RT_LOG(RT_LOG_DEBUG, "Notify [%s] event state start.", info.first.c_str());
        const EventStateCallbackType cbType = info.second.type;
        if (cbType == EventStateCallbackType::RT_EVENT_STATE_CALLBACK) {
            auto callback = info.second.callback;
            void* args = info.second.args;
            callback(stream, event, period, args);
        } else {
            // If cbType is invalid, stop notifying remaining callbacks immediately.
            RT_LOG(RT_LOG_ERROR, "Notify event state type=UNKNOWN(%u) is invalid.", static_cast<uint32_t>(cbType));
            return;
        }
        RT_LOG(RT_LOG_DEBUG, "Notify [%s] event state end.", info.first.c_str());
    }
}
} // namespace runtime
} // namespace cce
