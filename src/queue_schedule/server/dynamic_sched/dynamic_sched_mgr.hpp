/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef DYNAMIC_SCHED_MGR_H
#define DYNAMIC_SCHED_MGR_H

#include <vector>
#include <queue>
#include <unordered_map>
#include <map>
#include "queue_schedule/dgw_client.h"
#include "fsm/state_define.h"
#include "proto/dynamic_sched_message.pb.h"

namespace dgw{
class DynamicSchedMgr {
public:
    struct SrcQueueInfo {
        uint32_t queueId;
        int32_t deviceId;
        bool isProxy;
        uint32_t queueLogicId;
        uint32_t modelUuid;
        uint32_t rootModelId;
    };

    struct DstGroupInfo {
        uint32_t logicGroupId;
    };

    struct DecisionInfo {
        uint64_t transId;
        uint32_t routeLabel;
    };

    struct RequestInfo {
        SrcQueueInfo src;
        std::vector<DstGroupInfo> dsts;
        std::vector<DecisionInfo> decisions;
    };

    struct GroupResult {
        uint32_t logicGroupId;
        uint32_t index;
    };

    struct ResponseInfo {
        SrcQueueInfo src;
        std::vector<GroupResult> groupResults;
    };

    struct RootModelInfo {
        uint32_t rootModelId;
        bqs::DynamicSchedQueueAttr requestQue;
        bqs::DynamicSchedQueueAttr responseQue;
        std::vector<RequestInfo> requestCache;
    };

public:
    static DynamicSchedMgr &GetInstance(uint32_t deviceId = 0U);
    FsmStatus AddRootModelInfo(const RootModelInfo &rootModelInfo);
    void DeleteQueue(const uint32_t globalLogicId, const uint32_t rootModelId);
    void UpdateNodeId(const int32_t nodeId);
    FsmStatus SendRequest(const uint32_t rootModelId, const std::vector<RequestInfo> &requests);
    FsmStatus GetResponse(const uint32_t rootModelId, std::vector<ResponseInfo> &responses);
    FsmStatus ClearCacheRouteResult();
    static inline uint64_t DynamicSchedNow() {
        static auto zero = std::chrono::system_clock::now();
        auto us = std::chrono::duration_cast<std::chrono::nanoseconds>(
        std::chrono::system_clock::now() - zero).count();
        return uint64_t(us);
    }
    void DynamicSchedDurationEnd(uint64_t begin);
    void DynamicSchedDurationPrint();
private:
    struct CacheRouteKey {
        SrcQueueInfo srcQueueInfo;
        DstGroupInfo dstGroupInfo;
        bool operator<(const CacheRouteKey &other) const {
            if (srcQueueInfo.rootModelId < other.srcQueueInfo.rootModelId) {
                return true;
            }
            if ((srcQueueInfo.rootModelId == other.srcQueueInfo.rootModelId) &&
                (srcQueueInfo.queueLogicId < other.srcQueueInfo.queueLogicId)) {
                return true;
            }
            if ((srcQueueInfo.rootModelId == other.srcQueueInfo.rootModelId) &&
                (srcQueueInfo.queueLogicId == other.srcQueueInfo.queueLogicId) &&
                (dstGroupInfo.logicGroupId < other.dstGroupInfo.logicGroupId)) {
                return true;
            }
            return false;
        }
    };
    struct CacheRouteValue {
      GroupResult result;
      uint32_t num;
    };
    void GenerateRequest(const std::vector<RequestInfo> &requests,
                         const int32_t centerResponseQueIdx,
                         dynamic::FlowgwRequest &flowgwRequest) const;
    void PrintRequestLog(const dynamic::FlowgwRequest &flowgwRequest) const;
    void PrintResponseLog(const dynamic::FlowgwResponse &flowgwResponse) const;
    void SendRequestToCacheResult(const std::vector<RequestInfo> &requests, std::vector<RequestInfo> &requestsAfterCache);
    void UpdateCacheResult(const ResponseInfo &getResponseInfo);
    void GetResponseFromCacheResult(std::vector<ResponseInfo> &responses);
    FsmStatus EnqueueRequest(const dynamic::FlowgwRequest &flowgwRequest, const uint32_t deviceId, const uint32_t queueId) const;

    int32_t nodeId_;
    std::unordered_map<uint32_t, RootModelInfo> rootModelInfos_;
    std::map<CacheRouteKey, CacheRouteValue> validCacheInfos_;
    std::map<CacheRouteKey, uint32_t> invalidCacheInfos_;
    uint32_t requestSentNum_ = 0UL;
    uint64_t durationTotal_ = 0ULL;
    uint64_t cntTotal_ = 0ULL;
    uint64_t durationMax_ = 0ULL;
    uint64_t durationSize_ = 0ULL;
    uint64_t call_ = 0ULL;
};
}
#endif