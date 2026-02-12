/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "queue_schedule_stub.h"

namespace {
    std::mutex g_qnameToQidMutex;
    std::map<std::string, uint32_t> g_qnameToQid;

    std::mutex g_qidToValueMutex;
    std::map<uint32_t, std::vector<int32_t>> g_qidToValue;
    std::map<uint32_t, uint32_t> g_qidToIndex;
    std::map<uint32_t, int32_t> g_qidToDepth;
    std::condition_variable g_dataScheduleCv;
    std::map<uint32_t, std::vector<std::pair<std::shared_ptr<HeadBuf>, uint32_t>>> g_qidToValueWithTransId;

    std::mutex g_dataSubscribeVecMutex;
    std::vector<uint32_t> g_dataSubscribeVec;

    std::mutex g_f2NFSubcribeVecMutex;
    std:: vector<uint32_t> g_f2NFSubcribeVec;

    bqs::EntityInfo g_notFullQ(0U, 0U);

    MsgProcCallback g_msgProc;
    struct EzcomResponse g_resp;
    char* g_respData;

    constexpr uint32_t RELATION_QID = 10000;
    constexpr uint32_t FULL_TO_NOT_FULL_QID = 10001;
    constexpr uint32_t HCCL_RECV_QUEUE_QID = 10002;
    constexpr uint32_t ASYNC_MEM_DE_QUEUE_QID = 20005;
    constexpr uint32_t ASYNC_MEM_EN_QUEUE_QID = 20006;

    uint32_t COMM_CHANNEL_QUEUE_QID_START = 10003;
    uint32_t g_f2NFQid = 0;
    uint32_t g_tagMbuf = 256U;
}

std::vector<uint32_t> &GetSubscribedData() {
    return g_dataSubscribeVec;
}

void ClearStock() {
    std::unique_lock<std::mutex> idLock(g_qidToValueMutex);
    std::unique_lock<std::mutex> nameLock(g_qnameToQidMutex);
    std::unique_lock<std::mutex> dataLock(g_dataSubscribeVecMutex);
    std::unique_lock<std::mutex> f2NFLock(g_f2NFSubcribeVecMutex);

    g_qidToValue.clear();
    g_qidToValueWithTransId.clear();
    g_qidToIndex.clear();
    g_qidToDepth.clear();
    g_qnameToQid.clear();
    g_dataSubscribeVec.clear();
    g_f2NFSubcribeVec.clear();
}

/**
* Exception function when pipe is broken.
* @return NA
*/
void PipBrokenException(int fd, void* data)
{
    if (data == nullptr) {
        std::cout << "Pip of client and server has been closed. fd" << fd << std::endl;
    }
}

void DestroyResponseFake(struct EzcomResponse *resp)
{
    std::cout << "DestroyResponse stub begin" << std::endl;
    delete [] resp->data;
    return;
}

int EzcomRegisterServiceHandlerFake(int fd, void(*handler)(int, struct EzcomRequest *))
{
    std::cout << "EzcomRegisterServiceHandler stub begin, fd:" << fd << std::endl;
    // server
    if (fd == 0) {
        std::cout << "server EzcomRegisterServiceHandler stub begin, fd:" << fd << std::endl;
        g_msgProc = handler;
    } else {
        std::cout << "client EzcomRegisterServiceHandler stub begin, fd:" << fd << std::endl;
    }
    return 0;
}

int EzcomCfgInitServerFake(EzcomPipeServerAttr *attr)
{
    std::cout << "default EzcomCfgInitServer stub" << std::endl;
    EzcomCallBack fun = reinterpret_cast<EzcomCallBack>(attr->callback);
    char test[] = "testClent";
    fun(0, &test[0U], 9);
    return 0;
}

int EzcomCreateServerFake(const struct EzcomServerAttr *attr)
{
    std::cout << "default EzcomCreateServer stub" << std::endl;
    if ((attr != nullptr) && (attr->handler != nullptr)) {
    g_msgProc = attr->handler;
    }
    return 0;
}

int EzcomRPCSyncFake(int fd, struct EzcomRequest *req, struct EzcomResponse *resp)
{
    std::cout << "EzcomRPCSync stub begin" << std::endl;
    (*g_msgProc)(fd, req);
    *resp = g_resp;
    std::cout << "EzcomRPCSync stub end" << std::endl;
    return 0;
}

