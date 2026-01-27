/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "aicpu_context.h"

#include <map>
#include <memory>
#include <mutex>
#include <thread>
#include <vector>
#include <atomic>
#include "driver/ascend_hal_define.h"
#include "aicpu_sharder_log.h"

namespace {
// current thread context
thread_local aicpu::aicpuContext_t g_curCtx;
// current thread prof context
thread_local aicpu::aicpuProfContext_t g_curProfCtx;
// task moniter context
std::unique_ptr<std::string[]> g_opsname(nullptr);
thread_local uint32_t g_threadIndex = UINT32_MAX;
uint32_t g_aicpuCoreCnt = 0U;
thread_local std::map<std::string, std::string> g_threadLocalAicpuCtx;
thread_local aicpu::streamAndTaskId_t g_streamAndTaskId;
thread_local uint32_t g_blockIdx = 0U;
thread_local uint32_t g_blockNum = 0U;
// aicpu run mode
uint32_t g_runMode = static_cast<uint32_t>(aicpu::AicpuRunMode::THREAD_MODE);
// uniqueVfId
std::atomic<uint32_t> g_uniqueVfId;
bool g_isCustAicpuSd = false;
std::mutex g_sqeIdMtx;
constexpr uint32_t INITIAL_SQE_IQ = 0x80000000U;
uint32_t g_sqeId = INITIAL_SQE_IQ;

// context info
std::mutex g_defaultMutex;
std::vector<std::map<std::string, std::string>> g_defaultThreadCtx;
std::mutex g_profMutex;
std::vector<std::map<std::string, std::string>> g_profThreadCtx;
std::mutex g_debugMutex;
std::vector<std::map<std::string, std::string>> g_debugThreadCtx;
std::mutex g_funcMapMutex;
std::map<uint32_t, std::map<uint32_t, std::pair<std::function<void(void *)>, bool>>> g_funcMap;

std::map<std::string, std::string> &GetThreadCtx(const aicpu::CtxType type, const uint32_t threadIndex)
{
    const size_t thredId = static_cast<size_t>(threadIndex);
    if (type == aicpu::CTX_DEBUG) {
        const std::unique_lock<std::mutex> locker(g_defaultMutex);
        if (thredId >= g_debugThreadCtx.size()) {
            g_debugThreadCtx.resize(thredId + static_cast<size_t>(1));
        }
        return g_debugThreadCtx[thredId];
    } else if (type == aicpu::CTX_PROF) {
        const std::unique_lock<std::mutex> locker(g_profMutex);
        if (thredId >= g_profThreadCtx.size()) {
            g_profThreadCtx.resize(thredId + static_cast<size_t>(1));
        }
        return g_profThreadCtx[thredId];
    } else {
        const std::unique_lock<std::mutex> locker(g_debugMutex);
        if (thredId >= g_defaultThreadCtx.size()) {
            g_defaultThreadCtx.resize(thredId + static_cast<size_t>(1));
        }
        return g_defaultThreadCtx[thredId];
    }
}
} // namespace

