/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "dynamic_sched_mgr.hpp"
#include <securec.h>
#include "driver/ascend_hal.h"
#include "bqs_feature_ctrl.h"

namespace dgw {
namespace {
constexpr int32_t kMicrosecondToNanosecond = 1000;
constexpr int32_t kDynamicSchedDuration = 2000 * kMicrosecondToNanosecond; // 2ms
constexpr int32_t kRequestCacheNum = 3;
constexpr uint32_t KCoLocateNum = 2;
}

// 考虑合设flowgw场景，一个flowgw可能服务两个device，默认device0
DynamicSchedMgr &DynamicSchedMgr::GetInstance(uint32_t deviceId)
{
    uint32_t index = deviceId >= KCoLocateNum ? 0U : deviceId;
    static DynamicSchedMgr mgr[KCoLocateNum];
    return mgr[index];
}

FsmStatus DynamicSchedMgr::AddRootModelInfo(const RootModelInfo &rootModelInfo)
{
    const uint32_t rootModelId = rootModelInfo.rootModelId;
    const auto iter = rootModelInfos_.find(rootModelId);
    if (iter != rootModelInfos_.end()) {
        DGW_LOG_ERROR("Root model info has been added, rootModelId=%u.", rootModelId);
        return FsmStatus::FSM_FAILED;
    }
    (void)rootModelInfos_.emplace(rootModelId, rootModelInfo);
    return FsmStatus::FSM_SUCCESS;
}

void DynamicSchedMgr::DeleteQueue(const uint32_t globalLogicId, const uint32_t rootModelId)
{
    DynamicSchedDurationPrint();
    for (auto iter = rootModelInfos_.begin(); iter != rootModelInfos_.end(); iter++) {
        if ((iter->first == rootModelId) &&
            (iter->second.responseQue.globalLogicId == globalLogicId)) {
            (void)rootModelInfos_.erase(iter);
            return;
        }
    }
}


void DynamicSchedMgr::UpdateNodeId(const int32_t nodeId)
{
    nodeId_ = nodeId;
}

void DynamicSchedMgr::GenerateRequest(const std::vector<RequestInfo> &requests,
                                      const int32_t centerResponseQueIdx,
                                      dynamic::FlowgwRequest &flowgwRequest) const
{
    flowgwRequest.set_node_id(nodeId_);
    flowgwRequest.set_input_index(centerResponseQueIdx);
    for (const auto &request : requests) {
        for (const auto &decision : request.decisions) {
            for (const auto &dst : request.dsts) {
                auto queueInfo = flowgwRequest.add_queue_infos();
                queueInfo->set_logic_group_id(dst.logicGroupId);
                queueInfo->set_model_uuid(request.src.modelUuid);
                queueInfo->set_root_model_id(request.src.rootModelId);
                queueInfo->set_trans_id(decision.transId);
                queueInfo->set_route_label(decision.routeLabel);
                // Compatible for old version
                queueInfo->set_trans_id_old(static_cast<int32_t>(decision.transId));
                queueInfo->set_route_label_old(static_cast<int32_t>(decision.routeLabel));
                auto queueAttr = queueInfo->mutable_queue_attrs();
                queueAttr->set_queue_id(request.src.queueId);
                queueAttr->set_device_id(request.src.deviceId);
                queueAttr->set_logic_id(request.src.queueLogicId);
            }
        }
    }
}

FsmStatus DynamicSchedMgr::SendRequest(const uint32_t rootModelId,
                                       const std::vector<RequestInfo> &requests)
{
    // get root model info
    const auto iter = rootModelInfos_.find(rootModelId);
    if (iter == rootModelInfos_.end()) {
        DGW_LOG_ERROR("Root model info has not been added, rootModelId=%u.", rootModelId);
        return FsmStatus::FSM_FAILED;
    }
    // some requests will not be enqueue because result has been cached
    std::vector<RequestInfo> requestsAfterCache;
    SendRequestToCacheResult(requests, requestsAfterCache);

    if (requestSentNum_ > kRequestCacheNum) {
        for (auto &request : requestsAfterCache) {
            iter->second.requestCache.push_back(request);
        }
        return FsmStatus::FSM_SUCCESS;
    }
    // construct FlowgwRequest protobuf object
    auto cacheSize = iter->second.requestCache.size();
    dynamic::FlowgwRequest flowgwRequest;
    if (cacheSize == 0) {
        GenerateRequest(requestsAfterCache, iter->second.responseQue.globalLogicId, flowgwRequest);
    } else {
        GenerateRequest(iter->second.requestCache, iter->second.responseQue.globalLogicId, flowgwRequest);
        GenerateRequest(requestsAfterCache, iter->second.responseQue.globalLogicId, flowgwRequest);
    }
    if (flowgwRequest.queue_infos_size() == 0U) {
        return FsmStatus::FSM_SUCCESS;
    }

    const auto enqueueRet = EnqueueRequest(flowgwRequest, iter->second.requestQue.deviceId,
                                           iter->second.requestQue.queueId);
    if (enqueueRet != FsmStatus::FSM_SUCCESS) {
        return enqueueRet;
    }
    iter->second.requestCache.clear();
    requestSentNum_++;
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus DynamicSchedMgr::EnqueueRequest(const dynamic::FlowgwRequest &flowgwRequest,
                                          const uint32_t deviceId, const uint32_t queueId) const
{
    const auto reqSize = flowgwRequest.ByteSizeLong();
    Mbuf *mbuf = nullptr;
    auto drvRet = halMbufAlloc(reqSize, &mbuf);
    if (drvRet != DRV_ERROR_NONE) {
        DGW_LOG_ERROR("halMbufAlloc failed, drvRet=%d, dataSize=%lu.", drvRet, reqSize);
        return FsmStatus::FSM_FAILED;
    }
    auto mbufDeleter = [](Mbuf *buf) { (void)halMbufFree(buf); };
    std::unique_ptr<Mbuf, decltype(mbufDeleter)> mbufGuard(mbuf, mbufDeleter);
    drvRet = halMbufSetDataLen(mbuf, reqSize);
    if (drvRet != DRV_ERROR_NONE) {
        DGW_LOG_ERROR("halMbufSetDataLen failed, drvRet=%d, dataSize=%lu.", drvRet, reqSize);
        return FsmStatus::FSM_FAILED;
    }
    // write data
    void *buffAddr = nullptr;
    drvRet = halMbufGetBuffAddr(mbuf, &buffAddr);
    if (drvRet != DRV_ERROR_NONE || buffAddr == nullptr) {
        DGW_LOG_ERROR("Failed to get buff addr, ret[%d].", drvRet);
        return FsmStatus::FSM_FAILED;
    }
    flowgwRequest.SerializeToArray(buffAddr, static_cast<int32_t>(reqSize));
    // enqueue
    drvRet = halQueueEnQueue(deviceId, queueId, mbuf);
    if (drvRet == DRV_ERROR_QUEUE_FULL) {
        return FsmStatus::FSM_DEST_FULL;
    } else if (drvRet != DRV_ERROR_NONE) {
        DGW_LOG_ERROR("Failed to enqueue mbuf, ret[%d].", drvRet);
        return FsmStatus::FSM_FAILED;
    }
    PrintRequestLog(flowgwRequest);
    mbufGuard.release();
    return FsmStatus::FSM_SUCCESS;
}

void DynamicSchedMgr::PrintRequestLog(const dynamic::FlowgwRequest &flowgwRequest) const
{
    if (!bqs::HostQsLog::GetInstance().CheckLogLevel(static_cast<int32_t>(AICPU), DLOG_INFO)) {
        return;
    }
    const int32_t queue_infos_size = flowgwRequest.queue_infos_size();
    for (int32_t queue_infos_index = 0; queue_infos_index < queue_infos_size; queue_infos_index++) {
        const auto &queue_info = flowgwRequest.queue_infos(queue_infos_index);
        DGW_LOG_INFO("Dynamic sched send request, node_id=%d, input_index=%d, queue_id=%u, device_type=%d, "
            "device_id=%d, logic_id=%u, logic_group_id=%u, model_uuid=%u, trans_id=%lu, route_label=%u, "
            "root_model_id=%u, queue_infos_index=%d.",
            flowgwRequest.node_id(), flowgwRequest.input_index(),
            queue_info.queue_attrs().queue_id(), queue_info.queue_attrs().device_type(),
            queue_info.queue_attrs().device_id(), queue_info.queue_attrs().logic_id(),
            queue_info.logic_group_id(), queue_info.model_uuid(), queue_info.trans_id(),
            queue_info.route_label(), queue_info.root_model_id(), queue_infos_index);
    }
}

void DynamicSchedMgr::PrintResponseLog(const dynamic::FlowgwResponse &flowgwResponse) const
{
    if (!bqs::HostQsLog::GetInstance().CheckLogLevel(static_cast<int32_t>(AICPU), DLOG_INFO)) {
        return;
    }
    const int32_t queue_infos_size = flowgwResponse.queue_infos_size();
    for (int32_t queue_infos_index = 0; queue_infos_index < queue_infos_size; queue_infos_index++) {
        const auto &queue_info = flowgwResponse.queue_infos(queue_infos_index);
        DGW_LOG_INFO("Dynamic sched get response, queue_id=%u, device_type=%d, "
            "device_id=%d, logic_id=%u, logic_group_id=%u, model_uuid=%u, trans_id=%lu, route_label=%u, "
            "choose_logic_id=%u, root_model_id=%u, queue_infos_index=%d, need_cache=%d.",
            queue_info.queue_attrs().queue_id(), queue_info.queue_attrs().device_type(),
            queue_info.queue_attrs().device_id(), queue_info.queue_attrs().logic_id(),
            queue_info.logic_group_id(), queue_info.model_uuid(), queue_info.trans_id(),
            queue_info.route_label(), queue_info.choose_logic_id(),
            queue_info.root_model_id(), queue_infos_index, static_cast<int32_t>(queue_info.need_cache()));
    }
}


FsmStatus DynamicSchedMgr::GetResponse(const uint32_t rootModelId,
                                       std::vector<ResponseInfo> &responses)
{
    // get root model info
    const auto iter = rootModelInfos_.find(rootModelId);
    if (iter == rootModelInfos_.end()) {
        return FsmStatus::FSM_SUCCESS;
    }
    GetResponseFromCacheResult(responses);

    auto cacheSize = iter->second.requestCache.size();
    if (requestSentNum_ == 0) {
        if (cacheSize != 0) {
            SendRequest(rootModelId, {});
        }
        return FsmStatus::FSM_SUCCESS;
    }
    // dequeue
    void *mbuf = nullptr;
    const auto ret = halQueueDeQueue(iter->second.responseQue.deviceId, iter->second.responseQue.queueId, &mbuf);
    if (ret == DRV_ERROR_NONE) {
        requestSentNum_--;
        // parse mbuf to FlowgwResponse
        auto mbufDeleter = [](Mbuf *buf) { (void)halMbufFree(buf); };
        std::unique_ptr<Mbuf, decltype(mbufDeleter)> mbufGuard(
            PtrToPtr<void, Mbuf>(mbuf) , mbufDeleter);
        dynamic::FlowgwResponse flowgwResponse;
        void *buffer_addr = nullptr;
        uint64_t buffer_size = 0U;
        if (halMbufGetBuffAddr(PtrToPtr<void, Mbuf>(mbuf), &buffer_addr) != DRV_ERROR_NONE) {
            DGW_LOG_ERROR("halMbufGetBuffAddr failed");
            return FsmStatus::FSM_FAILED;
        };
        if (halMbufGetBuffSize(PtrToPtr<void, Mbuf>(mbuf), &buffer_size) != DRV_ERROR_NONE) {
            DGW_LOG_ERROR("halMbufGetBuffAddr failed");
            return FsmStatus::FSM_FAILED;
        };
        google::protobuf::io::ArrayInputStream stream(buffer_addr, static_cast<int32_t>(buffer_size));
        if (!flowgwResponse.ParseFromZeroCopyStream(&stream)) {
            DGW_LOG_ERROR("Response ParseFromZeroCopyStream failed");
            return FsmStatus::FSM_FAILED;
        }
        PrintResponseLog(flowgwResponse);
        // write response data
        for (const auto &queueInfo : flowgwResponse.queue_infos()) {
            ResponseInfo responseInfo;
            responseInfo.src.queueId = queueInfo.queue_attrs().queue_id();
            responseInfo.src.queueLogicId = queueInfo.queue_attrs().logic_id();
            responseInfo.src.modelUuid = queueInfo.model_uuid();
            responseInfo.src.rootModelId = queueInfo.root_model_id();
            GroupResult groupResult;
            groupResult.logicGroupId = queueInfo.logic_group_id();
            groupResult.index = queueInfo.choose_logic_id();
            responseInfo.groupResults.emplace_back(std::move(groupResult));
            if (queueInfo.need_cache()) {
                UpdateCacheResult(responseInfo);
                continue;
            }
            responses.emplace_back(std::move(responseInfo));
        }

        if (requestSentNum_ == 0) {
            if (cacheSize != 0) {
                SendRequest(rootModelId, {});
            }
        }
    } else if (ret != DRV_ERROR_QUEUE_EMPTY) {
        DGW_LOG_ERROR("failed to dequeue, device_id = %u, queue_id = %u, ret = %d",
            iter->second.responseQue.deviceId, iter->second.responseQue.queueId, ret);
        return FsmStatus::FSM_FAILED;
    }
    GetResponseFromCacheResult(responses);
    return FsmStatus::FSM_SUCCESS;
}

FsmStatus DynamicSchedMgr::ClearCacheRouteResult()
{
    validCacheInfos_.clear();
    invalidCacheInfos_.clear();
    return FsmStatus::FSM_SUCCESS;
}

void DynamicSchedMgr::SendRequestToCacheResult(const std::vector<RequestInfo> &requests,
                                               std::vector<RequestInfo> &requestsAfterCache)
{
    for (const auto &request : requests) {
        RequestInfo requestAfterCache;
        requestAfterCache.src = request.src;
        requestAfterCache.decisions = request.decisions;
        for (const auto &dst : request.dsts) {
            CacheRouteKey key = {request.src, dst};
            const auto iterValidCache = validCacheInfos_.find(key);
            if (iterValidCache != validCacheInfos_.end()) {
                iterValidCache->second.num++;
                continue;
            }
            invalidCacheInfos_[key]++;
            requestAfterCache.dsts.emplace_back(dst);
        }
        if (requestAfterCache.dsts.empty()) {
            continue;
        }
        requestsAfterCache.emplace_back(std::move(requestAfterCache));
    }
}

void DynamicSchedMgr::UpdateCacheResult(const ResponseInfo &getResponseInfo)
{
    for (const auto &result : getResponseInfo.groupResults) {
        DstGroupInfo dstGroupInfo = {result.logicGroupId};
        CacheRouteKey key = {getResponseInfo.src, dstGroupInfo};
        const auto iterValidCache = validCacheInfos_.find(key);
        if (iterValidCache != validCacheInfos_.end()) {
            continue;
        }
        const auto iterInvalidCache = invalidCacheInfos_.find(key);
        if (iterInvalidCache != invalidCacheInfos_.end()) {
            CacheRouteValue cacheRouteValue = {result, iterInvalidCache->second};
            validCacheInfos_.emplace(key, std::move(cacheRouteValue));
            invalidCacheInfos_.erase(iterInvalidCache);
        }
    }
}

void DynamicSchedMgr::GetResponseFromCacheResult(std::vector<ResponseInfo> &responses)
{
    for (auto &cacheInfo : validCacheInfos_) {
        for (uint32_t index = 0U; index < cacheInfo.second.num; index++) {
            std::vector<GroupResult> groupResults;
            groupResults.emplace_back(cacheInfo.second.result);
            ResponseInfo response = {cacheInfo.first.srcQueueInfo, groupResults};
            responses.emplace_back(std::move(response));
            DGW_LOG_INFO("get response from cache result, root_model_id=%u, src queue_id=%u, " \
                "logic_id=%u, logic_group_id=%u, result_index=%u.",
                cacheInfo.first.srcQueueInfo.rootModelId, cacheInfo.first.srcQueueInfo.queueId,
                cacheInfo.first.srcQueueInfo.queueLogicId,
                cacheInfo.second.result.logicGroupId, cacheInfo.second.result.index);
        }
        cacheInfo.second.num = 0U;
    }
}

void DynamicSchedMgr::DynamicSchedDurationEnd(uint64_t begin)
{
    uint64_t duration = DynamicSchedNow() - begin;
    durationTotal_ += duration;
    if (duration > kDynamicSchedDuration) {
        durationSize_++;
    }
    if (duration > durationMax_) {
        durationMax_ = duration;
    }
    cntTotal_++;
}

void DynamicSchedMgr::DynamicSchedDurationPrint()
{
    BQS_LOG_RUN_INFO("DynamicSched, flowgw data: Total(us)=%lu, Cnt=%lu, Per duration(ns)=%lu, Max duration(ns)=%lu,"
        " Greater 2ms cnt=%lu", durationTotal_ / kMicrosecondToNanosecond, cntTotal_,
        (durationTotal_ / (cntTotal_ != 0ULL ? cntTotal_ : 1UL)), durationMax_, durationSize_);
    durationTotal_ = 0ULL;
    cntTotal_ = 0ULL;
    durationMax_ = 0ULL;
    durationSize_ = 0ULL;
    call_ = 0ULL;
}
}