int EzcomSendResponseFake(int fd, struct EzcomResponse *resp)
{
    std::cout << "EzcomSendResponse stub begin, resp[id:" << resp->id << ", size:" << resp->size << ", data:"
        << (const void*)resp->data << "]" << std::endl;
    g_respData = new char[resp->size];
    memset(g_respData, 0, resp->size);
    memcpy(g_respData, (char*)resp->data, resp->size);
    g_resp = *resp;
    g_resp.data = (uint8_t*)g_respData;
    std::cout << "EzcomSendResponse stub end, g_resp[id:" << g_resp.id << ", size:" << g_resp.size << ", data:"
        << (const void*)g_resp.data << "]" << std::endl;
    return 0;
}

bool CheckDataSubcribeEmpty()
{
    bool ret = true;
    std::unique_lock<std::mutex> lock(g_dataSubscribeVecMutex);
    for (size_t i = 0; i < g_dataSubscribeVec.size(); i++) {
        // check g_qidToValue
        auto qidToValIter = g_qidToValue.find(g_dataSubscribeVec[i]);
        if (qidToValIter != g_qidToValue.end()) {
            if (qidToValIter->second.size() - g_qidToIndex[g_dataSubscribeVec[i]] > 0) {
                std::cout << "CheckDataSubcribeEmpty success, queue id:" << g_dataSubscribeVec[i] <<
                    " has element size:" << qidToValIter->second.size() - g_qidToIndex[g_dataSubscribeVec[i]]
                    << std::endl;
                ret = false;
            }
        }
        // check g_qidToValueWithTransId
        auto iter = g_qidToValueWithTransId.find(g_dataSubscribeVec[i]);
        if (iter != g_qidToValueWithTransId.end()) {
            if (iter->second.size() - g_qidToIndex[g_dataSubscribeVec[i]] > 0) {
                std::cout << "CheckDataSubcribeEmpty success, queue id:" << g_dataSubscribeVec[i] <<
                    " has element size:" << iter->second.size() - g_qidToIndex[g_dataSubscribeVec[i]]
                    << std::endl;
                ret = false;
            } else {
                std::cout << "CheckDataSubscribeEmpty failed, queue id:" << g_dataSubscribeVec[i] << endl;
            }
        } else {
            std::cout << "queue not exist. queue id:" << g_dataSubscribeVec[i] << endl;
        }
    }
    return ret;
}

drvError_t halEschedWaitEventFake(unsigned int devId, unsigned int grpId,
                        unsigned int threadId, int timeout, struct event_info *event)
{
    std::cout << "halEschedWaitEvent stub begin" << std::endl;
    if (threadId == 0 && grpId == 0) {
        // data enqueue
        std::unique_lock<std::mutex> lock(g_qidToValueMutex);
        std::cout << "halEschedWaitEvent data thread is waiting..." << std::endl;
        bool waitRet = g_dataScheduleCv.wait_for(lock, std::chrono::milliseconds(100),
            []{ return !CheckDataSubcribeEmpty();});
        //event->comm.event_id = EVENT_QUEUE_ENQUEUE;

        if (!waitRet) {
            std::cout << "halEschedWaitEvent data thread wait time out end..." << std::endl;
            return DRV_ERROR_SCHED_WAIT_TIMEOUT;
        } else {
            event->comm.event_id = EVENT_QUEUE_ENQUEUE;
            std::cout << "halEschedWaitEvent data thread wait get data end..." << std::endl;
        }

    }

    std::cout << "halEschedWaitEvent stub end, begin to process event" << std::endl;
    return DRV_ERROR_NONE;
}

void F2NFThreadTaskFake(bqs::QueueSchedule *queue, uint32_t threadIndex, uint32_t bindCpuIndex, uint32_t groupId)
{
    std::cout << "F2NFThreadTaskFake stub begin" << std::endl;
    return;
    std::cout << "F2NFThreadTaskFake stub end" << std::endl;
}

