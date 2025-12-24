/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "subscribe.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
CbSubscribe::CbSubscribe(const uint32_t maxGrpNum)
    : NoCopy(), grpIdBitmap_(maxGrpNum), grpIdWaitBitmap_(maxGrpNum)
{
    maxGroupNum_ = maxGrpNum;
}

CbSubscribe::~CbSubscribe()
{
    DeleteAll();
}

rtError_t CbSubscribe::AssignGroupId(const uint64_t threadId, const Stream * const stm,
                                     ThreadIdMapIt &it, int32_t &groupId)
{
    if (it != subscribeMapByThreadId_.end()) {
        groupId = it->second.begin()->second.begin()->second.groupId;
        return RT_ERROR_NONE;
    }

    std::vector<int32_t> lockedGrpIds;
    const std::function<void()> func = [=, &lockedGrpIds]() {
        for (auto &gpId : lockedGrpIds) {
            grpIdBitmap_.FreeId(gpId);
        }
    };
    const ScopeGuard groupIdGuarder(func);
    (void)grpIdWaitBitmap_.AllocBitmap();
    while (true) {
        groupId = grpIdBitmap_.AllocId();
        if (groupId < 0) {
            RT_LOG_INNER_MSG(RT_LOG_ERROR,
                "thread out of range %d. groupId is full, out of %u, [threadId_key(%" PRIu64 ") - devId(%u)|tsId(%u)], streamId(%d)",
                maxGroupNum_, maxGroupNum_, threadId, stm->Device_()->Id_(), stm->Device_()->DevGetTsId(), stm->Id_());
            return RT_ERROR_SUBSCRIBE_GROUP;
        }
        if (grpIdWaitBitmap_.IsIdOccupied(groupId)) {
            lockedGrpIds.emplace_back(groupId);
            RT_LOG(RT_LOG_INFO, "groupId=%u is Busy", groupId);
            continue;
        }
        break;
    }
    RT_LOG(RT_LOG_INFO, "give groupId=%u", groupId);
    return RT_ERROR_NONE;
}

