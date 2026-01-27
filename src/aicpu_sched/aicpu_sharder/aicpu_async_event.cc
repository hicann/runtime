/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpu_async_event.h"
#include <map>
#include <mutex>
#include "aicpu_sharder_log.h"
#include "aicpu_context.h"
#include "driver/ascend_hal.h"
#include "driver/ascend_hal_define.h"

namespace aicpu {
namespace {
struct AsyncEventInfo {
    uint32_t eventId;
    uint32_t subEventId;

    bool operator == (const AsyncEventInfo &info) const
    {
        return (eventId == info.eventId) && (subEventId == info.subEventId);
    }
    friend bool operator < (const AsyncEventInfo &info1, const AsyncEventInfo &info2);
};

inline bool operator < (const AsyncEventInfo &info1, const AsyncEventInfo &info2)
{
    return (info1.eventId < info2.eventId) ||
        ((info1.eventId == info2.eventId) && (info1.subEventId < info2.subEventId));
}

struct AsyncTaskInfo {
    uint64_t startTick;
    std::string opName;
    uint8_t waitType;
    uint32_t waitId;
    uint64_t taskId;
    uint32_t streamId;
    int32_t currentTimes;
    int32_t maxTimes;
    EventProcessCallBack taskCb;
};

std::mutex g_mapMutex;
std::map<AsyncEventInfo, AsyncTaskInfo> g_asyncTaskMap;


struct OpInfo {
    uint64_t taskId;
    uint32_t streamId;
    uint32_t threadIndex;

