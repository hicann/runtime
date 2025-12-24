/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_ctrl_callback_manager.hpp"
#include "runtime.hpp"
#include "error_message_manage.hpp"
#include "profiling_agent.hpp"

namespace cce {
namespace runtime {
ProfCtrlCallbackManager &ProfCtrlCallbackManager::Instance()
{
    static ProfCtrlCallbackManager instance;
    return instance;
}

void ProfCtrlCallbackManager::SaveProfSwitchData(const rtProfCommandHandle_t * const data, const uint32_t len)
{
    if (len != sizeof(rtProfCommandHandle_t)) {
        RT_LOG(RT_LOG_ERROR, "date len %u is invalid, valid value is %zu", len, sizeof(rtProfCommandHandle_t));
        return;
    }
    if ((data->type != PROF_COMMANDHANDLE_TYPE_STOP) &&
        (data->type != PROF_COMMANDHANDLE_TYPE_FINALIZE) &&
        (data->type != PROF_COMMANDHANDLE_TYPE_MODEL_UNSUBSCRIBE)) {
        switchIsSet_ = true;
        switchData_ = *data;
    } else {
        switchIsSet_ = false;
    }
}

void ProfCtrlCallbackManager::NotifyOneModule(const uint32_t moduleId, const uint32_t dataType, void * const data,
    const uint32_t dataLen)
{
    RT_LOG(RT_LOG_DEBUG, "notify moduleId:%u, dataType:%u, dataLen:%u.", moduleId, dataType, dataLen);
    rtProfCtrlHandle callback = nullptr;
    {
        const std::unique_lock<std::mutex> cbMapLock(mapMutex_);
        const auto iter = callbackMap_.find(moduleId);
        if (iter != callbackMap_.end()) {
            callback = iter->second;
        }
    }
    if (callback != nullptr) {
        callback(dataType, data, dataLen);
        RT_LOG(RT_LOG_DEBUG, "notify moduleId:%u dataType:%u.", moduleId, dataType);
    }
}

void ProfCtrlCallbackManager::NotifyProfInfo(const uint32_t moduleId)
{
    const MsprofReporterCallback rptCallback = ProfilingAgent::Instance().GetMsprofReporterCallback();
    RT_LOG(RT_LOG_DEBUG, "moduleId:%u switchIsSet_:%d.", moduleId, static_cast<int32_t>(switchIsSet_));
    if (rptCallback != nullptr) {
        NotifyOneModule(moduleId, RT_PROF_CTRL_REPORTER, RtPtrToPtr<void *, const MsprofReporterCallback>(rptCallback),
            static_cast<uint32_t>(sizeof(MsprofReporterCallback)));
    }
    if (switchIsSet_) {
        NotifyOneModule(moduleId, RT_PROF_CTRL_SWITCH, &switchData_,
            static_cast<uint32_t>(sizeof(rtProfCommandHandle_t)));
    }
}

rtError_t ProfCtrlCallbackManager::RegProfCtrlCallback(const uint32_t moduleId, const rtProfCtrlHandle callback)
{
    const std::unique_lock<std::mutex> cbMapLock(mapMutex_);
    if (callback == nullptr) {
        (void) callbackMap_.erase(moduleId);
    } else {
        callbackMap_[moduleId] = callback;
    }
    RT_LOG(RT_LOG_DEBUG,
        "%s profiling callback finish, moduleId:%u.",
        ((callback == nullptr) ? "unregister" : "register"),
        moduleId);
    return RT_ERROR_NONE;
}

void ProfCtrlCallbackManager::Notify(const uint32_t dataType, void * const data, const uint32_t dataLen)
{
    RT_LOG(RT_LOG_DEBUG, "notify dataType:%u dataLen:%u.", dataType, dataLen);
    // Avoid callback function use long time lock,so copy to tmp map to call callback function.
    std::map<std::uint32_t, rtProfCtrlHandle> notifyMap;
    {
        const std::unique_lock<std::mutex> cbMapLock(mapMutex_);
        notifyMap.insert(callbackMap_.cbegin(), callbackMap_.cend());
    }
    for (const auto &callback:notifyMap) {
        const uint32_t moduleId = callback.first;
        RT_LOG(RT_LOG_DEBUG, "notify [%u] profiling start.", moduleId);
        callback.second(dataType, data, dataLen);
        RT_LOG(RT_LOG_DEBUG, "notify [%u] profiling end.", moduleId);
    }
}

void ProfCtrlCallbackManager::DelAllData()
{
    RT_LOG(RT_LOG_DEBUG, "delete all map info.");
    const std::unique_lock<std::mutex> cbMapLock(mapMutex_);
    callbackMap_.clear();
}

uint64_t ProfCtrlCallbackManager::GetSwitchData() const
{
    return switchData_.profSwitch;
}
}
}