rtError_t CbSubscribe::CheckForInsert(const uint64_t threadId, Stream * const stm, ThreadIdMapIt &threadIdIter,
    DevIdTsIdMapIt &devIdTsIdIter, StreamMapIt &streamIter)
{
    if (CheckExistInStreamMap(stm)) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR,
            "Stream is already exist in stream map, streamId=%d, devId=%u, threadId=%" PRIu64,
            stm->Id_(), stm->Device_()->Id_(), threadId);
        return RT_ERROR_SUBSCRIBE_STREAM;
    }
    if (CheckExistInThreadMap(threadId, stm, threadIdIter, devIdTsIdIter, streamIter)) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Stream is already exist in thread map, streamId=%d, threadId=%" PRIu64,
            stm->Id_(), threadId);
        return RT_ERROR_SUBSCRIBE_THREAD;
    }
    if ((threadIdIter != subscribeMapByThreadId_.end()) && (devIdTsIdIter == threadIdIter->second.end())) {
        RT_LOG_INNER_MSG(RT_LOG_ERROR,
            "Can not find subscribeMap by threadId_key(%" PRIu64 "), streamId=%d, devId=%u, tsId=%u",
            threadId, stm->Id_(), stm->Device_()->Id_(), stm->Device_()->DevGetTsId());
        return RT_ERROR_SUBSCRIBE_THREAD;
    }
    return RT_ERROR_NONE;
}
bool CbSubscribe::TryToGetCallbackSqCqId(const uint64_t threadId, const Stream * const stm, uint32_t *sqId, uint32_t *cqId)
{
    ThreadIdMapIt threadIdIter = subscribeMapByThreadId_.find(threadId);
    if (threadIdIter == subscribeMapByThreadId_.end()) {
        return false;
    }
    const uint32_t devId = stm->Device_()->Id_();
    const uint32_t tsId = stm->Device_()->DevGetTsId();
    const uint32_t key = RT_CB_SUBSCRIBE_MK_INFO_KEY(tsId, devId);
    DevIdTsIdMapIt devIdTsIdIter = threadIdIter->second.find(key);
    if (devIdTsIdIter == threadIdIter->second.end()) {
        return false;
    }
    if (devIdTsIdIter->second.empty()) {
        return false;
    }
    *sqId = devIdTsIdIter->second.begin()->second.sqId;
    *cqId = devIdTsIdIter->second.begin()->second.cqId;
    return true;  
}
rtError_t CbSubscribe::Insert(const uint64_t threadId, Stream * const stm, void *evtNotify)
{
    const uint32_t devId = stm->Device_()->Id_();
    const uint32_t tsId = stm->Device_()->DevGetTsId();
    const int32_t streamId = stm->Id_();
    ThreadIdMapIt it;
    DevIdTsIdMapIt it2;
    StreamMapIt it3;
    subscribeLock_.lock();
    const std::function<void()> unlockSpinFunc = [&]() {
        subscribeLock_.unlock();
    };
    const ScopeGuard groupIdSpinlockGuarder(unlockSpinFunc);
    rtError_t ret = CheckForInsert(threadId, stm, it, it2, it3);
    if (ret != RT_ERROR_NONE) {
        return ret;
    }

    int32_t groupId;
    ret = AssignGroupId(threadId, stm, it, groupId);
    if (ret != RT_ERROR_NONE) {
        return ret;
    }
    const auto devDrv = stm->Device_()->Driver_();
    uint32_t sqId;
    uint32_t cqId;
    bool isReuseCqSq = TryToGetCallbackSqCqId(threadId, stm, &sqId, &cqId);
    if (!isReuseCqSq) {
        ret = devDrv->SqCqAllocate(devId, tsId, static_cast<uint32_t>(groupId), &sqId, &cqId);
        if (ret != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "SqCqAllocate failed, retCode=%#x, threadId=%" PRIu64 ", devId=%u, tsId=%u", ret,
            threadId, devId, tsId);
            return ret;
        }
    }
    cbSubscribeInfo info;
    info.threadId = threadId;
    info.stream = stm;
    info.sqId = sqId;
    info.cqId = cqId;
    info.groupId = groupId;
    if (stm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_NOTIFY_ONLY)) {
        info.u.notify = static_cast<Notify *>(evtNotify);
    } else {
        info.u.event = static_cast<Event *>(evtNotify);
    }
    if (it == subscribeMapByThreadId_.end()) {
        const uint32_t key = RT_CB_SUBSCRIBE_MK_INFO_KEY(tsId, devId);
        subscribeMapByThreadId_[threadId][key][streamId] = info;
    } else if (it3 == it2->second.end()) {
        it2->second[streamId] = info;
    } else {
        // no operation
    }
    const uint64_t streamDevKey = RT_CB_SUBSCRIBE_MK_STREAM_DEV_KEY(devId, streamId);
    subscribeMapByStreamId_[streamDevKey] = info;
    RT_LOG(RT_LOG_INFO, "callback subscribe: groupId=%d, threadId=%" PRIu64 ", devId=%u, tsId=%u, "
        "streamId=%d, sqId=%u, cqId=%u", groupId, threadId, devId, tsId, streamId, sqId, cqId);
    return RT_ERROR_NONE;
}