    bool operator == (const OpInfo &info) const
    {
        return (taskId == info.taskId) && (streamId == info.streamId) && (threadIndex == info.threadIndex);
    }
    friend bool operator < (const OpInfo &info1, const OpInfo &info2);
};

inline bool operator < (const OpInfo &info1, const OpInfo &info2)
{
    if (info1.taskId != info2.taskId) {
        return info1.taskId < info2.taskId;
    }

    if (info1.streamId != info2.streamId) {
        return info1.streamId < info2.streamId;
    }

    if (info1.threadIndex != info2.threadIndex) {
        return info1.threadIndex < info2.threadIndex;
    }
    return false;
}
std::mutex g_opMapMutex;
std::map<AsyncEventInfo, std::map<OpInfo, EventProcessCallBack>> g_opAsyncTaskMap;

bool GenTaskInfoFromCtx(AsyncTaskInfo &taskInfo)
{
    (void)aicpu::GetTaskAndStreamId(taskInfo.taskId, taskInfo.streamId);
    std::string waitIdValue;
    auto status = aicpu::GetThreadLocalCtx(aicpu::CONTEXT_KEY_WAIT_ID, waitIdValue);
    if (status != aicpu::AICPU_ERROR_NONE) {
        AICPUE_LOGE("GetThreadLocalCtx failed, ret=%d, key=%s.", static_cast<int32_t>(status),
                    aicpu::CONTEXT_KEY_WAIT_ID.c_str());
        return false;
    }
    int32_t waitId = 0;
    try {
        waitId = std::stoi(waitIdValue);
    } catch (...) {
        AICPUE_LOGE("Transfer string:%s to waitId failed", waitIdValue.c_str());
        return false;
    }
    taskInfo.waitId = static_cast<uint32_t>(waitId);
    std::string waitTypeValue;
    status = aicpu::GetThreadLocalCtx(aicpu::CONTEXT_KEY_WAIT_TYPE, waitTypeValue);
    if (status != aicpu::AICPU_ERROR_NONE) {
        AICPUE_LOGE("GetThreadLocalCtx failed, ret=%d, key=%s.", static_cast<int32_t>(status),
                    aicpu::CONTEXT_KEY_WAIT_TYPE.c_str());
        return false;
    }
    int32_t waitType = 0;
    try {
        waitType = std::stoi(waitTypeValue);
    } catch (...) {
        AICPUE_LOGE("Transfer string:%s to waitId failed", waitTypeValue.c_str());
        return false;
    }
    taskInfo.waitType = static_cast<uint8_t>(waitType);
    if (&aicpu::aicpuGetProfContext != nullptr) {
        const aicpu::aicpuProfContext_t &aicpuProfCtx = aicpu::aicpuGetProfContext();
        taskInfo.startTick = aicpuProfCtx.tickBeforeRun;
    }
    status = aicpu::GetOpname(aicpu::GetAicpuThreadIndex(), taskInfo.opName);
    if (status != aicpu::AICPU_ERROR_NONE) {
        AICPUE_LOGE("GetOpname failed, ret=%d.", static_cast<int32_t>(status));
        return false;
    }
    return true;
}
}

AsyncEventManager::AsyncEventManager() : notifyFunc_(nullptr) {}

AsyncEventManager::~AsyncEventManager() {}

AsyncEventManager &AsyncEventManager::GetInstance()
{
    static AsyncEventManager asyncEventMgr;
    return asyncEventMgr;
}

void AsyncEventManager::Register(const NotifyFunc &notify)
{
    notifyFunc_ = notify;
}

void AsyncEventManager::NotifyWait(void * const notifyParam, const uint32_t paramLen)
{
    if (notifyFunc_ != nullptr) {
        notifyFunc_(notifyParam, paramLen);
    }
    return;
}

bool AsyncEventManager::RegEventCb(const uint32_t eventId, const uint32_t subEventId, const EventProcessCallBack &cb,
    const int32_t times)
{
    if (cb == nullptr) {
        AICPUE_LOGE("AsyncEventManager RegEventCb failed, cb is nullptr.");
        return false;
    }
    AsyncTaskInfo taskInfo;
    taskInfo.taskCb = cb;
    taskInfo.currentTimes = 0;
    taskInfo.maxTimes = times;
    if (!GenTaskInfoFromCtx(taskInfo)) {
        AICPUE_LOGE("AsyncEventManager GenTaskInfoFromCtx failed.");
        return false;
    }
    AsyncEventInfo info;
    info.eventId = eventId;
    info.subEventId = subEventId;
    {
        const std::unique_lock<std::mutex> lk(g_mapMutex);
        const auto iter = g_asyncTaskMap.find(info);
        if (iter != g_asyncTaskMap.end()) {
            AICPUE_LOGE("AsyncEventManager RegEventCb failed.");
            return false;
        }
        g_asyncTaskMap[info] = taskInfo;
    }

    AICPUE_LOGI("AsyncEventManager RegEventCb success, event_id[%u], subeventId[%u], taskId[%lu],"
                " streamId[%u], waitType[%u], waitId[%u], opName[%s], startTick[%lu].",
                eventId, subEventId, taskInfo.taskId, taskInfo.streamId, static_cast<uint32_t>(taskInfo.waitType),
                taskInfo.waitId, taskInfo.opName.c_str(), taskInfo.startTick);
    return true;
}

void AsyncEventManager::UnregEventCb(const uint32_t eventId, const uint32_t subEventId)
{
    const std::unique_lock<std::mutex> lk(g_mapMutex);
    AsyncEventInfo info;
    info.eventId = eventId;
    info.subEventId = subEventId;
    const auto iter = g_asyncTaskMap.find(info);
    if (iter == g_asyncTaskMap.end()) {
        AICPUE_LOGW("AsyncEventManager pass call UnregEventCb with eventId[%u], subEventId[%u]", eventId, subEventId);
        for (auto& kv : g_asyncTaskMap) {
            AICPUE_LOGI("UnregEventCb show: eventId[%u], subEventId[%u]", kv.first.eventId, kv.first.eventId);
        }
        return;
    }
    (void)g_asyncTaskMap.erase(iter);
    AICPUE_LOGI("AsyncEventManager UnregEventCb success, eventId[%u], subEventId[%u]", eventId, subEventId);
}

void AsyncEventManager::ProcessEvent(const uint32_t eventId, const uint32_t subEventId, void * const param)
{
    AICPUE_LOGI("AsyncEventManager proc eventId = %d, subEventId = %d", eventId, subEventId);
    AsyncEventInfo info;
    info.eventId = eventId;
    info.subEventId = subEventId;
    EventProcessCallBack taskCb = nullptr;
    {
        const std::unique_lock<std::mutex> lk(g_mapMutex);
        const auto iter = g_asyncTaskMap.find(info);
        if (iter == g_asyncTaskMap.end()) {
            AICPUE_LOGW("AsyncEventManager no async task to deal with.");
            return;
        }
        taskCb = iter->second.taskCb;
        iter->second.currentTimes++;
        if ((iter->second.currentTimes >= iter->second.maxTimes) && (iter->second.maxTimes >= 0)) {
            (void)g_asyncTaskMap.erase(iter);
        }
    }
    if (taskCb != nullptr) {
        taskCb(param);
    }
    AICPUE_LOGI("AsyncEventManager proc end!");
    return;
}

bool AsyncEventManager::RegOpEventCb(const uint32_t eventId, const uint32_t subEventId, const EventProcessCallBack &cb)
const {
    if (cb == nullptr) {
        AICPUE_LOGE("AsyncEventManager RegOpEventCb on eventId[%u], subeventId[%u] failed, cb is nullptr.",
            eventId, subEventId);
        return false;
    }
    AsyncEventInfo info = {};
    info.eventId = eventId;
    info.subEventId = subEventId;
    OpInfo opInfo = {};
    (void)aicpu::GetTaskAndStreamId(opInfo.taskId, opInfo.streamId);
    opInfo.threadIndex = aicpu::GetAicpuThreadIndex();
    {
        const std::unique_lock<std::mutex> lk(g_opMapMutex);
        auto &opMap = g_opAsyncTaskMap[info];
        const auto iter = opMap.find(opInfo);
        if (iter != opMap.end()) {
            AICPUE_LOGE("AsyncEventManager RegOpEventCb failed for streamId[%u], taskId[%lu], threadIndex[%u]"
                " has been registered on eventId[%u], subeventId[%u].",
                opInfo.streamId, opInfo.taskId, opInfo.threadIndex, eventId, subEventId);
            return false;
        }
        opMap[opInfo] = cb;
    }

    AICPUE_LOGI("AsyncEventManager RegOpEventCb success, event_id[%u], subeventId[%u], taskId[%lu], streamId[%u],"
                " threadIndex[%u].", eventId, subEventId, opInfo.taskId, opInfo.streamId, opInfo.threadIndex);
    return true;
}

void AsyncEventManager::UnregOpEventCb(const uint32_t eventId, const uint32_t subEventId) const
{
    const std::unique_lock<std::mutex> lk(g_opMapMutex);
    AsyncEventInfo info = {};
    info.eventId = eventId;
    info.subEventId = subEventId;
    auto iter = g_opAsyncTaskMap.find(info);
    if (iter == g_opAsyncTaskMap.end()) {
        AICPUE_LOGW("AsyncEventManager pass call UnregOpEventCb with eventId[%u], subEventId[%u]", eventId, subEventId);
        return;
    }

    OpInfo opInfo = {};
    (void)aicpu::GetTaskAndStreamId(opInfo.taskId, opInfo.streamId);
    opInfo.threadIndex = aicpu::GetAicpuThreadIndex();
    auto &opMap = iter->second;
    const auto opIter = opMap.find(opInfo);
    if (opIter == opMap.end()) {
        AICPUE_LOGW("AsyncEventManager pass call UnregOpEventCb with streamId[%u], taskId[%lu], threadIndex[%u].",
            opInfo.streamId, opInfo.taskId, opInfo.threadIndex);
        return;
    }
    (void)opMap.erase(opIter);
    if (opMap.empty()) {
        (void)g_opAsyncTaskMap.erase(iter);
    }
    AICPUE_LOGI("AsyncEventManager UnregEventCb success, eventId[%u], subEventId[%u], streamId[%u], taskId[%lu],"
                " threadIndex[%u].", eventId, subEventId, opInfo.streamId, opInfo.taskId, opInfo.threadIndex);
}

void AsyncEventManager::ProcessOpEvent(const uint32_t eventId, const uint32_t subEventId, void * const param) const
{
    AICPUE_LOGI("AsyncEventManager ProcessOpEvent eventId = %u, subEventId = %u", eventId, subEventId);
    AsyncEventInfo info = {};
    info.eventId = eventId;
    info.subEventId = subEventId;
    {
        const std::unique_lock<std::mutex> lk(g_opMapMutex);
        const auto iter = g_opAsyncTaskMap.find(info);
        if (iter == g_opAsyncTaskMap.end()) {
            AICPUE_LOGW("AsyncEventManager no async task to deal with.");
            return;
        }
        const auto &opMap = iter->second;
        for (auto &kv : opMap) {
            const auto &opInfo = kv.first;
            EventProcessCallBack taskCb = kv.second;
            AICPUE_LOGI("AsyncEventManager ProcessOpEvent for streamId[%u], taskId[%lu], threadIndex[%u]",
                        opInfo.streamId, opInfo.taskId, opInfo.threadIndex);
            taskCb(param);
        }
    }
    AICPUE_LOGI("AsyncEventManager ProcessOpEvent eventId = %u, subEventId = %u end!", eventId, subEventId);
    return;
}
} // namespace aicpu