drvError_t halQueueCreateFake(unsigned int devid, const QueueAttr *queAttr, unsigned int *qid)
{
    std::string qname = queAttr->name;
    uint32_t tmpId = 0;
    std::cout << "halQueueCreate stub begin name:" << qname << std::endl;

    if (qname.substr(0, 15) == RELATION_QUEUE_NAME) {
        tmpId = RELATION_QID;
    } else if (qname.substr(0, 11) == F2NF_QUEUE_NAME) {
        tmpId = FULL_TO_NOT_FULL_QID;
    } else if (qname.substr(0, 15) == HCCL_RECV_QUEUE_NAME) {
        tmpId = HCCL_RECV_QUEUE_QID;
    } else if (qname.substr(0, 17) == COMM_CHANNEL_QUEUE_NAME_PREFIX) {
        tmpId = COMM_CHANNEL_QUEUE_QID_START++;
        qname = std::to_string(tmpId);
        std::cout << "halQueueCreate qname:" << qname << ", queue id:"<< tmpId << ", depth:" << queAttr->depth << std::endl;
    } else if (qname.substr(0, 21) == ASYNC_MEM_BUFF_DEQ_QUEUE_NAME) {
        tmpId = ASYNC_MEM_DE_QUEUE_QID;
    } else if (qname.substr(0, 21) == ASYNC_MEM_BUFF_ENQ_QUEUE_NAME) {
        tmpId = ASYNC_MEM_EN_QUEUE_QID;
    } else {
        tmpId = (uint32_t)std::stoi(std::string(qname));
    }

    std::unique_lock<std::mutex> lock(g_qnameToQidMutex);
    auto qnameToQidIter = g_qnameToQid.find(qname);
    if (qnameToQidIter != g_qnameToQid.end()) {
        std::cout << "create queue error, queue:" << qname << "already exist." << std::endl;
        return DRV_ERROR_NO_DEVICE;  
    }

    g_qnameToQid[qname] = tmpId;
    g_qidToDepth[tmpId] = queAttr->depth;
    std::cout << "halQueueCreate qname:" << qname << ", queue id:"<< tmpId
        << ", depth:" << queAttr->depth << " success" << std::endl;

    std::unique_lock<std::mutex> vlock(g_qidToValueMutex);
    g_qidToValue.insert(std::make_pair(tmpId, std::vector<int32_t>()));
    g_qidToValue[tmpId].reserve(100);
    g_qidToIndex.insert(std::make_pair(tmpId, 0));
    *qid = tmpId;
    return DRV_ERROR_NONE;
}

drvError_t halQueueCreateWithTransId(unsigned int devid, const QueueAttr *queAttr, unsigned int *qid)
{
    std::string qname = queAttr->name;
    uint32_t tmpId = (uint32_t)std::stoi(std::string(queAttr->name));

    std::unique_lock<std::mutex> lock(g_qnameToQidMutex);
    auto qnameToQidIter = g_qnameToQid.find(qname);
    if (qnameToQidIter != g_qnameToQid.end()) {
        std::cout << "create queue error, queue:" << qname << "already exist." << std::endl;
        return DRV_ERROR_NO_DEVICE;
    }

    g_qnameToQid[qname] = tmpId;
    g_qidToDepth[tmpId] = queAttr->depth;
    std::cout << "halQueueCreate qname:" << qname << ", queue id:"<< tmpId
        << ", depth:" << queAttr->depth << " success" << std::endl;

    std::unique_lock<std::mutex> vlock(g_qidToValueMutex);
    g_qidToValueWithTransId.insert(std::make_pair(tmpId, std::vector<std::pair<std::shared_ptr<HeadBuf>, uint32_t>>()));
    g_qidToValueWithTransId[tmpId].reserve(100);
    g_qidToIndex.insert(std::make_pair(tmpId, 0));
    *qid = tmpId;
    std::cout << "g_qidToValueWithTransId size:" << g_qidToValueWithTransId.size() << std::endl;
    return DRV_ERROR_NONE;
}

drvError_t halQueueSubscribeFake(unsigned int devid, unsigned int qid, unsigned int groupId, int type)
{
    std::cout << "halQueueSubscribe stub begin qid " << qid << std::endl;
    std::unique_lock<std::mutex> lock(g_dataSubscribeVecMutex);
    auto iter = find(g_dataSubscribeVec.begin(), g_dataSubscribeVec.end(), qid);
    if (iter != g_dataSubscribeVec.end()) {
        return DRV_ERROR_QUEUE_RE_SUBSCRIBED;
    }
    g_dataSubscribeVec.push_back(qid);
    std::cout << "halQueueSubscribe stub, g_dataSubscribeVec push " << qid << " success" << std::endl;
    return DRV_ERROR_NONE;
}

