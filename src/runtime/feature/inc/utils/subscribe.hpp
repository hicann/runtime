/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_SUBSCRIBE_HPP__
#define __CCE_RUNTIME_SUBSCRIBE_HPP__
#include <map>
#include "base.hpp"
#include "stream.hpp"
#include "event.hpp"
#include "notify.hpp"
#include "pool.hpp"

#define RT_CB_SUBSCRIBE_MK_INFO_KEY(tsId, devId) ((static_cast<uint32_t>(tsId) << 16U) | static_cast<uint32_t>(devId))
#define RT_CB_SUBSCRIBE_GET_DEV_ID(key) ((key) & 0xFFFFU)
#define RT_CB_SUBSCRIBE_GET_TS_ID(key) (((key) >> 16U) & 0xFFFFU)
#define RT_CB_SUBSCRIBE_MK_STREAM_DEV_KEY(devId, streamId) \
    ((static_cast<uint64_t>(devId) << 32U) | static_cast<uint64_t>(streamId))
#define RT_CB_SUBSCRIBE_GET_DEV_ID_BY_STREAM_KEY(key) (((key) >> 32U) & 0xFFFFFFFFU)
#define RT_CB_SUBSCRIBE_GET_STREAM_ID_BY_STREAM_KEY(key) ((key) & 0xFFFFFFFFU)

namespace cce {
namespace runtime {

typedef struct tagCbSubscribeInfo {
    uint64_t threadId; /* ThreadID */
    Stream *stream;
    uint32_t sqId; /* SqId */
    uint32_t cqId; /* CqId */
    int32_t groupId;
    union {
        Event *event;
        Notify *notify;
    } u;
}cbSubscribeInfo;

using ThreadIdMap = std::map<uint64_t, std::map<uint32_t, std::map<int32_t, cbSubscribeInfo> > >;
using DevIdTsIdMap = std::map<uint32_t, std::map<int32_t, cbSubscribeInfo> >;
using StreamMap = std::map<int32_t, cbSubscribeInfo>;
using StreamDevMap = std::map<uint64_t, cbSubscribeInfo>;

using ThreadIdMapIt = ThreadIdMap::iterator;
using DevIdTsIdMapIt = DevIdTsIdMap::iterator;
using StreamMapIt = StreamMap::iterator;

class CbSubscribe : public NoCopy {
public:
    explicit CbSubscribe(const uint32_t maxGrpNum);
    ~CbSubscribe() override;
    rtError_t Insert(const uint64_t threadId, Stream * const stm, void *evtNotify);
    rtError_t Delete(const uint64_t threadId, Stream * const stm);
    rtError_t Delete(Stream * const stm);
    rtError_t GetGroupIdByThreadId(const uint64_t threadId, uint32_t * const deviceId,
                                   uint32_t * const tsId, uint32_t * const groupId, const bool noLog = false);
    rtError_t GetGroupIdByStreamId(const uint32_t devId, const int32_t streamId, uint32_t * const groupId);
    rtError_t GetEventByStreamId(const uint32_t devId, const int32_t streamId, Event ** const evt);
    rtError_t GetNotifyByStreamId(const uint32_t devId, const int32_t streamId, Notify ** const notify);
    rtError_t GetCqIdByStreamId(const uint32_t devId, const int32_t streamId, uint32_t * const cqId);
    rtError_t GetSqIdByStreamId(const uint32_t devId, const int32_t streamId, uint32_t * const sqId);
    rtError_t GetThreadIdByStreamId(const uint32_t devId, const int32_t streamId, uint64_t * const threadId);
    void LockGroupId(const uint32_t grpId)
    {
        grpIdWaitBitmap_.OccupyId(static_cast<int32_t>(grpId));
    }
    void UnlockGroupId(const uint32_t grpId)
    {
        grpIdWaitBitmap_.FreeId(static_cast<int32_t>(grpId));
    }
    bool IsExistInStreamMap(const Stream * const stm);
    rtError_t SubscribeCallback(const uint64_t threadId, Stream * const stm, void *evtNotify);
    bool JudgeNeedSubscribe(const uint64_t threadId, Stream * const stm, const uint32_t deviceId);
    bool TryToGetCallbackSqCqId(const uint64_t threadId, const Stream * const stm, uint32_t *sqId, uint32_t *cqId);
private:
    rtError_t CheckForInsert(const uint64_t threadId, Stream * const stm, ThreadIdMapIt &threadIdIter,
                             DevIdTsIdMapIt &devIdTsIdIter, StreamMapIt &streamIter);
    rtError_t AssignGroupId(const uint64_t threadId, const Stream * const stm, ThreadIdMapIt &it, int32_t &groupId);
    bool CheckExistInThreadMap(const uint64_t threadId, const Stream * const stm, ThreadIdMapIt &threadIdIter,
                               DevIdTsIdMapIt &devIdTsIdIter, StreamMapIt &streamIter);
    bool CheckExistInStreamMap(const Stream * const stm) const;
    bool CheckExistInStreamMap(const Stream * const stm, StreamDevMap::const_iterator &streamIt) const;
    void DeleteAll();
    bool FindThreadIdByKey(const uint32_t deviceId, const int32_t streamId);
private:
    uint32_t maxGroupNum_ = static_cast<uint32_t>(RT_THREAD_GROUP_ID_MAX);
    std::mutex subscribeLock_;
    /* key1 is thread id,second key2 is tsid and dev id, key3 is streamId */
    std::map<uint64_t, std::map<uint32_t, std::map<int32_t, cbSubscribeInfo> > > subscribeMapByThreadId_;
    /* key is devID | streamID */
    std::map<uint64_t, cbSubscribeInfo> subscribeMapByStreamId_;
    Bitmap grpIdBitmap_;
    Bitmap grpIdWaitBitmap_;
};
}
}

#endif  // __CCE_RUNTIME_TASK_HPP__