namespace aicpu {
__attribute__((visibility("default"))) status_t aicpuSetContext(aicpuContext_t *ctx)
{
    g_curCtx = *ctx;
    return AICPU_ERROR_NONE;
}

__attribute__((visibility("default"))) status_t aicpuGetContext(aicpuContext_t *ctx)
{
    *ctx = g_curCtx;
    return AICPU_ERROR_NONE;
}

void GetSqeId(const uint32_t num, uint32_t &start, uint32_t &end)
{
    std::lock_guard<std::mutex> lk(g_sqeIdMtx);
    start = g_sqeId;
    g_sqeId += num;
    end = g_sqeId;
    if (start >= end) {
        g_sqeId = INITIAL_SQE_IQ;
        start = g_sqeId;
        g_sqeId += num;
        end = g_sqeId;
        if (start >= end) {
            // Num reached  the maximum.
            AICPUE_LOGW("The num[%u] exceeds the maximum number that can be applied for.", num);
            g_sqeId = INITIAL_SQE_IQ;
            return;
        }
        AICPUE_LOGW("The num[%u] exceeds the max, start will begin form initial value.", num);
    }
    return;
}

status_t aicpuSetProfContext(const aicpuProfContext_t &ctx)
{
    g_curProfCtx = ctx;
    return AICPU_ERROR_NONE;
}

const aicpuProfContext_t &aicpuGetProfContext()
{
    return g_curProfCtx;
}

status_t InitTaskMonitorContext(uint32_t aicpuCoreCnt)
{
    if (aicpuCoreCnt == 0U) {
        AICPUE_LOGE("invalid aicpu core count[%u]", aicpuCoreCnt);
        return AICPU_ERROR_FAILED;
    }
    g_aicpuCoreCnt = aicpuCoreCnt;
    AICPUE_LOGI("aicpu core count[%u]", aicpuCoreCnt);
    g_opsname.reset(new (std::nothrow) std::string[aicpuCoreCnt]);
    if (g_opsname == nullptr) {
        AICPUE_LOGE("malloc ops name momery for task monitor failed");
        return AICPU_ERROR_FAILED;
    }
    for (uint32_t idx = 0U; idx < aicpuCoreCnt; ++idx) {
        g_opsname[static_cast<size_t>(idx)] = "null";
    }
    return AICPU_ERROR_NONE;
}

status_t SetAicpuThreadIndex(uint32_t threadIndex)
{
    g_threadIndex = threadIndex;
    return AICPU_ERROR_NONE;
}

uint32_t GetAicpuThreadIndex()
{
    return g_threadIndex;
}

status_t SetOpname(const std::string &opname)
{
    if ((g_opsname != nullptr) && (g_threadIndex < g_aicpuCoreCnt)) {
        AICPUE_LOGI("set op name to %s for thread[%u]", opname.c_str(), g_threadIndex);
        g_opsname[static_cast<size_t>(g_threadIndex)] = opname;
        return AICPU_ERROR_NONE;
    }
    // maintenance function, if failed just print event log
    AICPUE_RUN_LOGW("set op name[%s] failed, thread index[%u] should be less than total aicpu core count[%u],"
        " and ops name array addr cannot null", opname.c_str(), g_threadIndex, g_aicpuCoreCnt);
    return AICPU_ERROR_NONE;
}

status_t GetOpname(uint32_t threadIndex, std::string &opname)
{
    if ((g_opsname != nullptr) && (threadIndex < g_aicpuCoreCnt)) {
        opname = g_opsname[static_cast<size_t>(threadIndex)];
        return AICPU_ERROR_NONE;
    }
    opname = "null";
    // maintenance function, if failed just print event log
    AICPUE_RUN_LOGW("get op name failed, thread index[%u] should be less than total aicpu core count[%u],"
        " and ops name array addr cannot null", g_threadIndex, g_aicpuCoreCnt);
    return AICPU_ERROR_NONE;
}

status_t SetTaskAndStreamId(uint64_t taskId, uint32_t streamId)
{
    g_streamAndTaskId.taskId = taskId;
    g_streamAndTaskId.streamId = streamId;
    AICPUE_LOGI("Set taskId:[%lu] and streamId:[%u] success.", taskId, streamId);
    return AICPU_ERROR_NONE;
}

status_t GetTaskAndStreamId(uint64_t &taskId, uint32_t &streamId)
{
    taskId = g_streamAndTaskId.taskId;
    streamId = g_streamAndTaskId.streamId;
    AICPUE_LOGI("Get taskId:[%lu] and streamId:[%u] success.", taskId, streamId);
    return AICPU_ERROR_NONE;
}

status_t SetBlockIdxAndBlockNum(uint32_t blockIdx, uint32_t blockNum)
{
    g_blockIdx = blockIdx;
    g_blockNum = blockNum;
    AICPUE_LOGI("Set blockIdx:[%u] and blockNum:[%u] success.", blockIdx, blockNum);
    return AICPU_ERROR_NONE;
}

uint32_t GetBlockIdx()
{
    return g_blockIdx;
}

uint32_t GetBlockNum()
{
    return g_blockNum;
}

status_t SetAicpuRunMode(uint32_t runMode)
{
    g_runMode = runMode;
    AICPUE_LOGI("Set runMode:[%u] success.", runMode);
    return AICPU_ERROR_NONE;
}

status_t GetAicpuRunMode(uint32_t &runMode)
{
    runMode = g_runMode;
    return AICPU_ERROR_NONE;
}

status_t SetThreadLocalCtx(const std::string &key, const std::string &value)
{
    if (key.empty()) {
        AICPUE_LOGE("set thread local context failed, key is empty");
        return AICPU_ERROR_FAILED;
    }
    try {
        g_threadLocalAicpuCtx[key] = value;
    } catch (std::exception &e) {
        AICPUE_LOGE("set thread local context failed, %s", e.what());
        return AICPU_ERROR_FAILED;
    }
    return AICPU_ERROR_NONE;
}

status_t GetThreadLocalCtx(const std::string &key, std::string &value)
{
    if (key.empty()) {
        AICPUE_LOGE("get thread local context failed, key is empty");
        return AICPU_ERROR_FAILED;
    }
    const auto iter = g_threadLocalAicpuCtx.find(key);
    if (iter != g_threadLocalAicpuCtx.end()) {
        value = iter->second;
        return AICPU_ERROR_NONE;
    }
    AICPUE_LOGW("get thread local context failed, no such key[%s]", key.c_str());
    return AICPU_ERROR_FAILED;
}

status_t RemoveThreadLocalCtx(const std::string &key)
{
    const auto iter = g_threadLocalAicpuCtx.find(key);
    if (iter != g_threadLocalAicpuCtx.end()) {
        (void)g_threadLocalAicpuCtx.erase(iter);
        return AICPU_ERROR_NONE;
    }
    AICPUE_LOGE("remove thread local context failed, no such key[%s]", key.c_str());
    return AICPU_ERROR_FAILED;
}

const std::map<std::string, std::string> &GetAllThreadCtxInfo(aicpu::CtxType type, uint32_t threadIndex)
{
    AICPUE_LOGI("Get all thread ctx info begin, thread index:%u", threadIndex);
    auto &ctx = GetThreadCtx(type, threadIndex);
    return ctx;
}

status_t RegisterEventCallback(const uint32_t eventId, const uint32_t subeventId,
                               std::function<void(void *)> func,
                               const bool isNeedClear)
{
    const std::lock_guard<std::mutex> locker(g_funcMapMutex);
    std::map<uint32_t, std::pair<std::function<void(void *)>, bool>> &subMap = g_funcMap[eventId];
    const auto it = subMap.insert({subeventId, {func, isNeedClear}});
    if (!it.second) {
        AICPUE_LOGE("register event call function failed, repulicate register callback "
                    "function by eventId[%u] subeventId[%u]", eventId, subeventId);
        return AICPU_ERROR_FAILED;
    }
    return AICPU_ERROR_NONE;
}

status_t DoEventCallback(const uint32_t eventId, const uint32_t subeventId, void * const param)
{
    const std::lock_guard<std::mutex> locker(g_funcMapMutex);
    const auto iter = g_funcMap.find(eventId);
    if (iter == g_funcMap.end()) {
        AICPUE_RUN_LOGW("do event callback function failed, cannot find callback function by "
                        "eventId[%u] subeventId[%u]", eventId, subeventId);
        return AICPU_ERROR_FAILED;
    }

    std::map<uint32_t, std::pair<std::function<void(void *)>, bool>> &subMap = iter->second;
    const auto subIter = subMap.find(subeventId);
    if (subIter == subMap.end()) {
        AICPUE_RUN_LOGW("do event callback function failed, cannot find callback function by "
                        "eventId[%u] subeventId[%u]", eventId, subeventId);
        return AICPU_ERROR_FAILED;
    }
    ((subIter->second).first)(param);
    // erase func after call
    if ((subIter->second).second) {
        (void)subMap.erase(subIter);
    }
    return AICPU_ERROR_NONE;
}

status_t UnRegisterCallback(const uint32_t eventId, const uint32_t subeventId)
{
    const std::lock_guard<std::mutex> locker(g_funcMapMutex);
    const auto iter = g_funcMap.find(eventId);
    if (iter == g_funcMap.end()) {
        AICPUE_RUN_LOGW("skip unregister event callback function, cannot find callback function by eventId[%u] "
                        "subeventId[%u]", eventId, subeventId);
        return AICPU_ERROR_NONE;
    }

    std::map<uint32_t, std::pair<std::function<void(void *)>, bool>> &subMap = iter->second;
    const auto subIter = subMap.find(subeventId);
    if (subIter == subMap.end()) {
        AICPUE_RUN_LOGW("skip unregister event callback function, cannot find callback function by eventId[%u] "
                        "subeventId[%u]", eventId, subeventId);
        return AICPU_ERROR_NONE;
    }
    (void)subMap.erase(subIter);
    return AICPU_ERROR_NONE;
}

using AicpuStreamDvpp = struct {
    uint8_t *dvppBuff;
    uint64_t dvppBuffLen;
    int32_t channelId;
};

static pthread_rwlock_t g_streamAndChannelMapLock[AICPU_DVPP_CHL_BUTT] = {
    PTHREAD_RWLOCK_INITIALIZER,
    PTHREAD_RWLOCK_INITIALIZER};
static std::map<uint32_t, AicpuStreamDvpp> g_streamAndChannelMap[AICPU_DVPP_CHL_BUTT];

void SetStreamDvppBuffBychlType(const AicpuDvppChlType chlType, const uint64_t buffLen, uint8_t *buff)
{
    if (chlType >= AICPU_DVPP_CHL_BUTT) {
        AICPUE_LOGE("chlType is invalid, chlType[%d].", static_cast<int32_t>(chlType));
        return;
    }

    uint64_t taskId = 0U;
    uint32_t streamId = 0U;
    if (GetTaskAndStreamId(taskId, streamId) != AICPU_ERROR_NONE) {
        AICPUE_LOGE("Get taskId and streamId failed.");
        return;
    }

    (void)pthread_rwlock_rdlock(&g_streamAndChannelMapLock[chlType]);
    const std::map<uint32_t, AicpuStreamDvpp>::iterator iter = g_streamAndChannelMap[chlType].find(streamId);
    if (iter != g_streamAndChannelMap[chlType].end()) {
        iter->second.dvppBuff = buff;
        iter->second.dvppBuffLen = buffLen;
        AICPUE_LOGI("Set dvpp len [%d], stream [%d].", buffLen, streamId);
    }
    (void)pthread_rwlock_unlock(&g_streamAndChannelMapLock[chlType]);
    return;
}

void SetStreamDvppBuffByStreamId(const AicpuDvppChlType chlType, const uint32_t streamId,
                                 const uint64_t buffLen, uint8_t *buff)
{
    if (chlType >= AICPU_DVPP_CHL_BUTT) {
        AICPUE_LOGE("chlType is invalid, chlType[%d].", static_cast<int32_t>(chlType));
        return;
    }

    (void)pthread_rwlock_rdlock(&g_streamAndChannelMapLock[chlType]);
    const std::map<uint32_t, AicpuStreamDvpp>::iterator iter = g_streamAndChannelMap[chlType].find(streamId);
    if (iter != g_streamAndChannelMap[chlType].end()) {
        iter->second.dvppBuff = buff;
        iter->second.dvppBuffLen = buffLen;
        AICPUE_LOGI("Set dvpp len [%d], stream [%d].", buffLen, streamId);
    }
    (void)pthread_rwlock_unlock(&g_streamAndChannelMapLock[chlType]);
    return;
}

void GetDvppBufAndLenBychlType(const AicpuDvppChlType chlType, uint8_t **buff, uint64_t *buffLen)
{
    if (chlType >= AICPU_DVPP_CHL_BUTT) {
        AICPUE_LOGE("chlType is invalid, chlType[%d].", static_cast<int32_t>(chlType));
        return;
    }

    uint64_t taskId = 0U;
    uint32_t streamId = 0U;
    if (GetTaskAndStreamId(taskId, streamId) != AICPU_ERROR_NONE) {
        AICPUE_LOGE("Get taskId and streamId failed. taskId[%lu] streamId[%u]", taskId, streamId);
        return;
    }

    (void)pthread_rwlock_rdlock(&g_streamAndChannelMapLock[chlType]);
    const std::map<uint32_t, AicpuStreamDvpp>::iterator iter = g_streamAndChannelMap[chlType].find(streamId);
    if (iter != g_streamAndChannelMap[chlType].end()) {
        *buff = iter->second.dvppBuff;
        *buffLen = iter->second.dvppBuffLen;
        AICPUE_LOGI("Get dvpp len [%d], stream [%d].", *buffLen, streamId);
    }
    (void)pthread_rwlock_unlock(&g_streamAndChannelMapLock[chlType]);
    return;
}

void GetDvppBufAndLenByStreamId(const uint32_t streamId, const AicpuDvppChlType chlType, uint8_t **buff)
{
    if (chlType >= AICPU_DVPP_CHL_BUTT) {
        AICPUE_LOGE("chlType is invalid, chlType[%d].", static_cast<int32_t>(chlType));
        return;
    }

    (void)pthread_rwlock_rdlock(&g_streamAndChannelMapLock[chlType]);
    const std::map<uint32_t, AicpuStreamDvpp>::iterator iter = g_streamAndChannelMap[chlType].find(streamId);
    if (iter != g_streamAndChannelMap[chlType].end()) {
        *buff = iter->second.dvppBuff;
        AICPUE_LOGI("GetDvppBufAndLenByStreamId stream [%d].", streamId);
    }
    (void)pthread_rwlock_unlock(&g_streamAndChannelMapLock[chlType]);
    return;
}

int32_t GetStreamDvppChannelId(uint32_t streamId, AicpuDvppChlType chlType)
{
    if (chlType >= AICPU_DVPP_CHL_BUTT) {
        return -1;
    }

    int32_t channelId = -1;
    (void)pthread_rwlock_rdlock(&g_streamAndChannelMapLock[chlType]);
    const std::map<uint32_t, AicpuStreamDvpp>::iterator iter = g_streamAndChannelMap[chlType].find(streamId);
    if (iter != g_streamAndChannelMap[chlType].end()) {
        channelId = iter->second.channelId;
    }
    (void)pthread_rwlock_unlock(&g_streamAndChannelMapLock[chlType]);
    return channelId;
}

int32_t GetCurTaskDvppChannelId(AicpuDvppChlType chlType)
{
    if (chlType >= AICPU_DVPP_CHL_BUTT) {
        return -1;
    }

    uint64_t taskId = 0U;
    uint32_t streamId = 0U;
    (void)GetTaskAndStreamId(taskId, streamId);

    return GetStreamDvppChannelId(streamId, chlType);
}

int32_t InitStreamDvppChannel(uint32_t streamId, AicpuDvppChlType chlType, int32_t channelId)
{
    if (chlType >= AICPU_DVPP_CHL_BUTT) {
        return -1;
    }

    int32_t streamChannel = channelId;
    (void)pthread_rwlock_wrlock(&g_streamAndChannelMapLock[chlType]);
    const std::map<uint32_t, AicpuStreamDvpp>::iterator iter = g_streamAndChannelMap[chlType].find(streamId);
    if (iter == g_streamAndChannelMap[chlType].end()) {
        AicpuStreamDvpp aicpuStream;
        aicpuStream.dvppBuffLen = 0LLU;
        aicpuStream.dvppBuff = nullptr;
        aicpuStream.channelId = streamChannel;
        (void)g_streamAndChannelMap[chlType].insert(std::pair<uint32_t, AicpuStreamDvpp>(streamId, aicpuStream));
    } else {
        streamChannel = iter->second.channelId;
    }
    (void)pthread_rwlock_unlock(&g_streamAndChannelMapLock[chlType]);
    return streamChannel;
}

int32_t UnInitStreamDvppChannel(uint32_t streamId, AicpuDvppChlType chlType)
{
    if (chlType >= AICPU_DVPP_CHL_BUTT) {
        return -1;
    }

    int32_t streamChannel = -1;
    (void)pthread_rwlock_wrlock(&g_streamAndChannelMapLock[chlType]);
    const std::map<uint32_t, AicpuStreamDvpp>::iterator iter = g_streamAndChannelMap[chlType].find(streamId);
    if (iter != g_streamAndChannelMap[chlType].end()) {
        iter->second.dvppBuffLen = 0LLU;
        streamChannel = iter->second.channelId;
        (void)g_streamAndChannelMap[chlType].erase(iter);
    }
    (void)pthread_rwlock_unlock(&g_streamAndChannelMapLock[chlType]);
    return streamChannel;
}

uint32_t GetUniqueVfId()
{
    return g_uniqueVfId;
}

void SetUniqueVfId(const uint32_t uniqueVfId)
{
    g_uniqueVfId = uniqueVfId;
}

void SetCustAicpuSdFlag(const bool isCustAicpuSdFlag)
{
    g_isCustAicpuSd = isCustAicpuSdFlag;
}

bool IsCustAicpuSd()
{
    return g_isCustAicpuSd;
}
} // namespace aicpu