drvError_t halQueueUnsubscribeFake(unsigned int devid, unsigned int qid)
{
    std::cout << "halQueueUnsubscribe stub begin" << std::endl;
    std::unique_lock<std::mutex> lock(g_dataSubscribeVecMutex);
    auto iter = find(g_dataSubscribeVec.begin(), g_dataSubscribeVec.end(), qid);
    if (iter != g_dataSubscribeVec.end()) {
        g_dataSubscribeVec.erase(iter);
    }
    std::cout << "halQueueUnsubscribe stub, g_dataSubscribeVec erase " << qid << " success" << std::endl;
    return DRV_ERROR_NONE;
}

drvError_t halQueueSubF2NFEventFake(unsigned int devid, unsigned int qid, unsigned int groupid)
{
    std::cout << "halQueueSubF2NFEvent stub begin" << std::endl;
    std::unique_lock<std::mutex> lock(g_f2NFSubcribeVecMutex);
    auto iter = find(g_f2NFSubcribeVec.begin(), g_f2NFSubcribeVec.end(), qid);
    if (iter != g_f2NFSubcribeVec.end()) {
        return DRV_ERROR_QUEUE_RE_SUBSCRIBED;
    }
    g_f2NFSubcribeVec.push_back(qid);
    std::cout << "halQueueSubF2NFEvent stub, g_f2NFSubcribeVec push " << qid << " success" << std::endl;
    return DRV_ERROR_NONE;
}

drvError_t halQueueUnsubF2NFEventFake(unsigned int devid, unsigned int qid)
{
    std::cout << "halQueueUnsubF2NFEvent stub begin" << std::endl;
    std::unique_lock<std::mutex> lock(g_f2NFSubcribeVecMutex);
    auto iter = find(g_f2NFSubcribeVec.begin(), g_f2NFSubcribeVec.end(), qid);
    if (iter != g_f2NFSubcribeVec.end()) {
        g_f2NFSubcribeVec.erase(iter);
    }
    std::cout << "halQueueUnsubF2NFEvent stub, g_f2NFSubcribeVec erase " << qid << " success" << std::endl;
    return DRV_ERROR_NONE;
}

drvError_t halQueueSubEventFake(struct QueueSubPara *subPara) {
    return (subPara->eventType == QUEUE_ENQUE_EVENT) ?
        halQueueSubscribeFake(subPara->devId, subPara->qid, subPara->groupId, QUEUE_TYPE_GROUP) :
        halQueueSubF2NFEventFake(subPara->devId, subPara->qid, subPara->groupId);
}

drvError_t halQueueUnsubEventFake(struct QueueUnsubPara *unsubPara)
{
    return (unsubPara->eventType == QUEUE_ENQUE_EVENT) ?
        halQueueUnsubscribeFake(unsubPara->devId, unsubPara->qid) :
        halQueueUnsubF2NFEventFake(unsubPara->devId, unsubPara->qid);
}

int DestroyBuffQueueFake(unsigned int devId, unsigned int qid)
{
    std::cout << "halQueueDestroy stub begin, queue id:" << qid << std::endl;
    {
        std::unique_lock<std::mutex> lock(g_qnameToQidMutex);
        auto qnameToQidIter = g_qnameToQid.find(std::to_string(qid));
        if (qnameToQidIter != g_qnameToQid.end()) {
            g_qnameToQid.erase(qnameToQidIter);
        }
    }

    std::unique_lock<std::mutex> lock(g_qidToValueMutex);
    auto qidToValIter = g_qidToValue.find(qid);
    if (qidToValIter != g_qidToValue.end()) {
        qidToValIter->second.clear();
    }
    auto qidToIdxIter = g_qidToIndex.find(qid);
    if (qidToIdxIter != g_qidToIndex.end()) {
        g_qidToIndex.erase(qidToIdxIter);
    }
    return DRV_ERROR_NONE;
}