rtError_t CbSubscribe::Delete(const uint64_t threadId, Stream * const stm)
{
    rtError_t ret;
    const uint32_t devId = stm->Device_()->Id_();
    const uint32_t tsId = stm->Device_()->DevGetTsId();
    ThreadIdMapIt it;
    DevIdTsIdMapIt it2;
    StreamMapIt it3;
    uint32_t groupId;
    uint64_t streamDevKey;
    subscribeLock_.lock();
    if (!CheckExistInStreamMap(stm)) {
        subscribeLock_.unlock();
        const auto streamId = stm->Id_();
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Stream is not exist in stream map, streamId=%d, threadId=%" PRIu64,
            streamId, threadId);
        return RT_ERROR_SUBSCRIBE_STREAM;
    }

    if (!CheckExistInThreadMap(threadId, stm, it, it2, it3)) {
        subscribeLock_.unlock();
        const auto streamId = stm->Id_();
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Stream is not exist in thread map,streamId=%d, threadId=%" PRIu64,
            streamId, threadId);
        return RT_ERROR_SUBSCRIBE_THREAD;
    }
    const uint32_t sqId = it3->second.sqId;
    const uint32_t cqId = it3->second.cqId;
    if (stm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_NOTIFY_ONLY)) {
        Notify * const notify = it3->second.u.notify;
        if (notify != nullptr) {
            delete notify;
        }
    } else {
        Event * const event = it3->second.u.event;
        if (event != nullptr) {
            const rtError_t error = event->WaitForBusy();
            COND_PROC_RETURN_ERROR((error != RT_ERROR_NONE), error, subscribeLock_.unlock(),
                "stream_id=%d is abort", stm->Id_());
            delete event;
        }
    }
    groupId = static_cast<uint32_t>(it3->second.groupId);
    bool needsFreeSqCq = (it2->second.size() == 1U);
    if (needsFreeSqCq) {
        grpIdBitmap_.FreeId(static_cast<int32_t>(groupId));
        (void)subscribeMapByThreadId_.erase(threadId);
    } else {
        (void)it2->second.erase(it3->first);
    }

    streamDevKey = RT_CB_SUBSCRIBE_MK_STREAM_DEV_KEY(devId, stm->Id_());
    (void)subscribeMapByStreamId_.erase(streamDevKey);

    subscribeLock_.unlock();
    const auto devDrv = stm->Device_()->Driver_();
    if (needsFreeSqCq) {
        ret = devDrv->SqCqFree(sqId, cqId, devId, tsId);
        ERROR_RETURN_MSG_INNER(ret, "Free sqcq failed, retCode=%#x, threadId=%" PRIu64 ", "
                                    "streamId=%d, devId=%u, tsId=%u, sqId=%u, cqId=%u",
                                    static_cast<uint32_t>(ret), threadId, stm->Id_(), devId, tsId, sqId, cqId);
    }
    RT_LOG(RT_LOG_INFO, "delete callback subscribe: groupId=%u, threadId=%" PRIu64 ", devId=%u, tsId=%u, "
        "streamId=%d, sqId=%u, cqId=%u, needsFreeSqCq=%d", groupId, threadId, devId, tsId, stm->Id_(),
        sqId, cqId, needsFreeSqCq);
    return RT_ERROR_NONE;
}

rtError_t CbSubscribe::Delete(Stream * const stm)
{
    rtError_t ret;
    const uint32_t devId = stm->Device_()->Id_();
    const uint32_t tsId = stm->Device_()->DevGetTsId();
    ThreadIdMapIt it;
    DevIdTsIdMapIt it2;
    StreamMapIt it3;
    uint32_t groupId;
    uint64_t threadId;
    subscribeLock_.lock();
    StreamDevMap::const_iterator itStream;
    if (!CheckExistInStreamMap(stm, itStream)) {
        subscribeLock_.unlock();
        const auto streamId = stm->Id_();
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Stream is not exist in stream map,streamId=%d", streamId);
        return RT_ERROR_SUBSCRIBE_STREAM;
    }
    threadId = itStream->second.threadId;
    if (!CheckExistInThreadMap(threadId, stm, it, it2, it3)) {
        subscribeLock_.unlock();
        const auto streamId = stm->Id_();
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "Stream is not exist in thread map, streamId=%d, threadId=%" PRIu64,
            streamId, threadId);
        return RT_ERROR_SUBSCRIBE_THREAD;
    }

    const uint32_t sqId = it3->second.sqId;
    const uint32_t cqId = it3->second.cqId;
    if (stm->Device_()->IsSupportFeature(RtOptionalFeatureType::RT_FEATURE_DEVICE_NOTIFY_ONLY)) {
        Notify * const notify = it3->second.u.notify;
        if (notify != nullptr) {
            delete notify;
        }
    } else {
        Event * const event = it3->second.u.event;
        if (event != nullptr) {
            const rtError_t error = event->WaitForBusy();
            COND_PROC_RETURN_ERROR((error != RT_ERROR_NONE), error, subscribeLock_.unlock(),
                "stream_id=%d is abort", stm->Id_());
            delete event;
        }
    }

    groupId = static_cast<uint32_t>(it3->second.groupId);
    bool needsFreeSqCq = (it2->second.size() == 1U);
    if (needsFreeSqCq) {
        grpIdBitmap_.FreeId(static_cast<int32_t>(groupId));
        (void)subscribeMapByThreadId_.erase(threadId);
    } else {
        (void)it2->second.erase(it3->first);
    }
    (void)subscribeMapByStreamId_.erase(itStream->first);

    subscribeLock_.unlock();
    Driver * const devDrv = stm->Device_()->Driver_();
    if (needsFreeSqCq) {
        ret = devDrv->SqCqFree(sqId, cqId, devId, tsId);
        ERROR_RETURN_MSG_INNER(ret, "Free sqcq failed, retCode=%#x, threadId=%" PRIu64 ", "
                                    "streamId=%d, devId=%u, tsId=%u, sqId=%u, cqId=%u",
                                    static_cast<uint32_t>(ret), threadId, stm->Id_(), devId, tsId, sqId, cqId);
    }
    RT_LOG(RT_LOG_INFO, "delete callback subscribe: groupId=%u, threadId=%" PRIu64 ", devId=%u, tsId=%u, "
        "streamId=%d, sqId=%u, cqId=%u, needsFreeSqCq=%d", groupId, threadId, devId, tsId, stm->Id_(),
        sqId, cqId, needsFreeSqCq);
    return RT_ERROR_NONE;
}

