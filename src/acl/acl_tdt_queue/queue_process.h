/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef QUEUE_PROCESSOR_H
#define QUEUE_PROCESSOR_H

#include <mutex>
#include <memory>
#include <map>
#include "queue.h"
#include "runtime/rt_mem_queue.h"
#include "mmpa/mmpa_api.h"

namespace acl {

using QueueDataMutex = struct TagQueueDataMutex {
    std::mutex muForEnqueue;
    std::mutex muForDequeue;
};

enum PID_QUERY_TYPE : int32_t {
    CP_PID,
    QS_PID
};

constexpr int32_t MSEC_TO_USEC = 1000;

constexpr size_t QUERY_BUFF_GRP_MAX_NUM = 1024U;

using QueueDataMutexPtr = std::shared_ptr<QueueDataMutex>;

class QueueProcessor {
public:
    virtual aclError acltdtCreateQueue(const acltdtQueueAttr *const attr, uint32_t *const qid) = 0;

    virtual aclError acltdtDestroyQueue(const uint32_t qid) = 0;

    virtual aclError acltdtEnqueue(const uint32_t qid, const acltdtBuf buf, const int32_t timeout);

    virtual aclError acltdtDequeue(const uint32_t qid, acltdtBuf *const buf, const int32_t timeout);

    virtual aclError acltdtGrantQueue(const uint32_t qid, const int32_t pid, const uint32_t permission,
        const int32_t timeout);

    virtual aclError acltdtAttachQueue(const uint32_t qid, const int32_t timeout,
        uint32_t *const permission);

    virtual aclError acltdtBindQueueRoutes(acltdtQueueRouteList *const qRouteList) = 0;

    virtual aclError acltdtUnbindQueueRoutes(acltdtQueueRouteList *const qRouteList) = 0;

    virtual aclError acltdtQueryQueueRoutes(const acltdtQueueRouteQueryInfo *const queryInfo,
                                            acltdtQueueRouteList *const qRouteList) = 0;

    virtual aclError acltdtAllocBuf(const size_t size, const uint32_t type, acltdtBuf *const buf) = 0;

    virtual aclError acltdtAllocBufData(const size_t size, const uint32_t type, acltdtBuf *const buf);

    virtual aclError acltdtFreeBuf(acltdtBuf buf);

    virtual aclError acltdtSetBufDataLen(const acltdtBuf buf, const size_t len);

    virtual aclError acltdtGetBufDataLen(const acltdtBuf buf, size_t *const len);

    virtual aclError acltdtAppendBufChain(const acltdtBuf headBuf, const acltdtBuf buf);

    virtual aclError acltdtGetBufChainNum(const acltdtBuf headBuf, uint32_t *const num);

    virtual aclError acltdtGetBufFromChain(const acltdtBuf headBuf, const uint32_t index, acltdtBuf *const buf);

    virtual aclError acltdtGetBufData(const acltdtBuf buf, void **const dataPtr, size_t *const size);

    virtual aclError acltdtGetBufUserData(const acltdtBuf buf, void *dataPtr,
                                          const size_t size, const size_t offset);

    virtual aclError acltdtSetBufUserData(acltdtBuf buf, const void *dataPtr,
                                          const size_t size, const size_t offset);

    virtual aclError acltdtCopyBufRef(const acltdtBuf buf, acltdtBuf *const newBuf);

    virtual aclError QueryAllocGroup();

    virtual aclError QueryGroupId(const std::string &grpName);

    aclError InitQueueSchedule(const int32_t devId) const;

    aclError acltdtDestroyQueueOndevice(const uint32_t qid, const bool isThreadMode = false);

    aclError SendBindUnbindMsgOnDevice(acltdtQueueRouteList *const qRouteList,
        const bool isBind, rtEschedEventSummary_t &eventSum, rtEschedEventReply_t &ack) const;

    aclError SendConnectQsMsg(const int32_t deviceId, rtEschedEventSummary_t &eventSum, rtEschedEventReply_t &ack);
    aclError GetDstInfo(const int32_t deviceId, const PID_QUERY_TYPE type,
        int32_t &dstPid, const bool isThreadMode = false) const;
    aclError GetQueuePermission(const int32_t deviceId, uint32_t qid, rtMemQueueShareAttr_t &permission) const;
    aclError GetQueueRouteNum(const acltdtQueueRouteQueryInfo *const queryInfo,
                              const int32_t deviceId,
                              rtEschedEventSummary_t &eventSum,
                              rtEschedEventReply_t &ack,
                              size_t &routeNum) const;

    aclError QueryQueueRoutesOnDevice(const acltdtQueueRouteQueryInfo *const queryInfo, const size_t routeNum,
        rtEschedEventSummary_t &eventSum, rtEschedEventReply_t &ack, acltdtQueueRouteList *const qRouteList) const;

    QueueDataMutexPtr GetMutexForData(const uint32_t qid);
    void DeleteMutexForData(const uint32_t qid);

    uint64_t GetTimestamp() const;

    aclError GetDeviceId(int32_t& deviceId) const;

    virtual aclError acltdtEnqueueData(const uint32_t qid, const void *const data, const size_t dataSize,
        const void *const userData, const size_t userDataSize, const int32_t timeout, const uint32_t rsv);

    aclError acltdtDequeueData(const uint32_t qid, void *const data, const size_t dataSize, size_t *const retDataSize,
        void *const userData, const size_t userDataSize, const int32_t timeout);

    // set queue attr to default,depth is 8,name is empty
    static void acltdtSetDefaultQueueAttr(acltdtQueueAttr &attr);

    aclError acltdtCreateQueueWithAttr(const int32_t deviceId, const acltdtQueueAttr *const attr,
        uint32_t *const qid) const;

    QueueProcessor() = default;
    virtual ~QueueProcessor() = default;

    // not allow copy constructor and assignment operators
    QueueProcessor(const QueueProcessor &) = delete;

    QueueProcessor &operator=(const QueueProcessor &) = delete;

    QueueProcessor(QueueProcessor &&) = delete;

    QueueProcessor &&operator=(QueueProcessor &&) = delete;

protected:
    std::recursive_mutex muForQueueCtrl_;
    std::mutex muForQueryGroup_;
    std::mutex muForQueueMap_;
    std::mutex muForCreateGroup_;
    std::map<uint32_t, QueueDataMutexPtr> muForQueue_;
    bool isQsInit_ = false;
    uint32_t qsContactId_ = 0U;
    int32_t qsGroupId_ = 0;
    static bool isInitQs_;
    static bool isMbufInit_;
    // new mbuf version is enhanced, mbuf can not be operated after enqueue
    bool isMbufEnhanced_ = false;
};
}
#endif // QUEUE_PROCESS_H