int MbufAllocFake(unsigned int size, Mbuf **mbuf)
{
    std::cout << "halMbufAlloc stub begin, size is " << size << std::endl;
    if (size == sizeof(uint32_t)) {
        *(uint32_t **) mbuf = &g_f2NFQid;
    } else if (size == sizeof(bqs::EntityInfo)) {
        *(bqs::EntityInfo **) mbuf = &g_notFullQ;
        std::cout << "halMbufAlloc stub success, mbuf value is g_notFullQ." << std::endl;
    } else {
        *(uint32_t **) mbuf = &g_tagMbuf;
        std::cout << "halMbufAlloc stub success, mbuf value is " << **(uint32_t **) mbuf << std::endl;
    }
    return DRV_ERROR_NONE;
}

int MbufCopyFake(Mbuf *mbuf, Mbuf **newMbuf)
{
    std::cout << "MbufCopy stub begin" << std::endl;
    *(int32_t**)newMbuf = (int32_t*)mbuf;
    return DRV_ERROR_NONE;
}

int MbufCopyRefFake(Mbuf *mbuf, Mbuf **newMbuf)
{
    std::cout << "halMbufCopyRef stub begin" << std::endl;
    *(int32_t**)newMbuf = (int32_t*)mbuf;
    return DRV_ERROR_NONE;
}

int GetQueueStatusFake(unsigned int devid, unsigned int qid, QUEUE_QUERY_ITEM queryItem, unsigned int len,  void *data)
{
    std::unique_lock<std::mutex> lock(g_qidToValueMutex);
    std::cout << "halQueueGetStatus stub begin, queue id:" << qid << ",queryItem:" << queryItem << std::endl;
    auto qidToValIter = g_qidToValue.find(qid);
    auto qidToValIter2 = g_qidToValueWithTransId.find(qid);
    if (qidToValIter == g_qidToValue.end() && qidToValIter2 == g_qidToValueWithTransId.end()) {
        std::cout << "halQueueGetStatus error, queue:" << qid << " does not exist." << std::endl;
        return 200;
    }

    if (queryItem != QUERY_QUEUE_STATUS) {
        int32_t *depth = (int32_t *)data;
        *depth = g_qidToDepth[qid];
        return DRV_ERROR_NONE;
    }
    size_t dataCount = (qidToValIter == g_qidToValue.end()) ?
        qidToValIter2->second.size() : qidToValIter->second.size();
    int32_t queueSize = dataCount - g_qidToIndex[qid];
    int32_t *status = (int32_t *)data;
    if (queueSize <= 0) {
        *status = QUEUE_EMPTY;
    } else if (queueSize >= g_qidToDepth[qid]) {
        *status = QUEUE_FULL;
    } else {
        *status = QUEUE_NORMAL;
    }
    return DRV_ERROR_NONE;
}

int EnBuffQueueWithTransId(unsigned int devId, unsigned int qid, int32_t val, uint32_t transId)
{
    std::unique_lock<std::mutex> lock(g_qidToValueMutex);
    std::cout << "halQueueEnQueue stub begin, queue id:" << qid << std::endl;
    if (qid != RELATION_QID && qid != FULL_TO_NOT_FULL_QID && qid != HCCL_RECV_QUEUE_QID) {
        std::unique_lock<std::mutex> lock(g_qnameToQidMutex);
        auto qidToValIter = g_qnameToQid.find(std::to_string(qid));
        if (qidToValIter == g_qnameToQid.end()) {
            std::cout << "enqueue error, queue:" << qid << " does not exist." << std::endl;
            return DRV_ERROR_NOT_EXIST;
        }
    }

    if (g_qidToValueWithTransId[qid].size() - g_qidToIndex[qid] >= static_cast<size_t>(g_qidToDepth[qid])) {
        std::cout << "halQueueEnQueue stub failed, queue id:" << qid << ", size:"
            << g_qidToValue[qid].size()- g_qidToIndex[qid]
            << ", depth:" << g_qidToDepth[qid] << ", is full." << std::endl;
        return DRV_ERROR_QUEUE_FULL;
    }

    std::shared_ptr<HeadBuf> headBuf = std::make_shared<HeadBuf>();
    headBuf->info.transId = transId;
    g_qidToValueWithTransId[qid].push_back(std::make_pair(headBuf, val));
    g_dataScheduleCv.notify_one();
    std::cout << "halQueueEnQueue stub success, queue id:" << qid << ", val:" << val <<
        ", size:" << g_qidToValueWithTransId[qid].size() - g_qidToIndex[qid] << std::endl;
    return DRV_ERROR_NONE;
}