aicpu::status_t SetThreadCtxInfo(aicpu::CtxType type, const std::string &key, const std::string &value)
{
    if (key.empty()) {
        AICPUE_LOGE("Set thread context failed, context type[%d], key is empty", static_cast<int32_t>(type));
        return aicpu::AICPU_ERROR_FAILED;
    }

    auto &ctx = GetThreadCtx(type, g_threadIndex);
    try {
        ctx[key] = value;
    } catch (std::exception &aicpuExp) {
        AICPUE_LOGE("Set thread context failed, context type[%d], %s", static_cast<int32_t>(type), aicpuExp.what());
        return aicpu::AICPU_ERROR_FAILED;
    }
    return aicpu::AICPU_ERROR_NONE;
}

aicpu::status_t GetThreadCtxInfo(aicpu::CtxType type, const std::string &key, std::string &value)
{
    if (key.empty()) {
        AICPUE_LOGE("Get thread context failed, context type[%d], key is empty", static_cast<int32_t>(type));
        return aicpu::AICPU_ERROR_FAILED;
    }

    auto &ctx = GetThreadCtx(type, g_threadIndex);
    const auto iter = ctx.find(key);
    if (iter != ctx.end()) {
        value = iter->second;
        return aicpu::AICPU_ERROR_NONE;
    }
    AICPUE_LOGE("Get thread context failed, context type[%d], no such key[%s]", static_cast<int32_t>(type),
                key.c_str());
    return aicpu::AICPU_ERROR_FAILED;
}

aicpu::status_t RemoveThreadCtxInfo(aicpu::CtxType type, const std::string &key)
{
    auto &ctx = GetThreadCtx(type, g_threadIndex);
    const auto iter = ctx.find(key);
    if (iter != ctx.end()) {
        (void)ctx.erase(iter);
        return aicpu::AICPU_ERROR_NONE;
    }
    AICPUE_LOGE("Remove thread context failed, context type[%d], no such key[%s]", static_cast<int32_t>(type),
                key.c_str());
    return aicpu::AICPU_ERROR_FAILED;
}

uint32_t AicpuGetBlockIdx()
{
    return g_blockIdx;
}

uint32_t AicpuGetBlockNum()
{
    return g_blockNum;
}

uint64_t AicpuGetTaskId()
{
    return g_streamAndTaskId.taskId;
}

uint32_t AicpuGetStreamId()
{
    return g_streamAndTaskId.streamId;
}
