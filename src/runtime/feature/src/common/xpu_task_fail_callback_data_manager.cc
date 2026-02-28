/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "xpu_task_fail_callback_data_manager.h"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {

XpuTaskFailCallBackManager &XpuTaskFailCallBackManager::Instance()
{
    static XpuTaskFailCallBackManager xpuTaskFailCallBackManager;
    return xpuTaskFailCallBackManager;
}

void XpuTaskFailCallBackManager::XpuNotify(rtExceptionInfo_t *const exceptionInfo)
{
    RT_LOG(RT_LOG_INFO,
        "XpuNotify stream_id=%u, task_id=%u, retcode=%u, tid=%u, deviceId=%u.",
        exceptionInfo->streamid, exceptionInfo->taskid, exceptionInfo->retcode, exceptionInfo->tid, exceptionInfo->deviceid);

    // Avoid callback function use long time lock,so copy to tmp map to call callback function.
    std::unordered_map<std::string, rtTaskFailCallback> notifyMap;
    {
        const std::unique_lock<std::mutex> cbMapLock(mapMutex_);
        notifyMap.insert(callbackMap_.begin(), callbackMap_.end());
    }
    RT_LOG(RT_LOG_INFO, "XpuNotify notifyMap map size: [%u].", notifyMap.size());
    for (const auto &info : notifyMap) {
            auto callback = info.second;
            callback(exceptionInfo);
        RT_LOG(RT_LOG_DEBUG, "XpuNotify [%s] task end.", info.first.c_str());
    }
}

rtError_t XpuTaskFailCallBackManager::RegXpuTaskFailCallback(const char_t *regName, void *callback)
{
    const std::unique_lock<std::mutex> cbMapLock(mapMutex_);
    std::string tmpName(regName);
    if (callback == nullptr) {
        (void)callbackMap_.erase(tmpName);
        RT_LOG(RT_LOG_EVENT, "Unregister XpuTaskFailCallback finish, name:%s.", regName);
        return RT_ERROR_NONE;
    }
    callbackMap_[regName] = RtPtrToPtr<rtTaskFailCallback>(callback);
    RT_LOG(RT_LOG_DEBUG, "Register XpuTaskFailCallback finish, name:%s.", regName);
    return RT_ERROR_NONE;
}

XpuTaskFailCallBackManager::XpuTaskFailCallBackManager()
{
    RT_LOG(RT_LOG_EVENT, "XpuTaskFailCallBackManager Constructor.");
}

XpuTaskFailCallBackManager::~XpuTaskFailCallBackManager()
{
    RT_LOG(RT_LOG_EVENT, "XpuTaskFailCallBackManager Destructor.");
}

}
}