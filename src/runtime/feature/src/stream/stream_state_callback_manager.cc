/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "stream_state_callback_manager.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
StreamStateCallbackManager &StreamStateCallbackManager::Instance()
{
    static StreamStateCallbackManager insManager;
    return insManager;
}

rtError_t StreamStateCallbackManager::RegStreamStateCallback(const char_t *regName,
    void *callback, void *args, StreamStateCallback type)
{
    const std::unique_lock<std::mutex> cbMapLock(mapMutex_);
    if (callback == nullptr) {
        (void)callbackMap_.erase(regName);
        RT_LOG(RT_LOG_DEBUG, "unregister stream state callback finish, name:%s.", regName);
        return RT_ERROR_NONE;
    }

    if (type == StreamStateCallback::RT_STREAM_STATE_CALLBACK) {
        callbackMap_[regName].callback = RtPtrToPtr<rtStreamStateCallback>(callback);
        callbackMap_[regName].callbackV2 = nullptr;
        callbackMap_[regName].args = nullptr;
    } else if(type == StreamStateCallback::RTS_STREAM_STATE_CALLBACK) {
        COND_RETURN_OUT_ERROR_MSG_CALL(callbackMap_.count(regName) > 0, RT_ERROR_INVALID_VALUE,
            "regName:%s has already been registered.", regName);
        callbackMap_[regName].callback = nullptr;
        callbackMap_[regName].callbackV2 = RtPtrToPtr<rtsStreamStateCallback>(callback);
        callbackMap_[regName].args = args;
    } else {
        RT_LOG(RT_LOG_ERROR, "register stream state type:%u is invalid.", type);
        return RT_ERROR_INVALID_VALUE;
    }

    callbackMap_[regName].type = type;
    RT_LOG(RT_LOG_DEBUG, "register stream state callback finish, name:%s, type:%u.", regName, type);

    return RT_ERROR_NONE;
}

void StreamStateCallbackManager::Notify(Stream * const stm, const bool isCreate)
{
    if (stm == nullptr) {
        RT_LOG(RT_LOG_WARNING, "stream is null");
        return;
    }
    RT_LOG(RT_LOG_DEBUG, "notify stream_id=%d.", stm->Id_());

    // Avoid callback function use long time lock, so copy to tmp map to call callback function.
    std::map<std::string, StreamStateCallbackInfo> notifyMap;
    {
        const std::unique_lock<std::mutex> cbMapLock(mapMutex_);
        if (callbackMap_.empty()) {
            RT_LOG(RT_LOG_INFO, "No stream state callback function registered!");
            return;
        }
        notifyMap.insert(callbackMap_.cbegin(), callbackMap_.cend());
    }
    rtStream_t stream = static_cast<rtStream_t>(stm);
    for (const auto &info : notifyMap) {
        RT_LOG(RT_LOG_DEBUG, "notify [%s] stream state start.", info.first.c_str());
        const StreamStateCallback type = info.second.type;
        if (type == StreamStateCallback::RT_STREAM_STATE_CALLBACK) {
            auto callback = info.second.callback;
            callback(stream, isCreate);
        } else if (type == StreamStateCallback::RTS_STREAM_STATE_CALLBACK) {
            auto callback = info.second.callbackV2;
            void *args = info.second.args;
            if (isCreate){
                callback(stream, RT_STREAM_STATE_CREATE_POST, args);
            } else {
                callback(stream, RT_STREAM_STATE_DESTROY_PRE, args);
            }
        } else {
            RT_LOG(RT_LOG_ERROR, "notify stream state type:%u is invalid.", type);
            return;
        }
        RT_LOG(RT_LOG_DEBUG, "notify [%s] stream state end.", info.first.c_str());
    }
}
}
}