int EnBuffQueueFake(unsigned int devId, unsigned int qid, void *mbuf)
{
    std::unique_lock<std::mutex> lock(g_qidToValueMutex);
    std::cout << "halQueueEnQueue stub begin, queue id:" << qid << std::endl;
    if (qid != RELATION_QID && qid != FULL_TO_NOT_FULL_QID && qid != HCCL_RECV_QUEUE_QID) {
        std::unique_lock<std::mutex> lock(g_qnameToQidMutex);
        auto qidToValIter = g_qnameToQid.find(std::to_string(qid));
        if (qidToValIter == g_qnameToQid.end()) {
            std::cout << "enqueue error, queue:" << qid << " does not exist." << std::endl;
            return DRV_ERROR_NOT_EXIST;
        }
    }

    if (g_qidToValue.find(qid) != g_qidToValue.end()) {
        if (g_qidToValue[qid].size() - g_qidToIndex[qid] >= static_cast<size_t>(g_qidToDepth[qid])) {
            std::cout << "halQueueEnQueue stub failed, queue id:" << qid << ", size:"
                << g_qidToValue[qid].size()- g_qidToIndex[qid]
                << ", depth:" << g_qidToDepth[qid] << ", is full." << std::endl;
            return DRV_ERROR_QUEUE_FULL;
        }
        int32_t val = 0;
        if (qid != RELATION_QID) {
            val = *(int32_t*)mbuf;
        }
        g_qidToValue[qid].push_back(val);
        std::cout << "halQueueEnQueue stub success, queue id:" << qid << ", val:" << val <<
            ", size:" << g_qidToValue[qid].size() - g_qidToIndex[qid] << std::endl;
    } else {
        if (g_qidToValueWithTransId[qid].size() - g_qidToIndex[qid] >= static_cast<size_t>(g_qidToDepth[qid])) {
            std::cout << "halQueueEnQueue stub failed, queue id:" << qid << ", size:"
                << g_qidToValueWithTransId[qid].size()- g_qidToIndex[qid]
                << ", depth:" << g_qidToDepth[qid] << ", is full." << std::endl;
            return DRV_ERROR_QUEUE_FULL;
        }
        std::pair<std::shared_ptr<HeadBuf>, uint32_t> val = *(std::pair<std::shared_ptr<HeadBuf>, uint32_t> *)mbuf;
        g_qidToValueWithTransId[qid].push_back(val);
        std::cout << "halQueueEnQueue stub success, queue id:" << qid << ", transId:" << val.first->info.transId <<
            ", val:" << val.second << ", size:" << g_qidToValueWithTransId[qid].size() - g_qidToIndex[qid] << std::endl;
    }

    g_dataScheduleCv.notify_one();
    return DRV_ERROR_NONE;
}