bool CbSubscribe::CheckExistInThreadMap(const uint64_t threadId, const Stream * const stm, ThreadIdMapIt &threadIdIter,
                                        DevIdTsIdMapIt &devIdTsIdIter, StreamMapIt &streamIter)
{
    threadIdIter = subscribeMapByThreadId_.find(threadId);
    if (threadIdIter == subscribeMapByThreadId_.end()) {
        return false;
    }

    const uint32_t devId = stm->Device_()->Id_();
    const uint32_t tsId = stm->Device_()->DevGetTsId();
    const uint32_t key = RT_CB_SUBSCRIBE_MK_INFO_KEY(tsId, devId);
    devIdTsIdIter = threadIdIter->second.find(key);
    if (devIdTsIdIter == threadIdIter->second.end()) {
        return false;
    }
    streamIter = devIdTsIdIter->second.find(stm->Id_());
    return (streamIter != devIdTsIdIter->second.end());
}

bool CbSubscribe::IsExistInStreamMap(const Stream * const stm)
{
    const uint64_t key = RT_CB_SUBSCRIBE_MK_STREAM_DEV_KEY(stm->Device_()->Id_(), stm->Id_());
    subscribeLock_.lock();
    const auto it = subscribeMapByStreamId_.find(key);
    if (it != subscribeMapByStreamId_.end()) {
        subscribeLock_.unlock();
        return true;
    }
    subscribeLock_.unlock();
    return false;
}

bool CbSubscribe::CheckExistInStreamMap(const Stream * const stm) const
{
    const uint64_t key = RT_CB_SUBSCRIBE_MK_STREAM_DEV_KEY(stm->Device_()->Id_(), stm->Id_());
    const auto it = subscribeMapByStreamId_.find(key);
    if (it != subscribeMapByStreamId_.end()) {
        return true;
    }
    return false;
}


bool CbSubscribe::CheckExistInStreamMap(const Stream * const stm, StreamDevMap::const_iterator &streamIt) const
{
    const uint64_t key = RT_CB_SUBSCRIBE_MK_STREAM_DEV_KEY(stm->Device_()->Id_(), stm->Id_());
    streamIt = subscribeMapByStreamId_.find(key);
    if (streamIt != subscribeMapByStreamId_.end()) {
        return true;
    }
    return false;
}