void AicpuNotifyWait(void *notifyParam, const uint32_t paramLen)
{
    aicpu::AsyncEventManager::GetInstance().NotifyWait(notifyParam, paramLen);
    return;
}

bool AicpuRegEventCb(const uint32_t eventId, const uint32_t subEventId, const aicpu::EventProcessCallBack &cb)
{
    return aicpu::AsyncEventManager::GetInstance().RegEventCb(eventId, subEventId, cb);
}

bool AicpuRegEventCbWithTimes(const uint32_t eventId, const uint32_t subEventId, const aicpu::EventProcessCallBack &cb,
                              const int32_t times)
{
    return aicpu::AsyncEventManager::GetInstance().RegEventCb(eventId, subEventId, cb, times);
}

void AicpuUnregEventCb(const uint32_t eventId, const uint32_t subEventId)
{
    aicpu::AsyncEventManager::GetInstance().UnregEventCb(eventId, subEventId);
}

bool AicpuRegOpEventCb(const uint32_t eventId, const uint32_t subEventId, const aicpu::EventProcessCallBack &cb)
{
    return aicpu::AsyncEventManager::GetInstance().RegOpEventCb(eventId, subEventId, cb);
}

void AicpuUnregOpEventCb(const uint32_t eventId, const uint32_t subEventId)
{
    aicpu::AsyncEventManager::GetInstance().UnregOpEventCb(eventId, subEventId);
}