drvError_t halQueueDeQueueFake(unsigned int devId, unsigned int qid, void **mbuf)
{
    std::unique_lock<std::mutex> lock(g_qidToValueMutex);
    std::cout << "halQueueDeQueue stub begin, queue id:" << qid << std::endl;
    auto qidToValIter = g_qidToValue.find(qid);
    auto qidToValIter2 = g_qidToValueWithTransId.find(qid);
    if (qidToValIter == g_qidToValue.end() && qidToValIter2 == g_qidToValueWithTransId.end()) {
        std::cout << "dequeue error, queue:" << qid << " does not exist." << std::endl;
        return DRV_ERROR_NO_DEVICE;
    }

    size_t dataCount = (qidToValIter != g_qidToValue.end()) ? qidToValIter->second.size() : qidToValIter2->second.size();
    if (dataCount - g_qidToIndex[qid] == 0) {
        std::cout << "dequeue error, queue:" << qid << " is empty." << std::endl;
        return DRV_ERROR_QUEUE_EMPTY;
    }

    {
        std::unique_lock<std::mutex> lock(g_f2NFSubcribeVecMutex);
        for (size_t i = 0; i < g_f2NFSubcribeVec.size(); i++) {
            if (g_f2NFSubcribeVec[i] == qid && dataCount - g_qidToIndex[qid] >=
                    static_cast<size_t>(g_qidToDepth[qid])) {
                std::cout << "halQueueDeQueueFake stub, queue[id:" << qid << ", size:" << dataCount
                    << ", depth:" << g_qidToDepth[qid] <<"], full to not full."<< std::endl;
                g_qidToValue[FULL_TO_NOT_FULL_QID].push_back(qid);
            }
        }
    }

    if (qidToValIter != g_qidToValue.end()) {
        if(qid == FULL_TO_NOT_FULL_QID) {
            int32_t tempQid = (qidToValIter->second)[g_qidToIndex[qid]];
            bqs::EntityInfo notFullQ(tempQid, 0U);
            g_notFullQ = notFullQ;
            *(bqs::EntityInfo**)mbuf = &g_notFullQ;
        } else {
            *(int32_t**)mbuf = &(qidToValIter->second)[g_qidToIndex[qid]];
        }
        int32_t val = (qidToValIter->second)[g_qidToIndex[qid]];
        g_qidToIndex[qid]++;
        std::cout << "halQueueDeQueue stub success, queue id:" << qid << ", val:" << val <<
            ", size:" << (qidToValIter->second).size() - g_qidToIndex[qid] <<
            ", depth:" <<  g_qidToDepth[qid] << std::endl;
    } else {
        *(std::pair<std::shared_ptr<HeadBuf>, uint32_t>**)mbuf = &(qidToValIter2->second)[g_qidToIndex[qid]];
        auto &pair = (qidToValIter2->second)[g_qidToIndex[qid]];
        g_qidToIndex[qid]++;
        std::cout << "halQueueDeQueue stub success, queue id:" << qid << ", val:" << pair.second <<
            ", transId:" << pair.first->info.transId << ", size:" << (qidToValIter2->second).size() - g_qidToIndex[qid] <<
            ", depth:" <<  g_qidToDepth[qid] << std::endl;
    }
    return DRV_ERROR_NONE;
}

int32_t halMbufGetBuffAddrFake(Mbuf *mbuf, void **buf)
{
    std::cout << "queue_schedule_stub halMbufGetBuffAddr stub begin" << std::endl;
    *(int32_t **)buf = (int32_t *)mbuf;
    std::cout << "queue_schedule_stub halMbufGetBuffAddr stub end, value is " << **(int32_t **)buf << std::endl;
    return DRV_ERROR_NONE;
}

int halMbufGetPrivInfoFake(Mbuf *mbuf,  void **priv, unsigned int *size)
{
    std::cout << "queue_schedule_stub halMbufGetPrivInfoFake stub begin" << std::endl;
    std::pair<std::shared_ptr<HeadBuf>, uint32_t> *buf = (std::pair<std::shared_ptr<HeadBuf>, uint32_t> *)mbuf;
    *((uint32_t *)size) = 256;
    *(HeadBuf **)(priv) = buf->first.get();
    uint64_t transId = ((HeadBuf *)(*priv))->info.transId;
    std::cout << "queue_schedule_stub halMbufGetPrivInfoFake stub end, size:" << *size
        << " , transId:" << transId << std::endl;
    return DRV_ERROR_NONE;
}

bqs::BqsStatus EnqueueRelationEventFake()
{
    int32_t ret = EnBuffQueueFake(0, RELATION_QID, nullptr);
    if (ret != DRV_ERROR_NONE) {
        std::cout << "halQueueEnQueue error, queue id:" << RELATION_QID << ", ret=" << ret << std::endl;
        return bqs::BQS_STATUS_DRIVER_ERROR;
    }
    return bqs::BQS_STATUS_OK;
}

void MockBindSuccess()
{
    MOCKER(&bqs::BindCpuUtils::BindAicpu).stubs().will(returnValue(0));
}