rtError_t CbSubscribe::GetGroupIdByThreadId(const uint64_t threadId, uint32_t * const deviceId,
                                            uint32_t * const tsId, uint32_t * const groupId, const bool noLog)
{
    subscribeLock_.lock();
    const auto it = subscribeMapByThreadId_.find(threadId);
    if (it == subscribeMapByThreadId_.end()) {
        subscribeLock_.unlock();
        if (!noLog) {
            RT_LOG(RT_LOG_WARNING, "can not find subscribe info, threadId=%" PRIu64, threadId);
        }
        return RT_ERROR_SUBSCRIBE_THREAD;
    }
    const auto it2 = it->second.begin()->second.begin();
    *groupId = static_cast<uint32_t>(it2->second.groupId);
    *deviceId = RT_CB_SUBSCRIBE_GET_DEV_ID(it->second.begin()->first);
    *tsId = RT_CB_SUBSCRIBE_GET_TS_ID(it->second.begin()->first);
    subscribeLock_.unlock();
    return RT_ERROR_NONE;
}

rtError_t CbSubscribe::GetGroupIdByStreamId(const uint32_t devId, const int32_t streamId, uint32_t * const groupId)
{
    const uint64_t key = RT_CB_SUBSCRIBE_MK_STREAM_DEV_KEY(devId, streamId);
    subscribeLock_.lock();
    const auto it = subscribeMapByStreamId_.find(key);
    if (it == subscribeMapByStreamId_.end()) {
        subscribeLock_.unlock();
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "can not find subscribe info, streamId=%d, devId=%u", streamId, devId);
        return RT_ERROR_SUBSCRIBE_STREAM;
    }
    *groupId = static_cast<uint32_t>(it->second.groupId);
    subscribeLock_.unlock();
    return RT_ERROR_NONE;
}

rtError_t CbSubscribe::GetEventByStreamId(const uint32_t devId, const int32_t streamId, Event ** const evt)
{
    const uint64_t key = RT_CB_SUBSCRIBE_MK_STREAM_DEV_KEY(devId, streamId);
    subscribeLock_.lock();
    const auto it = subscribeMapByStreamId_.find(key);
    if (it == subscribeMapByStreamId_.end()) {
        subscribeLock_.unlock();
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "can not find subscribe info, streamId=%d, devId=%u", streamId, devId);
        return RT_ERROR_SUBSCRIBE_STREAM;
    }
    *evt = it->second.u.event;
    subscribeLock_.unlock();
    return RT_ERROR_NONE;
}

rtError_t CbSubscribe::GetNotifyByStreamId(const uint32_t devId, const int32_t streamId, Notify ** const notify)
{
    const uint64_t key = RT_CB_SUBSCRIBE_MK_STREAM_DEV_KEY(devId, streamId);
    subscribeLock_.lock();
    const auto it = subscribeMapByStreamId_.find(key);
    if (it == subscribeMapByStreamId_.end()) {
        subscribeLock_.unlock();
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "can not find subscribe info, streamId=%d, devId=%u", streamId, devId);
        return RT_ERROR_SUBSCRIBE_STREAM;
    }
    *notify = it->second.u.notify;
    subscribeLock_.unlock();
    return RT_ERROR_NONE;
}

rtError_t CbSubscribe::GetCqIdByStreamId(const uint32_t devId, const int32_t streamId, uint32_t * const cqId)
{
    const uint64_t key = RT_CB_SUBSCRIBE_MK_STREAM_DEV_KEY(devId, streamId);
    subscribeLock_.lock();
    const auto it = subscribeMapByStreamId_.find(key);
    if (it == subscribeMapByStreamId_.end()) {
        subscribeLock_.unlock();
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "can not find subscribe info, streamId=%d, devId=%u", streamId, devId);
        return RT_ERROR_SUBSCRIBE_STREAM;
    }
    *cqId = it->second.cqId;
    subscribeLock_.unlock();
    return RT_ERROR_NONE;
}

rtError_t CbSubscribe::GetSqIdByStreamId(const uint32_t devId, const int32_t streamId, uint32_t * const sqId)
{
    const uint64_t key = RT_CB_SUBSCRIBE_MK_STREAM_DEV_KEY(devId, streamId);
    subscribeLock_.lock();
    const auto it = subscribeMapByStreamId_.find(key);
    if (it == subscribeMapByStreamId_.end()) {
        subscribeLock_.unlock();
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "can not find subscribe info, streamId=%d, devId=%u", streamId, devId);
        return RT_ERROR_SUBSCRIBE_STREAM;
    }
    *sqId = it->second.sqId;
    subscribeLock_.unlock();
    return RT_ERROR_NONE;
}

