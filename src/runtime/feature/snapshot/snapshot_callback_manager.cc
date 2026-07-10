 /**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "snapshot_callback_manager.hpp"
#include "error_message_manage.hpp"
#include "runtime.hpp"

namespace cce {
namespace runtime {

namespace {
static const char_t* g_snapShotStageStr[] = {
    "RT_SNAPSHOT_LOCK_PRE",
    "RT_SNAPSHOT_BACKUP_PRE",
    "RT_SNAPSHOT_BACKUP_POST",
    "RT_SNAPSHOT_RESTORE_PRE",
    "RT_SNAPSHOT_RESTORE_POST",
    "RT_SNAPSHOT_UNLOCK_POST"
};
}

SnapshotCallbackManager& SnapshotCallbackManager::GetInstance()
{
    static SnapshotCallbackManager instance;
    return instance;
}

const char_t* SnapshotCallbackManager::GetStageString(rtSnapShotStage stage)
{
    if (stage >= RT_SNAPSHOT_LOCK_PRE && stage <= RT_SNAPSHOT_UNLOCK_POST) {
        return g_snapShotStageStr[stage];
    }
    return "UNKNOWN";
}

rtError_t SnapshotCallbackManager::RegisterCallback(rtSnapShotStage stage, rtSnapShotCallBack callback, void *args)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_DESC((stage < RT_SNAPSHOT_LOCK_PRE || stage > RT_SNAPSHOT_UNLOCK_POST),
        RT_ERROR_INVALID_VALUE,
        "Registering the callback function related to snapshot operations",
        stage,
        "[0, " + std::to_string(RT_SNAPSHOT_UNLOCK_POST) + "]");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(callback, RT_ERROR_INVALID_VALUE, "Registering the callback function related to snapshot operations");
    
    const std::unique_lock<std::mutex> lock(mutex_);
    std::list<SnapShotCallBackInfo> &callBackList = callbackMap_[stage];
    const auto &callBackIter = std::find_if(callBackList.begin(),
        callBackList.end(),
        [callback](const SnapShotCallBackInfo &info) { return info.callback == callback; });
    COND_RETURN_AND_MSG_OUTER(callBackIter != callBackList.end(), RT_ERROR_SNAPSHOT_REGISTER_CALLBACK_FAILED, ErrorCode::EE1017,
            "Registering the callback function related to snapshot operations", "callback", "The callback function " + std::to_string(RtPtrToValue(callback)) +
            " has been registered for stage " + std::string(GetStageString(stage)) + " and cannot be registered again");
    callBackList.push_back({callback, args});
    RT_LOG(RT_LOG_EVENT, "register snapshot callback finish, stage:%s, callback=%p.", GetStageString(stage), callback);
    return RT_ERROR_NONE;
}

rtError_t SnapshotCallbackManager::UnregisterCallback(rtSnapShotStage stage, rtSnapShotCallBack callback)
{
    COND_RETURN_AND_MSG_OUTER_WITH_PARAM_DESC((stage < RT_SNAPSHOT_LOCK_PRE || stage > RT_SNAPSHOT_UNLOCK_POST),
        RT_ERROR_INVALID_VALUE,
        "Deregistering the callback function related to snapshot operations",
        stage,
        "[0, " + std::to_string(RT_SNAPSHOT_UNLOCK_POST) + "]");
    NULL_PTR_RETURN_MSG_OUTER_WITH_FUNC_DESC(callback, RT_ERROR_INVALID_VALUE, "Deregistering the callback function related to snapshot operations");
    
    const std::unique_lock<std::mutex> lock(mutex_);
    if (callbackMap_.find(stage) == callbackMap_.end()) {
        RT_LOG_OUTER_MSG_WITH_FUNC_DESC(ErrorCode::EE1017, "Deregistering the callback function related to snapshot operations", "callback",
                "no callback was registered for stage " + std::string(GetStageString(stage)));
        return RT_ERROR_INVALID_VALUE;
    }

    std::list<SnapShotCallBackInfo>& callBackList = callbackMap_[stage];
    const auto &callBackIter = std::find_if(callBackList.begin(),
        callBackList.end(),
        [callback](const SnapShotCallBackInfo &info) { return info.callback == callback; });
    COND_RETURN_AND_MSG_OUTER(callBackIter == callBackList.end(), RT_ERROR_INVALID_VALUE, ErrorCode::EE1017,
            "Deregistering the callback function related to snapshot operations", "callback", "The callback function " + std::to_string(RtPtrToValue(callback)) +
            " has not been registered for stage " + std::string(GetStageString(stage)));
    (void)callBackList.erase(callBackIter);
    RT_LOG(RT_LOG_EVENT, "unregister snapshot callback successfully, stage:%s, callback=%p.", GetStageString(stage), callback);
    return RT_ERROR_NONE;
}

rtError_t SnapshotCallbackManager::InvokeCallbacks(rtSnapShotStage stage)
{
    const std::unique_lock<std::mutex> lock(mutex_);
    const auto& iter = callbackMap_.find(stage);
    if (iter == callbackMap_.end()) {
        RT_LOG(RT_LOG_INFO, "no callback function was registered for this stage, stage:%s.", GetStageString(stage));
        return RT_ERROR_NONE;
    }

    for (const auto& callBackInfo : iter->second) {
        if (callBackInfo.callback == nullptr) {
            continue;
        }

        const rtError_t error = Runtime::Instance()->ProcessForAllOpenDevice(
            [&callBackInfo, stage](Device *dev) -> rtError_t {
                const int32_t devId = static_cast<int32_t>(dev->Id_());
                uint32_t userDeviceId = 0U;
                rtError_t err = Runtime::Instance()->GetUserDevIdByDeviceId(static_cast<uint32_t>(devId), &userDeviceId);
                COND_RETURN_ERROR_MSG_INNER(
                    err != RT_ERROR_NONE, err, "Get userDeviceId failed, error=%#x, drv devId=%u",
                    static_cast<uint32_t>(err), devId);
                err = callBackInfo.callback(userDeviceId, callBackInfo.args);
                COND_RETURN_ERROR_MSG_INNER(
                    err != RT_ERROR_NONE, RT_ERROR_SNAPSHOT_CALLBACK_FAILED,
                    "snapshot call back func execution failed, drv devId=%d, user devId=%u, stage:%s, error=%#x", devId,
                    userDeviceId, GetStageString(stage), static_cast<uint32_t>(err));
                return RT_ERROR_NONE;
            },
            true);
        ERROR_RETURN(error, "Process callback failed for stage %s, error=%#x", GetStageString(stage), static_cast<uint32_t>(error));
    }
    return RT_ERROR_NONE;
}

}
}