void QueuScheduleStub()
{
    MockBindSuccess();

    MOCKER(EzcomRegisterServiceHandler)
    .stubs()
    .will(invoke(EzcomRegisterServiceHandlerFake));

    MOCKER(EzcomCfgInitServer)
    .stubs()
    .will(invoke(EzcomCfgInitServerFake));
  
    MOCKER(EzcomCreateServer)
    .stubs()
    .will(invoke(EzcomCreateServerFake));

    MOCKER(EzcomRPCSync)
    .stubs()
    .will(invoke(EzcomRPCSyncFake));

    MOCKER(EzcomSendResponse)
    .stubs()
    .will(invoke(EzcomSendResponseFake));

    MOCKER(DestroyResponse)
    .stubs()
    .will(invoke(DestroyResponseFake));

    MOCKER(halEschedWaitEvent)
    .stubs()
    .will(invoke(halEschedWaitEventFake));

    MOCKER(halMbufGetBuffAddr)
    .stubs()
    .will(invoke(halMbufGetBuffAddrFake));

    MOCKER(halQueueDeQueue)
    .stubs()
    .will(invoke(halQueueDeQueueFake));

    MOCKER(halQueueEnQueue)
    .stubs()
    .will(invoke(EnBuffQueueFake));

    MOCKER(halMbufAlloc)
    .stubs()
    .will(invoke(MbufAllocFake));

    MOCKER(halMbufCopyRef)
    .stubs()
    .will(invoke(MbufCopyRefFake));

    MOCKER(halQueueCreate)
    .stubs()
    .will(invoke(halQueueCreateFake));

    MOCKER(halQueueSubscribe)
    .stubs()
    .will(invoke(halQueueSubscribeFake));

    MOCKER(halQueueSubEvent)
    .stubs()
    .will(invoke(halQueueSubEventFake));

    MOCKER(halQueueUnsubscribe)
    .stubs()
    .will(invoke(halQueueUnsubscribeFake));

    MOCKER(halQueueUnsubEvent)
    .stubs()
    .will(invoke(halQueueUnsubEventFake));

    MOCKER(halQueueSubF2NFEvent)
    .stubs()
    .will(invoke(halQueueSubF2NFEventFake));

    MOCKER(halQueueUnsubF2NFEvent)
    .stubs()
    .will(invoke(halQueueUnsubF2NFEventFake));

    MOCKER(halQueueDestroy)
    .stubs()
    .will(invoke(DestroyBuffQueueFake));

    MOCKER(halQueueGetStatus)
    .stubs()
    .will(invoke(GetQueueStatusFake));

    MOCKER_CPP(&bqs::QueueManager::EnqueueRelationEvent)
    .stubs()
    .will(invoke(EnqueueRelationEventFake));

    MOCKER_CPP(&bqs::QueueSchedule::F2NFThreadTask)
    .stubs()
    .will(invoke(F2NFThreadTaskFake));

    MOCKER_CPP(&bqs::RouterServer::ManageQsEvent)
    .stubs()
    .will(ignoreReturnValue());

    MOCKER_CPP(&bqs::RouterServer::InitRouterServer)
    .stubs()
    .will(returnValue(0));
    MOCKER_CPP(&bqs::RouterServer::BindMsgProc)
        .stubs()
        .will(ignoreReturnValue());
    MOCKER(::bqs::BindCpuUtils::InitSem)
        .stubs()
        .will(returnValue(0));
    MOCKER(::bqs::BindCpuUtils::WaitSem)
        .stubs()
        .will(returnValue(0));
    MOCKER(::bqs::BindCpuUtils::PostSem)
        .stubs()
        .will(returnValue(0));
    MOCKER(::bqs::BindCpuUtils::DestroySem)
        .stubs()
        .will(returnValue(0));
}

bool VerifyQueueSize(uint32_t qid, int32_t size)
{
    std::unique_lock<std::mutex> lock(g_qidToValueMutex);
    auto iter1 = g_qidToValue.find(qid);
    if (iter1 != g_qidToValue.end()) {
        return ((iter1->second.size() - g_qidToIndex[qid]) == static_cast<size_t>(size));
    }
    auto iter2 = g_qidToValueWithTransId.find(qid);
    if (iter2 != g_qidToValueWithTransId.end()) {
        return ((iter2->second.size() - g_qidToIndex[qid]) == static_cast<size_t>(size));
    }
    return false;
}