rtError_t CbSubscribe::GetThreadIdByStreamId(const uint32_t devId, const int32_t streamId, uint64_t * const threadId)
{
    const uint64_t key = RT_CB_SUBSCRIBE_MK_STREAM_DEV_KEY(devId, streamId);
    subscribeLock_.lock();
    const auto it = subscribeMapByStreamId_.find(key);
    if (it == subscribeMapByStreamId_.end()) {
        subscribeLock_.unlock();
        RT_LOG_INNER_MSG(RT_LOG_ERROR, "can not find subscribe info, streamId=%d, devId=%u", streamId, devId);
        return RT_ERROR_SUBSCRIBE_STREAM;
    }
    *threadId = it->second.threadId;
    subscribeLock_.unlock();
    return RT_ERROR_NONE;
}

void CbSubscribe::DeleteAll()
{
    rtError_t ret;
    subscribeLock_.lock();
    for (auto &it : subscribeMapByStreamId_) {
        const rtChipType_t chipType = Runtime::Instance()->GetChipType();
        if (IS_SUPPORT_CHIP_FEATURE(chipType, RtOptionalFeatureType::RT_FEATURE_DEVICE_NOTIFY_ONLY)) {
            Notify * const notify = it.second.u.notify;
            if (notify != nullptr) {
                delete notify;
            }
        } else {
            Event * const event = it.second.u.event;
            if (event != nullptr) {
                const rtError_t error = event->WaitForBusy();
                if (error != RT_ERROR_NONE) {
                    subscribeLock_.unlock();
                    RT_LOG(RT_LOG_ERROR, "Stream is abort");
                    return;
                }
                delete event;
            }
        }
        const auto devDriver = it.second.stream->Device_()->Driver_();
        ret = devDriver->SqCqFree(it.second.sqId,
            it.second.cqId, it.second.stream->Device_()->Id_(),
            it.second.stream->Device_()->DevGetTsId());
        if (ret != RT_ERROR_NONE) {
            RT_LOG(RT_LOG_ERROR, "SqCqFree failed, threadId=%" PRIu64
                ", devId=%u, tsId=%u, sqId=%u, cqId=%u, retCode=%#x",
                it.second.threadId, it.second.stream->Device_()->Id_(),
                it.second.stream->Device_()->DevGetTsId(), it.second.sqId, it.second.cqId, ret);
        }
    }

    subscribeMapByThreadId_.clear();
    subscribeMapByStreamId_.clear();
    subscribeLock_.unlock();
}

bool CbSubscribe::FindThreadIdByKey(const uint32_t deviceId, const int32_t streamId)
{
    const uint64_t key = RT_CB_SUBSCRIBE_MK_STREAM_DEV_KEY(deviceId, streamId);
    subscribeLock_.lock();
    const auto it = subscribeMapByStreamId_.find(key);
    if (it == subscribeMapByStreamId_.end()) {
        subscribeLock_.unlock();
        return false;
    }
    subscribeLock_.unlock();
    return true;
}

bool CbSubscribe::JudgeNeedSubscribe(const uint64_t threadId, Stream * const stm, const uint32_t deviceId)
{
    if (FindThreadIdByKey(deviceId, stm->Id_())) {
        return false;
    }
    ThreadIdMapIt it;
    DevIdTsIdMapIt it2;
    StreamMapIt it3;
    if (CheckExistInThreadMap(threadId, stm, it, it2, it3)) {
        return false;
    }
    return true;
}

rtError_t CbSubscribe::SubscribeCallback(const uint64_t threadId, Stream * const stm, void *evtNotify)
{
    const rtError_t error = Insert(threadId, stm, evtNotify);
    ERROR_RETURN_MSG_INNER(error, "subscribe fail, streamId=%d, threadId=%" PRIu64 ", retCode=%#x",
        stm->Id_(), threadId, static_cast<uint32_t>(error));
    return error;
}

}  // namespace runtime
}  // namespace cce
