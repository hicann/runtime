/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "task_fail_callback_data_manager.h"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {

TaskFailCallBackManager &TaskFailCallBackManager::Instance()
{
    static TaskFailCallBackManager taskFailCallBackManager;
    return taskFailCallBackManager;
}

void TaskFailCallBackManager::Notify(rtExceptionInfo_t *const exceptionInfo)
{
    RT_LOG(RT_LOG_INFO,
        "notify  stream_id=%u, task_id=%u, retcode:%u.",
        exceptionInfo->streamid,
        exceptionInfo->taskid,
        exceptionInfo->retcode);
    // Avoid callback function use long time lock,so copy to tmp map to call callback function.
    std::unordered_map<std::string, TaskFailCallbackInfo> notifyMap;
    {
        const std::unique_lock<std::mutex> cbMapLock(mapMutex_);
        notifyMap.insert(callbackMap_.begin(), callbackMap_.end());
    }
    for (const auto &info : notifyMap) {
        RT_LOG(RT_LOG_INFO,
            "notify [%s] task start, notify task_id=%u, stream_id=%u, retcode=%u.",
            info.first.c_str(),
            exceptionInfo->taskid,
            exceptionInfo->streamid,
            exceptionInfo->retcode);
        const TaskFailCallbackType type = info.second.type;
        if ((type == TaskFailCallbackType::RT_SET_TASK_FAIL_CALLBACK) ||
            (type ==TaskFailCallbackType::RT_REG_TASK_FAIL_CALLBACK_BY_MODULE)) {
            auto callback = info.second.callback;
            callback(exceptionInfo);
        } else if (type == TaskFailCallbackType::RTS_SET_TASK_FAIL_CALLBACK) {
            auto callback = info.second.callbackV2;
            void *args = info.second.args;
            callback(exceptionInfo, args);
        } else {
            RT_LOG(RT_LOG_ERROR, "notify task fail type:%u is invalid.", type);
            return;
        }
        RT_LOG(RT_LOG_INFO, "notify [%s] task end.", info.first.c_str());
    }
}

rtError_t TaskFailCallBackManager::RegTaskFailCallback(const char_t *regName, void *callback, void *args,
    TaskFailCallbackType type)
{
    const std::unique_lock<std::mutex> cbMapLock(mapMutex_);
    std::string tmpName(regName);
    if (callback == nullptr) {
        (void)callbackMap_.erase(tmpName);
        RT_LOG(RT_LOG_EVENT, "Unregister task fail callback finish, name:%s.", regName);
        return RT_ERROR_NONE;
    }

    if (type == TaskFailCallbackType::RT_SET_TASK_FAIL_CALLBACK || type == TaskFailCallbackType::RT_REG_TASK_FAIL_CALLBACK_BY_MODULE) {
        callbackMap_[regName].callback = RtPtrToPtr<rtTaskFailCallback>(callback);
        callbackMap_[regName].callbackV2 = nullptr;
        callbackMap_[regName].args = nullptr;
    } else if(type == TaskFailCallbackType::RTS_SET_TASK_FAIL_CALLBACK) {
        COND_RETURN_OUT_ERROR_MSG_CALL(callbackMap_.count(regName) > 0, RT_ERROR_INVALID_VALUE,
            "regName:%s has already been registered.", regName);
        callbackMap_[regName].callback = nullptr;
        callbackMap_[regName].callbackV2 = RtPtrToPtr<rtsTaskFailCallback>(callback);
        callbackMap_[regName].args = args;
    } else {
        RT_LOG(RT_LOG_ERROR, "Register task fail callback type:%u is invalid.", type);
        return RT_ERROR_INVALID_VALUE;
    }

    callbackMap_[regName].type = type;
    RT_LOG(RT_LOG_DEBUG, "Register task fail callback finish, name:%s, type:%u.", regName, type);
    return RT_ERROR_NONE;
}

TaskFailCallBackManager::TaskFailCallBackManager()
{
    RT_LOG(RT_LOG_EVENT, "Constructor.");
}

TaskFailCallBackManager::~TaskFailCallBackManager()
{
    RT_LOG(RT_LOG_EVENT, "Destructor.");
}

}  // namespace runtime
}  // namespace cce
