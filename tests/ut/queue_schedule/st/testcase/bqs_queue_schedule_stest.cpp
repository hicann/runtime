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
#include <thread>
#include <chrono>
#include <set>
#include <stdlib.h>
#include "securec.h"
#include <semaphore.h>
#include "driver/ascend_hal_define.h"
#include "qs_client.h"
#include "bind_relation.h"
#include "queue_schedule.h"
#include "server/bind_cpu_utils.h"
#include "queue_manager.h"
#include "ProcMgrSysOperatorAgent.h"
#include "common/bqs_util.h"
#include "common/bqs_feature_ctrl.h"
#include "ezcom_client.h"

#define private public
#define protected public
#include "hccl/hccl_types_in.h"
#include "bqs_server.h"
#include "entity_manager.h"
#include "qs_interface_process.h"
#include "schedule_config.h"
#include "dynamic_sched_mgr.hpp"
#include "fsm/peek_state.h"
#include "fsm/push_state.h"
#include "hccl_process.h"
#include "subscribe_manager.h"
#undef private
#undef protected

using namespace std;
using namespace bqs;

namespace {
    // hccl handle
    uint64_t hcclHandle = 100UL;
    HcclComm hcclComm = &hcclHandle;

    int32_t g_totalEnvelopeCount = 0U;
    int HcclImprobeFake(int srcRank, int tag, HcclComm comm, int *flag, HcclMessage *msg, HcclStatus *status)
    {
        if (g_totalEnvelopeCount == 0U) {
            *flag = 0;
        } else {
            g_totalEnvelopeCount--;
            *flag = 1;
        }
        return 0;
    }

    bool g_link = false;
    int HcclGetCountFake(const HcclStatus *status, HcclDataType dataType, int *count)
    {
        if (g_link) {
            *count = 0;
            g_link = false;
        } else {
            *count = 1;
        }
        return 0;
    }

    int HcclImrecvFake(void *buffer, int count, HcclDataType datatype, HcclMessage *msg, HcclRequest *request)
    {
        int32_t req = 1;
        *request = reinterpret_cast<HcclRequest>(&req);
        return 0;
    }

    int HcclTestSomeFake(int count, HcclRequest requestArray[], int *compCount, int compIndices[], HcclStatus compStatus[])
    {
        *compCount = count;
        for (int i = 0; i < count; i++) {
            compIndices[i] = i;
            HcclStatus status;
            status.error = 0;
            compStatus[i] = status;
        }
        return 0;
    }
    int HcclTestSomeFakeFail(int count, HcclRequest requestArray[], int *compCount, int compIndices[], HcclStatus compStatus[])
    {
        *compCount = count;
        for (int i = 0; i < count; i++) {
            compIndices[i] = i;
            HcclStatus status;
            status.error = HCCL_E_ROCE_TRANSFER;
            compStatus[i] = status;
        }
        return HCCL_E_IN_STATUS;
    }
    errno_t CopyStub(void *dest, size_t destMax, const void *src, size_t count)
    {
        printf("Dst addr:%p, size:%zu, src addr:%p, size:%zu\n", dest, destMax, src, count);
        memcpy(dest, src, count);
        return EOK;
    }

    bool g_schedule_wait_fake_to_err = false;
    bool g_schedule_wait_fake_to_param_err = false;
    drvError_t halEschedWaitEventErrorOrTimeOut(unsigned int devId, unsigned int grpId,
        unsigned int threadId, int timeout, struct event_info *event)
    {
        usleep(10);
        if (g_schedule_wait_fake_to_err) {
            return DRV_ERROR_NO_DEVICE;
        } else if (g_schedule_wait_fake_to_param_err) {
            return DRV_ERROR_PARA_ERROR;
        } else {
            return DRV_ERROR_SCHED_WAIT_TIMEOUT;
        }
    }

    uint32_t g_dynamicResponseQ = 0U;
    dgw::FsmStatus DynamicGetResponseFake(dgw::DynamicSchedMgr *ptr, const uint32_t rootModelId,
        std::vector<dgw::DynamicSchedMgr::ResponseInfo> &responses)
    {
        std::cout << "DynamicGetResponseFake" << std::endl;
        void* realVal = nullptr;
        int ret = halQueueDeQueueFake(0, g_dynamicResponseQ, (void**)&realVal);
        if ((DRV_ERROR_NONE == ret) && (realVal != nullptr)) {
            dgw::DynamicSchedMgr::ResponseInfo dynamicResponse = {};
            dynamicResponse.src.queueLogicId = 6U;
            dynamicResponse.groupResults.emplace_back(dgw::DynamicSchedMgr::GroupResult{7U, 0U});
            dynamicResponse.groupResults.emplace_back(dgw::DynamicSchedMgr::GroupResult{8U, 1U});
            responses.emplace_back(dynamicResponse);
            return dgw::FsmStatus::FSM_SUCCESS;
        }
        return dgw::FsmStatus::FSM_FAILED;
    }
}

class BQS_QUEUE_SCHEDULE_STTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        cout << "Before bqs_relation_stest" << endl;
        MOCKER(bqs::GetRunContext).stubs().will(returnValue(bqs::RunContext::DEVICE));
        QueuScheduleStub();

        std::vector<uint32_t> aiCpuIds_;
        MOCKER(&QueueScheduleInterface::GetAiCpuIds).stubs().will(returnValue(aiCpuIds_));

        MOCKER(HcclImprobe)
            .stubs()
            .will(invoke(HcclImprobeFake));

        MOCKER(HcclGetCount)
            .stubs()
            .will(invoke(HcclGetCountFake));

        MOCKER(HcclImrecv)
            .stubs()
            .will(invoke(HcclImrecvFake));

        MOCKER(HcclTestSome)
            .stubs()
            .will(invoke(HcclTestSomeFake));

        MOCKER(memcpy_s)
            .stubs()
            .will(invoke(CopyStub));

        queueSchedule.qsInitGroupName_ = "Default";
        BindCpuUtils::GetDevCpuInfo(0, QueueScheduleInterface::GetInstance().aiCpuIds_,
                                    QueueScheduleInterface::GetInstance().ctrlCpuIds_,
                                    QueueScheduleInterface::GetInstance().coreNumPerDev_,
                                    QueueScheduleInterface::GetInstance().aicpuNum_,
                                    QueueScheduleInterface::GetInstance().aicpuBaseId_);
        queueSchedule.StartQueueSchedule();
    }

    virtual void TearDown()
    {
        cout << "After bqs_relation_stest" << endl;

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
        // std::queue<uint32_t> tmp;
        // g_f2NFDataQueue.swap(tmp);
        g_f2NFQid = 0;
        GlobalMockObject::verify();
    }

public:
    bqs::QueueSchedule queueSchedule{{0, 0, 1, 30U}};

    void QueueScheduleDestroy()
    {
        queueSchedule.StopQueueSchedule();
        queueSchedule.WaitForStop();
        DelAllBindRelation();
        queueSchedule.Destroy();
    }

    void AddBindRelation(const std::multimap<uint32_t, uint32_t>& srcDstMap, const int32_t expectRet,
        std::vector<bqs::BQSBindQueueResult>& bindResultVec)
    {
        std::vector<bqs::BQSBindQueueItem> bindQueueVec;
        for (auto iter = srcDstMap.begin(); iter != srcDstMap.end(); ++iter) {
            bqs::BQSBindQueueItem tmp = {srcQueueId_ : iter->first, dstQueueId_ : iter->second};
            bindQueueVec.push_back(tmp);
        }

        uint32_t result =
            bqs::BqsClient::GetInstance("test", 4, PipBrokenException)->BindQueue(bindQueueVec, bindResultVec);
        EXPECT_EQ(result, expectRet);
        return;
    }

    void AddBindRelation(EntityInfo &src, EntityInfo &dst)
    {
        auto ret = BindRelation::GetInstance().Bind(src, dst);
        EXPECT_EQ(ret, BQS_STATUS_OK);
        BindRelation::GetInstance().Order();
    }

    void DelBindRelation(const std::multimap<bqs::QsQueryType, bqs::BQSBindQueueItem>& keySrcDstMap,
        const int32_t expectRet, std::vector<bqs::BQSBindQueueResult>& bindResultVec)
    {
        std::vector<bqs::BQSQueryPara> bqsQueryParaVec;
        for (auto iter = keySrcDstMap.begin(); iter != keySrcDstMap.end(); ++iter) {
            bqs::BQSBindQueueItem tmpItem = iter->second;
            bqs::BQSQueryPara tmpPara = {keyType_ : iter->first, bqsBindQueueItem_ : tmpItem};
            bqsQueryParaVec.push_back(tmpPara);
        }
        uint32_t result =
            bqs::BqsClient::GetInstance("test", 4, PipBrokenException)->UnbindQueue(bqsQueryParaVec, bindResultVec);
        EXPECT_EQ(result, expectRet);
        return;
    }

    void GetBindRelation(const std::multimap<bqs::QsQueryType, bqs::BQSBindQueueItem>& keySrcDstMap,
        const int32_t expectRet, std::vector<bqs::BQSBindQueueItem>& getBindQueueResult)
    {
        std::vector<bqs::BQSQueryPara> bqsQueryParaVec;
        for (auto iter = keySrcDstMap.begin(); iter != keySrcDstMap.end(); ++iter) {
            bqs::BQSBindQueueItem tmpItem = iter->second;
            bqs::BQSQueryPara tmpPara = {keyType_ : iter->first, bqsBindQueueItem_ : tmpItem};
            bqsQueryParaVec.push_back(tmpPara);
        }

        uint32_t result = bqs::BqsClient::GetInstance("test", 4, PipBrokenException)
                              ->GetBindQueue(bqsQueryParaVec[0], getBindQueueResult);
        EXPECT_EQ(getBindQueueResult.size(), expectRet);
        EXPECT_EQ(result, expectRet);
        return;
    }

    void GetAllBindRelation(const int32_t expectRet, std::vector<bqs::BQSBindQueueItem>& getBindQueueResult)
    {
        uint32_t result =
            bqs::BqsClient::GetInstance("test", 4, PipBrokenException)->GetAllBindQueue(getBindQueueResult);
        EXPECT_EQ(result, expectRet);
        EXPECT_EQ(getBindQueueResult.size(), expectRet);
        return;
    }

    void DelAllBindRelation()
    {
        std::vector<std::tuple<bqs::EntityInfo, bqs::EntityInfo>> allRelation;
        auto& bindRelation = bqs::BindRelation::GetInstance();
        auto& dstToSrcRelation = bindRelation.GetDstToSrcRelation();
        for (auto& relation : dstToSrcRelation) {
            const auto &dstId = relation.first;
            ClearEntity(dstId);
            for (auto srcId : relation.second){
                ClearEntity(srcId);
                allRelation.emplace_back(std::make_tuple(srcId, dstId));
            }
        }

        for (auto& relation : allRelation) {
            auto &srcId = std::get<0>(relation);
            auto &dstId = std::get<1>(relation);
            bqs::BqsStatus ret = bindRelation.UnBind(srcId, dstId);
            EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
        }
        bindRelation.Order();
    }

    void ClearEntity(const EntityInfo &entity)
    {
    }

    void CreateQueue(const std::map<uint32_t, int32_t>& id2Depth, bool needTransId = false)
    {
        for (auto iter = id2Depth.begin(); iter != id2Depth.end(); ++iter) {
            uint32_t qid = 0;
            QueueAttr queAttr = { 0 };
            memcpy(queAttr.name, std::to_string(iter->first).c_str(), std::to_string(iter->first).length());
            queAttr.depth = iter->second;
            int ret = needTransId ? halQueueCreateWithTransId(0, &queAttr, &qid) :
                                    halQueueCreateFake(0, &queAttr, &qid);
            EXPECT_EQ(ret, 0);
        }
        return;
    }

    void EnQueue(uint32_t qid, std::vector<int32_t> val)
    {
        std::cout << "EnQueue is processing..." << std::endl;
        for (size_t i = 0; i < val.size(); i++) {
            int ret = EnBuffQueueFake(0, qid, (void*)&val[i]);
            EXPECT_EQ(ret, 0);
        }
        return;
    }

    void EnQueue(std::vector<EntityInfoPtr> &entities, std::vector<int32_t> &val, std::vector<int32_t> &idx)
    {
        std::cout << "EnQueue with transId is processing..." << std::endl;
        size_t entityNum = entities.size();
        for (size_t i = 0; i < val.size(); i++) {
            int ret = EnBuffQueueWithTransId(0, entities[rand() % entityNum]->GetId(), val[i], idx[i]);
            EXPECT_EQ(ret, 0);
        }
        return;
    }

    void CheckAndDeQueue(uint32_t qid, std::vector<int32_t> val)
    {
        std::cout << "DeQueue is processing..." << std::endl;

        for (size_t i = 0; i < val.size(); i++) {
            int32_t* realVal = nullptr;
            int ret = halQueueDeQueueFake(0, qid, (void**)&realVal);
            EXPECT_EQ(ret, DRV_ERROR_NONE);
            ASSERT_NE(realVal, nullptr);
            EXPECT_EQ(*realVal, val[i]);
        }
        return;
    }

    void CheckAndDeQueue(uint32_t qid, std::vector<int32_t> values, std::vector<int32_t> transIds)
    {
        std::cout << "DeQueue is processing..." << std::endl;
        for (size_t i = 0; i < values.size(); i++) {
            void* realVal = nullptr;
            int ret = halQueueDeQueueFake(0, qid, (void**)&realVal);
            EXPECT_EQ(ret, DRV_ERROR_NONE);
            ASSERT_NE(realVal, nullptr);
            auto pair = (std::pair<std::shared_ptr<HeadBuf>, uint32_t> *)realVal;
            std:: cout << "transId:" << pair->first->info.transId << ", value:" << pair->second << std::endl;
            EXPECT_EQ(pair->second, values[i]);
            EXPECT_EQ(pair->first->info.transId, transIds[i]);
        }
        return;
    }

    void CheckHasAndDeQueue(uint32_t qid, std::set<int32_t> val)
    {
        std::cout << "DeQueue is processing..." << std::endl;

        for (size_t i = 0; i < val.size(); i++) {
            int32_t* realVal = nullptr;
            int ret = halQueueDeQueueFake(0, qid, (void**)&realVal);
            EXPECT_EQ(ret, DRV_ERROR_NONE);
            ASSERT_NE(realVal, nullptr);
            EXPECT_EQ(val.count(*realVal), 1);
        }
        return;
    }

    bool VerifyQueueSize(uint32_t qid, int32_t size)
    {
        std::unique_lock<std::mutex> lock(g_qidToValueMutex);
        auto iter1 = g_qidToValue.find(qid);
        if (iter1 != g_qidToValue.end()) {
            return ((iter1->second.size() - g_qidToIndex[qid]) == size);
        }
        auto iter2 = g_qidToValueWithTransId.find(qid);
        if (iter2 != g_qidToValueWithTransId.end()) {
            return ((iter2->second.size() - g_qidToIndex[qid]) == size);
        }
        return false;
    }

    void CheckQueueSize(uint32_t qid, int32_t size)
    {
        uint32_t verifyThreshold = 5U;
        bool verifySuccess = false;
        while(verifyThreshold-- > 0U) {
            verifySuccess = VerifyQueueSize(qid, size);
            if (verifySuccess) {
                break;
            } else {
                std::cout << "the " <<  5 - verifyThreshold << "th check" << std::endl;
                std::this_thread::sleep_for(std::chrono::seconds(1));
            }
        }
        if (!verifySuccess) {
            std::cout << "queue: " << qid << " do not has " << size << " elements" << std::endl;
        }
        EXPECT_TRUE(verifySuccess);
    }

    void DestroyQueue(std::vector<uint32_t> qidVec)
    {
        for (size_t i = 0; i < qidVec.size(); i++) {
        int ret = DestroyBuffQueueFake(0, qidVec[i]);
            EXPECT_EQ(ret, 0);
        }
        return;
    }

    void CreateGroup(std::vector<EntityInfoPtr> &entities, uint32_t &groupId)
    {
        auto ret = BindRelation::GetInstance().CreateGroup(entities, groupId);
        EXPECT_EQ(ret, BQS_STATUS_OK);
    }
};

TEST_F(BQS_QUEUE_SCHEDULE_STTest, BindQueueSuccess1)
{
    std::multimap<uint32_t, uint32_t> srcDstMap;
    for (int32_t i = 0; i < 500; ++i) {
        srcDstMap.insert(std::make_pair(0, i + 1));
    }

    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    AddBindRelation(srcDstMap, 500, bindResultVec);
    QueueScheduleDestroy();
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, BindQueueSuccess2)
{
    std::multimap<uint32_t, uint32_t> srcDstMap;

    srcDstMap.insert(std::make_pair(1, 2));
    srcDstMap.insert(std::make_pair(1, 3));
    srcDstMap.insert(std::make_pair(4, 5));
    srcDstMap.insert(std::make_pair(4, 6));
    srcDstMap.insert(std::make_pair(7, 8));
    srcDstMap.insert(std::make_pair(4, 2));
    srcDstMap.insert(std::make_pair(7, 3));

    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    AddBindRelation(srcDstMap, 7, bindResultVec);
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, BindQueueSuccess3)
{
    std::multimap<uint32_t, uint32_t> srcDstMap;
    srcDstMap.insert(std::make_pair(1, 2));
    srcDstMap.insert(std::make_pair(3, 2));

    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    AddBindRelation(srcDstMap, 2, bindResultVec);
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, BindQueueFailed2)
{
    std::multimap<uint32_t, uint32_t> srcDstMap;
    srcDstMap.insert(std::make_pair(1, 2));
    srcDstMap.insert(std::make_pair(3, 2));
    srcDstMap.insert(std::make_pair(2, 6));
    srcDstMap.insert(std::make_pair(3, 1));
    srcDstMap.insert(std::make_pair(3, 4));

    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    AddBindRelation(srcDstMap, 3, bindResultVec);

    int32_t i = 0;
    for (auto iter : srcDstMap) {
        if ((iter.first == 2 && iter.second == 6)
        || (iter.first== 3 && iter.second == 1))
        {
            EXPECT_NE(bindResultVec[i].bindResult_, 0);
        }
        else {
            EXPECT_EQ(bindResultVec[i].bindResult_, 0);
        }
        i++;
    }
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, UnbindQueueBySrcSuccess1)
{
    std::multimap<bqs::QsQueryType, bqs::BQSBindQueueItem> keySrcDstMap;
    for (int32_t i = 0; i < 500; ++i) {
        keySrcDstMap.insert(std::make_pair(bqs::BQS_QUERY_TYPE_SRC, bqs::BQSBindQueueItem{1 + 1, 0}));
    }
    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    DelBindRelation(keySrcDstMap, 500, bindResultVec);
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, UnbindQueueBySrcSuccess2)
{
    // add bind relation
    std::multimap<uint32_t, uint32_t> srcDstMap;

    srcDstMap.insert(std::make_pair(1, 2));
    srcDstMap.insert(std::make_pair(1, 3));
    srcDstMap.insert(std::make_pair(5, 7));
    srcDstMap.insert(std::make_pair(4, 6));
    srcDstMap.insert(std::make_pair(8, 9));

    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    AddBindRelation(srcDstMap, 5, bindResultVec);

    // del bind relation
    std::multimap<bqs::QsQueryType, bqs::BQSBindQueueItem> keySrcDstMap;
    keySrcDstMap.insert(std::make_pair(bqs::BQS_QUERY_TYPE_SRC, bqs::BQSBindQueueItem{1, 0}));
    keySrcDstMap.insert(std::make_pair(bqs::BQS_QUERY_TYPE_DST, bqs::BQSBindQueueItem{0, 7}));

    bindResultVec.clear();
    DelBindRelation(keySrcDstMap, 2, bindResultVec);

    // get bind relation src
    keySrcDstMap.clear();
    keySrcDstMap.insert(std::make_pair(bqs::BQS_QUERY_TYPE_SRC, bqs::BQSBindQueueItem{1, 0}));

    std::vector<bqs::BQSBindQueueItem> getBindQueueResult;
    GetBindRelation(keySrcDstMap, 0, getBindQueueResult);

    // get bind relation dst
    keySrcDstMap.clear();
    keySrcDstMap.insert(std::make_pair(bqs::BQS_QUERY_TYPE_DST, bqs::BQSBindQueueItem{0, 7}));

    getBindQueueResult.clear();
    GetBindRelation(keySrcDstMap, 0, getBindQueueResult);

    // get all bind relation
    getBindQueueResult.clear();
    GetAllBindRelation(2, getBindQueueResult);

    // del bind relation
    keySrcDstMap.clear();
    keySrcDstMap.insert(std::make_pair(bqs::BQS_QUERY_TYPE_SRC_AND_DST, bqs::BQSBindQueueItem{8, 9}));
    keySrcDstMap.insert(std::make_pair(bqs::BQS_QUERY_TYPE_SRC, bqs::BQSBindQueueItem{4, 0}));

    bindResultVec.clear();
    DelBindRelation(keySrcDstMap, 2, bindResultVec);

    // get bind relation src
    keySrcDstMap.clear();
    keySrcDstMap.insert(std::make_pair(bqs::BQS_QUERY_TYPE_SRC, bqs::BQSBindQueueItem{8, 0}));

    getBindQueueResult.clear();
    GetBindRelation(keySrcDstMap, 0, getBindQueueResult);

    // get bind relation dst
    keySrcDstMap.clear();
    keySrcDstMap.insert(std::make_pair(bqs::BQS_QUERY_TYPE_DST, bqs::BQSBindQueueItem{0, 6}));

    getBindQueueResult.clear();
    GetBindRelation(keySrcDstMap, 0, getBindQueueResult);

    // get all bind relation
    getBindQueueResult.clear();
    GetAllBindRelation(0, getBindQueueResult);
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, GetBindQueueBySrcSuccess1)
{
    std::multimap<bqs::QsQueryType, bqs::BQSBindQueueItem> keySrcDstMap;
    keySrcDstMap.insert(std::make_pair(bqs::BQS_QUERY_TYPE_SRC, bqs::BQSBindQueueItem{1, 0}));
    std::vector<bqs::BQSBindQueueItem> getBindQueueResult;
    GetBindRelation(keySrcDstMap, 0, getBindQueueResult);
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, GetAllBindQueueSuccess1)
{
    // add bind relation 1-2
    std::multimap<uint32_t, uint32_t> srcDstMap;
    srcDstMap.insert(std::make_pair(1, 2));

    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    AddBindRelation(srcDstMap, 1, bindResultVec);

    // get bind relation by src
    std::multimap<bqs::QsQueryType, bqs::BQSBindQueueItem> keySrcDstMap;
    keySrcDstMap.insert(std::make_pair(bqs::BQS_QUERY_TYPE_SRC, bqs::BQSBindQueueItem{1, 0}));
    std::vector<bqs::BQSBindQueueItem> getBindQueueResult;
    GetBindRelation(keySrcDstMap, 1, getBindQueueResult);

    EXPECT_EQ(getBindQueueResult[0].srcQueueId_, 1);
    EXPECT_EQ(getBindQueueResult[0].dstQueueId_, 2);

    // get bind relation by dst
    keySrcDstMap.clear();
    keySrcDstMap.insert(std::make_pair(bqs::BQS_QUERY_TYPE_DST, bqs::BQSBindQueueItem{0, 2}));
    getBindQueueResult.clear();
    GetBindRelation(keySrcDstMap, 1, getBindQueueResult);

    EXPECT_EQ(getBindQueueResult[0].srcQueueId_, 1);
    EXPECT_EQ(getBindQueueResult[0].dstQueueId_, 2);

    // get all bind relation
    getBindQueueResult.clear();
    GetAllBindRelation(1, getBindQueueResult);
    EXPECT_EQ(getBindQueueResult[0].srcQueueId_, 1);
    EXPECT_EQ(getBindQueueResult[0].dstQueueId_, 2);
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, Schedule_1to1_Success)
{
    // create queue
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(1, 5));
    id2Depth.insert(std::make_pair(2, 5));
    CreateQueue(id2Depth);
    // add relation
    std::multimap<uint32_t, uint32_t> srcDstMap;
    srcDstMap.insert(std::make_pair(1, 2));
    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    AddBindRelation(srcDstMap, 1, bindResultVec);
    // enqueue
    EnQueue(1, std::vector<int32_t>{1, 3, 2, 1});
    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));

    // check result
    CheckQueueSize(1, 0);
    CheckQueueSize(2, 4);
    CheckAndDeQueue(2, std::vector<int32_t>{1, 3, 2, 1});
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, Schedule_1to1_Q2T_Success)
{
    MOCKER(HcclIsend).stubs().will(returnValue((int)HCCL_SUCCESS))
        .then(returnValue((int)HCCL_E_NETWORK)).then(returnValue((int)HCCL_SUCCESS));

    // create queue
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(1, 5));
    id2Depth.insert(std::make_pair(2, 5));
    CreateQueue(id2Depth);
    // add relation
    std::multimap<uint32_t, uint32_t> srcDstMap;
    srcDstMap.insert(std::make_pair(1, 2));
    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    AddBindRelation(srcDstMap, 1, bindResultVec);

    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
    EntityInfo src(1U, 0U);
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_TAG;
    args.channelPtr = &channel;
    EntityInfo dest(6U, 0U, &args);
    AddBindRelation(src, dest);

    // enqueue
    EnQueue(1, std::vector<int32_t>{1, 3, 2, 1});
    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));

    // check result
    CheckQueueSize(1, 0);
    CheckQueueSize(2, 4);
    CheckAndDeQueue(2, std::vector<int32_t>{1, 3, 2, 1});

    MOCKER_CPP(&QueueManager::EnqueueFullToNotFullEvent)
        .stubs()
        .will(returnValue(BqsStatus::BQS_STATUS_OK));
    dgw::HcclProcess hcclProcess;
    event_info event;
    event.comm.event_id = dgw::EVENT_SEND_COMPLETION_MSG;
    auto ret = hcclProcess.ProcessSendCompletionEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);

    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, Schedule_1to1_T2Q_Success)
{
    // create queue
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(72, 5));
    CreateQueue(id2Depth);

    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    uint32_t uniqueTagId = 7U;
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_TAG;
    args.channelPtr = &channel;
    EntityInfo src(uniqueTagId, 0U, &args);
    EntityInfo dest(72U, 0U);
    AddBindRelation(src, dest);

    // include four inner queue
    EXPECT_EQ(g_dataSubscribeVec.size(), 5UL);

    uint32_t headBufSize = 256U;
    char headBuf[256];
    void *headBufAddr = (void *)(&headBuf[0]);
    MOCKER(halMbufGetPrivInfo)
        .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
        .will(returnValue((int)DRV_ERROR_NONE));

    dgw::HcclProcess hcclProcess;
    // hccl recv request: 4 envelope, process 2, cache 2
    g_totalEnvelopeCount = 4U;
    event_info event;
    event.comm.event_id = dgw::EVENT_RECV_REQUEST_MSG;
    auto ret = hcclProcess.ProcessRecvRequestEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);

    dgw::EntityPtr entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
        dgw::EntityDirection::DIRECTION_SEND);
    ASSERT_NE(entity, nullptr);
    dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity.get());
    EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 2U);
    EXPECT_EQ(channelEntity->cachedEnvelopeQueue_.Size(), 2U);
    EXPECT_EQ(channelEntity->cachedReqCount_, 2U);

    // hccl recv completion
    event.comm.event_id = dgw::EVENT_RECV_COMPLETION_MSG;
    ret = hcclProcess.ProcessRecvCompletionEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);
    EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 0U);
    // CheckQueueSize(channelEntity->compReqQueueId_, 1);

    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));

    // check result
    CheckQueueSize(72, 1);
    CheckAndDeQueue(72, std::vector<int32_t>{g_tagMbuf});

    // process cached envelope
    event.comm.event_id = dgw::EVENT_RECV_REQUEST_MSG;
    ret = hcclProcess.ProcessRecvRequestEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);
    event.comm.event_id = dgw::EVENT_RECV_COMPLETION_MSG;
    ret = hcclProcess.ProcessRecvCompletionEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);
    EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 0U);
    // CheckQueueSize(channelEntity->compReqQueueId_, 1);

    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));
    // check result
    CheckQueueSize(72, 1);
    CheckAndDeQueue(72, std::vector<int32_t>{g_tagMbuf});

    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, Schedule_1to1_T2Q_OneTrackEvent_Success)
{
    // create queue
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(72, 5));
    CreateQueue(id2Depth);

    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    uint32_t uniqueTagId = 7U;
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_TAG;
    args.channelPtr = &channel;
    EntityInfo src(uniqueTagId, 0U, &args);
    EntityInfo dest(72U, 0U);
    AddBindRelation(src, dest);

    // include four inner queue
    EXPECT_EQ(g_dataSubscribeVec.size(), 5UL);

    uint32_t headBufSize = 256U;
    char headBuf[256];
    void *headBufAddr = (void *)(&headBuf[0]);
    MOCKER(halMbufGetPrivInfo)
        .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
        .will(returnValue((int)DRV_ERROR_NONE));

    // setenv("TMP_ENV_COMM_OPT_ENABLE", "1", 1);
    dgw::HcclProcess hcclProcess;
    hcclProcess.Init();
    hcclProcess.oneTrackEventEnabled_ = true;
    // hccl recv request: 4 envelope, process 2, cache 2
    g_totalEnvelopeCount = 4U;
    event_info event;
    event.comm.event_id = dgw::EVENT_RECV_COMPLETION_MSG;
    auto ret = hcclProcess.ProcessRecvCompletionEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);

    dgw::EntityPtr entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
        dgw::EntityDirection::DIRECTION_SEND);
    ASSERT_NE(entity, nullptr);
    dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity.get());
    std::this_thread::sleep_for(std::chrono::seconds(1));
    EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 2U);
    EXPECT_EQ(channelEntity->cachedEnvelopeQueue_.Size(), 2U);
    EXPECT_EQ(channelEntity->cachedReqCount_, 2U);

    // hccl recv completion
    ret = hcclProcess.ProcessRecvCompletionEvent(event, 0U, 0U);
    std::this_thread::sleep_for(std::chrono::seconds(1));
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);
    EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 0U);

    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));

    // check result
    CheckQueueSize(72, 1);
    CheckAndDeQueue(72, std::vector<int32_t>{g_tagMbuf});

    // process cached envelope
    ret = hcclProcess.ProcessRecvCompletionEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);
    event.comm.event_id = dgw::EVENT_RECV_COMPLETION_MSG;
    ret = hcclProcess.ProcessRecvCompletionEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);
    std::this_thread::sleep_for(std::chrono::seconds(1));
    EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 0U);

    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));
    // check result
    CheckQueueSize(72, 1);
    CheckAndDeQueue(72, std::vector<int32_t>{g_tagMbuf});

    QueueScheduleDestroy();
    // unsetenv("TMP_ENV_COMM_OPT_ENABLE");
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, Schedule_1to3_Success)
{
    // create queue
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(1, 5));
    id2Depth.insert(std::make_pair(2, 5));
    id2Depth.insert(std::make_pair(3, 5));
    id2Depth.insert(std::make_pair(4, 5));
    CreateQueue(id2Depth);
    // add relation
    std::multimap<uint32_t, uint32_t> srcDstMap;
    srcDstMap.insert(std::make_pair(1, 2));
    srcDstMap.insert(std::make_pair(1, 3));
    srcDstMap.insert(std::make_pair(1, 4));
    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    AddBindRelation(srcDstMap, 3, bindResultVec);
    // enqueue
    EnQueue(1, std::vector<int32_t>{1, 4, 6, 5});
    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));
    // check result
    CheckQueueSize(1, 0);
    CheckQueueSize(2, 4);
    CheckQueueSize(3, 4);
    CheckQueueSize(4, 4);
    CheckAndDeQueue(2, std::vector<int32_t>{1, 4, 6, 5});
    CheckAndDeQueue(3, std::vector<int32_t>{1, 4, 6, 5});
    CheckAndDeQueue(4, std::vector<int32_t>{1, 4, 6, 5});
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, Schedule_1to2_AcrossNuma_Success)
{
    int32_t mbufValue = 1;
    int32_t *mbuf = &mbufValue;

    MOCKER(halMbufAllocEx)
        .stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP((Mbuf **)&mbuf))
        .will(returnValue((int)DRV_ERROR_NONE));
    uint32_t headSize = 1LU;
    MOCKER(halMbufGetPrivInfo)
        .stubs().with(mockcpp::any(), outBoundP((void **)&mbuf), outBoundP(&headSize))
        .will(returnValue((int)DRV_ERROR_NONE));
    GlobalCfg::GetInstance().SetNumaFlag(true);
    GlobalCfg::GetInstance().RecordDeviceId(1U, 1U, 0U);
    Subscribers::GetInstance().InitSubscribeManagers(std::set<uint32_t>{1U}, 0U);
    // create queue
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(1, 5));
    id2Depth.insert(std::make_pair(2, 5));
    id2Depth.insert(std::make_pair(3, 5));
    CreateQueue(id2Depth);
    // add relation
    EntityInfoPtr entity1 = std::make_shared<EntityInfo>(1U, 0U);
    EntityInfoPtr entity2 = std::make_shared<EntityInfo>(2U, 1U);
    EntityInfoPtr entity3 = std::make_shared<EntityInfo>(3U, 1U);
    AddBindRelation(*entity1, *entity2);
    AddBindRelation(*entity1, *entity3);
    // enqueue
    EnQueue(1, std::vector<int32_t>{1});
    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));
    // check result
    CheckQueueSize(1, 0);
    CheckQueueSize(2, 1);
    CheckQueueSize(3, 1);
    QueueScheduleDestroy();
    Subscribers::GetInstance().subscribeManagers_.clear();
    GlobalCfg::GetInstance().SetNumaFlag(false);
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, Schedule_3to1_Success)
{
    // create queue
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(1, 5));
    id2Depth.insert(std::make_pair(2, 5));
    id2Depth.insert(std::make_pair(3, 5));
    id2Depth.insert(std::make_pair(4, 10));
    CreateQueue(id2Depth);
    // add relation
    std::multimap<uint32_t, uint32_t> srcDstMap;
    srcDstMap.insert(std::make_pair(1, 4));
    srcDstMap.insert(std::make_pair(2, 4));
    srcDstMap.insert(std::make_pair(3, 4));
    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    AddBindRelation(srcDstMap, 3, bindResultVec);
    // enqueue
    EnQueue(1, std::vector<int32_t>{1, 2});
    EnQueue(2, std::vector<int32_t>{3, 4});
    EnQueue(3, std::vector<int32_t>{5, 6});
    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));
    // check result
    CheckQueueSize(1, 0);
    CheckQueueSize(2, 0);
    CheckQueueSize(3, 0);
    CheckQueueSize(4, 6);
    CheckHasAndDeQueue(4, std::set<int32_t>{1, 2, 3, 4, 5, 6});
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, Schedule_F2NF_Success)
{
    // create queue
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(1, 10));
    id2Depth.insert(std::make_pair(2, 3));
    id2Depth.insert(std::make_pair(3, 10));
    CreateQueue(id2Depth);
    // add relation
    std::multimap<uint32_t, uint32_t> srcDstMap;
    srcDstMap.insert(std::make_pair(1, 2));
    srcDstMap.insert(std::make_pair(1, 3));
    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    AddBindRelation(srcDstMap, 2, bindResultVec);
    // enqueue
    EnQueue(1, std::vector<int32_t>{1, 4, 6, 5});
    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));
    // check result
    CheckQueueSize(1, 0);
    CheckQueueSize(2, 3);
    CheckQueueSize(3, 4);
    CheckAndDeQueue(2, std::vector<int32_t>{1});
    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));
    CheckQueueSize(1, 0);
    CheckQueueSize(2, 3);
    CheckQueueSize(3, 4);
    CheckAndDeQueue(2, std::vector<int32_t>{4, 6, 5});
    CheckAndDeQueue(3, std::vector<int32_t>{1, 4, 6, 5});
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, Schedule_NormalWithF2NF_Success)
{
    // create queue
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(4, 10));
    id2Depth.insert(std::make_pair(5, 10));
    CreateQueue(id2Depth);
    // add relation
    std::multimap<uint32_t, uint32_t> srcDstMap;
    srcDstMap.insert(std::make_pair(4, 5));
    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    AddBindRelation(srcDstMap, 1, bindResultVec);
    // enqueue
    EnQueue(4, std::vector<int32_t>{1, 4, 6, 5, 4, 7});
    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));
    // check result
    CheckQueueSize(4, 0);
    CheckQueueSize(5, 6);
    CheckAndDeQueue(5, std::vector<int32_t>{1, 4, 6, 5, 4, 7});
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, Schedule_Restart_1to1_Success)
{
    // create queue
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(1, 5));
    id2Depth.insert(std::make_pair(2, 5));
    CreateQueue(id2Depth);
    // add relation
    std::multimap<uint32_t, uint32_t> srcDstMap;
    srcDstMap.insert(std::make_pair(1, 2));
    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    AddBindRelation(srcDstMap, 1, bindResultVec);

    // del bind relation
    std::multimap<bqs::QsQueryType, bqs::BQSBindQueueItem> keySrcDstMap;
    keySrcDstMap.insert(std::make_pair(bqs::BQS_QUERY_TYPE_SRC_AND_DST, bqs::BQSBindQueueItem{1, 2}));
    bindResultVec.clear();
    DelBindRelation(keySrcDstMap, 1, bindResultVec);

    bqs::SubscribeManager::GetInstance().InitSubscribeManager(0, 0, 1, 0);
    AddBindRelation(srcDstMap, 1, bindResultVec);
    AddBindRelation(srcDstMap, 1, bindResultVec);
    // enqueue
    EnQueue(1, std::vector<int32_t>{1, 3, 2, 1});
    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));

    // check result
    CheckQueueSize(1, 0);
    CheckQueueSize(2, 4);
    CheckAndDeQueue(2, std::vector<int32_t>{1, 3, 2, 1});
    QueueScheduleDestroy();
    bqs::BqsServer::GetInstance().WaitBindMsgProc();
    QueueScheduleDestroy();
    bqs::QueueManager::GetInstance().LogErrorRelationQueueStatus();
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, Schedule_1to1_Group2Queue_Success)
{
    MOCKER(halMbufGetPrivInfo)
        .stubs()
        .will(invoke(halMbufGetPrivInfoFake));

    // create queue 1001 and queue 1002
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(1001, 10));
    id2Depth.insert(std::make_pair(1002, 10));
    id2Depth.insert(std::make_pair(1003, 10));
    CreateQueue(id2Depth, true);

    // create group
    EntityInfoPtr entity1 = std::make_shared<EntityInfo>(1001U, 0U);
    EntityInfoPtr entity2 = std::make_shared<EntityInfo>(1002U, 0U);
    std::vector<EntityInfoPtr> entitiesInGroup;
    entitiesInGroup.emplace_back(entity1);
    entitiesInGroup.emplace_back(entity2);
    uint32_t groupId = 0U;
    CreateGroup(entitiesInGroup, groupId);

    // bind relation
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_GROUP;
    EntityInfo src(groupId, 0U, &args);
    EntityInfo dst(1003U, 0U);
    AddBindRelation(src, dst);

    auto groupEntityMap = dgw::EntityManager::Instance().groupEntityMap_;
    auto idToEntity = dgw::EntityManager::Instance().idToEntity_;
    EXPECT_EQ(groupEntityMap.size(), 1);
    EXPECT_EQ(idToEntity[0][0].size(), 2);
    EXPECT_EQ(idToEntity[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_GROUP].size(), 1);
    EXPECT_EQ(idToEntity[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_QUEUE].size(), 3);

    // enqueue
    std::vector<int32_t> valueVec{90001, 90002, 90003, 90004, 90005, 90006, 90007, 90008};
    std::vector<int32_t> indexVec{1, 2, 3, 4, 5, 6, 7, 8};
    EnQueue(entitiesInGroup, valueVec, indexVec);

    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));

    // check result
    CheckQueueSize(1001, 0);
    CheckQueueSize(1002, 0);
    CheckQueueSize(1003, 8);
    CheckAndDeQueue(1003, std::vector<int32_t>{90001, 90002, 90003, 90004, 90005, 90006, 90007, 90008},
                    std::vector<int32_t>{1, 2, 3, 4, 5, 6, 7, 8});
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, Schedule_1to2_Group2Queue_Success)
{
    MOCKER(halMbufGetPrivInfo)
        .stubs()
        .will(invoke(halMbufGetPrivInfoFake));

    // create queue 1001 and queue 1002
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(2001, 10));
    id2Depth.insert(std::make_pair(2002, 10));
    id2Depth.insert(std::make_pair(2003, 10));
    id2Depth.insert(std::make_pair(2004, 10));
    id2Depth.insert(std::make_pair(2005, 10));
    CreateQueue(id2Depth, true);

    // create group
    EntityInfoPtr entity1 = std::make_shared<EntityInfo>(2003U, 0U);
    EntityInfoPtr entity2 = std::make_shared<EntityInfo>(2002U, 0U);
    EntityInfoPtr entity3 = std::make_shared<EntityInfo>(2001U, 0U);
    std::vector<EntityInfoPtr> entitiesInGroup;
    entitiesInGroup.emplace_back(entity1);
    entitiesInGroup.emplace_back(entity2);
    entitiesInGroup.emplace_back(entity3);
    uint32_t groupId = 0U;
    CreateGroup(entitiesInGroup, groupId);

    // bind relation
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_GROUP;
    EntityInfo src(groupId, 0U, &args);
    EntityInfo dst(2004U, 0U);
    AddBindRelation(src, dst);

    // bind relation
    EntityInfo dst2(2005U, 0U);
    AddBindRelation(src, dst2);

    auto groupEntityMap = dgw::EntityManager::Instance().groupEntityMap_;
    auto idToEntity = dgw::EntityManager::Instance().idToEntity_;
    EXPECT_EQ(groupEntityMap.size(), 1);
    EXPECT_EQ(idToEntity[0][0].size(), 2);
    EXPECT_EQ(idToEntity[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_GROUP].size(), 1);
    EXPECT_EQ(idToEntity[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_QUEUE].size(), 5);

    // enqueue
    std::vector<int32_t> valueVec{90001, 90002, 90003, 90004, 90005, 90006, 90007, 90008};
    std::vector<int32_t> indexVec{1, 2, 3, 4, 5, 6, 7, 8};
    EnQueue(entitiesInGroup, valueVec, indexVec);

    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));

    // check result
    CheckQueueSize(2001, 0);
    CheckQueueSize(2002, 0);
    CheckQueueSize(2003, 0);
    CheckQueueSize(2004, 8);
    CheckQueueSize(2005, 8);
    CheckAndDeQueue(2004, std::vector<int32_t>{90001, 90002, 90003, 90004, 90005, 90006, 90007, 90008},
                    std::vector<int32_t>{1, 2, 3, 4, 5, 6, 7, 8});
    CheckAndDeQueue(2005, std::vector<int32_t>{90001, 90002, 90003, 90004, 90005, 90006, 90007, 90008},
                    std::vector<int32_t>{1, 2, 3, 4, 5, 6, 7, 8});
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, Schedule_1to1_Group2Group_Success)
{
    MOCKER(halMbufGetPrivInfo)
        .stubs()
        .will(invoke(halMbufGetPrivInfoFake));

    // create queue 1001 and queue 1002
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(3001, 10));
    id2Depth.insert(std::make_pair(3002, 10));
    id2Depth.insert(std::make_pair(3003, 10));
    id2Depth.insert(std::make_pair(3004, 10));
    id2Depth.insert(std::make_pair(3005, 10));
    CreateQueue(id2Depth, true);

    // create src group
    EntityInfoPtr entity1 = std::make_shared<EntityInfo>(3003U, 0U);
    EntityInfoPtr entity2 = std::make_shared<EntityInfo>(3002U, 0U);
    EntityInfoPtr entity3 = std::make_shared<EntityInfo>(3001U, 0U);
    std::vector<EntityInfoPtr> entitiesInGroup;
    entitiesInGroup.emplace_back(entity1);
    entitiesInGroup.emplace_back(entity2);
    entitiesInGroup.emplace_back(entity3);
    uint32_t groupId = 0U;
    CreateGroup(entitiesInGroup, groupId);

    // create dst group
    EntityInfoPtr entity4 = std::make_shared<EntityInfo>(3004U, 0U);
    EntityInfoPtr entity5 = std::make_shared<EntityInfo>(3005U, 0U);
    std::vector<EntityInfoPtr> entitiesInGroup2;
    entitiesInGroup2.emplace_back(entity4);
    entitiesInGroup2.emplace_back(entity5);
    uint32_t groupId2 = 0U;
    CreateGroup(entitiesInGroup2, groupId2);

    // bind relation
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_GROUP;
    EntityInfo src(groupId, 0U, &args);
    EntityInfo dst(groupId2, 0U, &args);
    AddBindRelation(src, dst);

    auto groupEntityMap = dgw::EntityManager::Instance().groupEntityMap_;
    auto idToEntity = dgw::EntityManager::Instance().idToEntity_;
    EXPECT_EQ(groupEntityMap.size(), 2);
    EXPECT_EQ(idToEntity[0][0].size(), 2);
    EXPECT_EQ(idToEntity[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_GROUP].size(), 2);
    EXPECT_EQ(idToEntity[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_QUEUE].size(), 5);

    // enqueue
    std::vector<int32_t> valueVec{90001, 90002, 90003, 90004, 90005, 90006, 90007, 90008};
    std::vector<int32_t> indexVec{1, 2, 3, 4, 5, 6, 7, 8};
    EnQueue(entitiesInGroup, valueVec, indexVec);

    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));

    // check result
    CheckQueueSize(3001, 0);
    CheckQueueSize(3002, 0);
    CheckQueueSize(3003, 0);
    CheckQueueSize(3004, 4);
    CheckQueueSize(3005, 4);
    CheckAndDeQueue(3005, std::vector<int32_t>{90001, 90003, 90005, 90007},
                    std::vector<int32_t>{1, 3, 5, 7});
    CheckAndDeQueue(3004, std::vector<int32_t>{90002, 90004, 90006, 90008},
                    std::vector<int32_t>{2, 4, 6, 8});

    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, Schedule_1to3_QueueTo1GroupAnd1TagAnd1QueueSuccess)
{
    MOCKER(halMbufGetPrivInfo)
        .stubs()
        .will(invoke(halMbufGetPrivInfoFake));

    MOCKER(HcclIsend).stubs().will(returnValue((int)HCCL_SUCCESS));

    // create queue 4001 and queue 4002 and queue 4003 and queue 4004
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(4001, 10));
    id2Depth.insert(std::make_pair(4002, 10));
    id2Depth.insert(std::make_pair(4003, 10));
    id2Depth.insert(std::make_pair(4004, 10));
    id2Depth.insert(std::make_pair(4005, 10));
    CreateQueue(id2Depth, true);

    // create dst group
    EntityInfoPtr entity1 = std::make_shared<EntityInfo>(4002U, 0U);
    EntityInfoPtr entity2 = std::make_shared<EntityInfo>(4003U, 0U);
    EntityInfoPtr entity3 = std::make_shared<EntityInfo>(4004U, 0U);
    dgw::CommChannel channel1(hcclHandle, 1U, 1U, 0U, 0U, 128U, 128U);
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_TAG;
    args.channelPtr = &channel1;
    EntityInfoPtr entity4 = std::make_shared<EntityInfo>(7U, 0U, &args);
    std::vector<EntityInfoPtr> entitiesInGroup;
    entitiesInGroup.emplace_back(entity1);
    entitiesInGroup.emplace_back(entity2);
    entitiesInGroup.emplace_back(entity3);
    entitiesInGroup.emplace_back(entity4);
    uint32_t groupId = 0U;
    CreateGroup(entitiesInGroup, groupId);

    // bind relation1
    EntityInfo src(4001U, 0U);
    args.eType = dgw::EntityType::ENTITY_GROUP;
    args.channelPtr = nullptr;
    EntityInfo dst(groupId, 0U, &args);
    AddBindRelation(src, dst);
    // bind relation2
    dgw::CommChannel channel2(hcclHandle, 2U, 2U, 0U, 0U, 128U, 128U);
    args.eType = dgw::EntityType::ENTITY_TAG;
    args.channelPtr = &channel2;
    EntityInfo dst2(8U, 0U, &args);
    AddBindRelation(src, dst2);
    // bind relation3
    EntityInfo dst3(4005U, 0U);
    AddBindRelation(src, dst3);

    auto groupEntityMap = dgw::EntityManager::Instance().groupEntityMap_;
    auto idToEntity = dgw::EntityManager::Instance().idToEntity_;
    EXPECT_EQ(groupEntityMap.size(), 1);
    EXPECT_EQ(idToEntity[0][0].size(), 3);
    EXPECT_EQ(idToEntity[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_GROUP].size(), 1);
    EXPECT_EQ(idToEntity[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_QUEUE].size(), 5);
    EXPECT_EQ(idToEntity[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_TAG].size(), 2);

    // enqueue
    std::vector<int32_t> valueVec{90001, 90002, 90003, 90004, 90005, 90006, 90007, 90008};
    std::vector<int32_t> indexVec{1, 2, 3, 4, 5, 6, 7, 8};
    std::vector<EntityInfoPtr> entities;
    EntityInfoPtr entity = std::make_shared<EntityInfo>(4001U, 0U);
    entities.emplace_back(entity);
    EnQueue(entities, valueVec, indexVec);

    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));

    // check result
    CheckQueueSize(4001, 0);
    CheckQueueSize(4002, 2);
    CheckQueueSize(4003, 2);
    CheckQueueSize(4004, 2);
    CheckQueueSize(4005, 8);

    CheckAndDeQueue(4002, std::vector<int32_t>{90004, 90008},
                    std::vector<int32_t>{4, 8});
    CheckAndDeQueue(4003, std::vector<int32_t>{90001, 90005},
                    std::vector<int32_t>{1, 5});
    CheckAndDeQueue(4004, std::vector<int32_t>{90002, 90006},
                    std::vector<int32_t>{2, 6});
    CheckAndDeQueue(4005, std::vector<int32_t>{90001, 90002, 90003, 90004, 90005, 90006, 90007, 90008},
                    std::vector<int32_t>{1, 2, 3, 4, 5, 6, 7, 8});
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, Schedule_1to1_QueueToGroup_Broadcast_Success)
{
    MOCKER(halMbufGetPrivInfo)
        .stubs()
        .will(invoke(halMbufGetPrivInfoFake));

    // create queue 5001 and queue 5002 and queue 5003
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(5001, 10));
    id2Depth.insert(std::make_pair(5002, 10));
    id2Depth.insert(std::make_pair(5003, 10));
    CreateQueue(id2Depth, true);

    // create dst group
    EntityInfoPtr entity1 = std::make_shared<EntityInfo>(5002U, 0U);
    EntityInfoPtr entity2 = std::make_shared<EntityInfo>(5003U, 0U);
    std::vector<EntityInfoPtr> entitiesInGroup;
    entitiesInGroup.emplace_back(entity1);
    entitiesInGroup.emplace_back(entity2);
    uint32_t groupId = 0U;
    CreateGroup(entitiesInGroup, groupId);

    // bind relation1
    EntityInfo src(5001U, 0U);
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_GROUP;
    args.policy = bqs::GroupPolicy::BROADCAST;
    EntityInfo dst(groupId, 0U, &args);
    AddBindRelation(src, dst);

    auto groupEntityMap = dgw::EntityManager::Instance().groupEntityMap_;
    auto idToEntity = dgw::EntityManager::Instance().idToEntity_;
    EXPECT_EQ(groupEntityMap.size(), 1);
    EXPECT_EQ(idToEntity[0][0].size(), 2);
    EXPECT_EQ(idToEntity[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_GROUP].size(), 1);
    EXPECT_EQ(idToEntity[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_QUEUE].size(), 3);

    // enqueue
    std::vector<int32_t> valueVec{90001, 90002, 90003, 90004, 90005, 90006, 90007, 90008};
    std::vector<int32_t> indexVec{1, 2, 3, 4, 5, 6, 7, 8};
    std::vector<EntityInfoPtr> entities;
    EntityInfoPtr entity = std::make_shared<EntityInfo>(5001U, 0U);
    entities.emplace_back(entity);
    EnQueue(entities, valueVec, indexVec);

    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));

    // check result
    CheckQueueSize(5001, 0);
    CheckQueueSize(5002, 8);
    CheckQueueSize(5003, 8);

    CheckAndDeQueue(5002, std::vector<int32_t>{90001, 90002, 90003, 90004, 90005, 90006, 90007, 90008},
                    std::vector<int32_t>{1, 2, 3, 4, 5, 6, 7, 8});
    CheckAndDeQueue(5003, std::vector<int32_t>{90001, 90002, 90003, 90004, 90005, 90006, 90007, 90008},
                    std::vector<int32_t>{1, 2, 3, 4, 5, 6, 7, 8});
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, ScheduleQueueTo_1Q_2DynamicGroup_1StaticGroup_Success)
{
    MOCKER(halMbufGetPrivInfo)
        .stubs()
        .will(invoke(halMbufGetPrivInfoFake));
    g_dynamicResponseQ = 4010U;
    MOCKER_CPP(&dgw::DynamicSchedMgr::GetResponse).stubs().will(invoke(DynamicGetResponseFake));
    MOCKER_CPP(&dgw::DynamicSchedMgr::SendRequest).stubs().will(returnValue(dgw::FsmStatus::FSM_SUCCESS));

    bqs::DynamicSchedQueueAttr queueAttr = {};
    dgw::ScheduleConfig::GetInstance().RecordConfig(0U, queueAttr, queueAttr);

    // create queue
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(4001, 10));
    id2Depth.insert(std::make_pair(4002, 10));
    id2Depth.insert(std::make_pair(4003, 10));
    id2Depth.insert(std::make_pair(4004, 10));
    id2Depth.insert(std::make_pair(4005, 10));
    id2Depth.insert(std::make_pair(4006, 10));
    id2Depth.insert(std::make_pair(4007, 10));
    id2Depth.insert(std::make_pair(4008, 10));
    id2Depth.insert(std::make_pair(4009, 10));
    id2Depth.insert(std::make_pair(4010, 10));
    CreateQueue(id2Depth, true);

    // create dst dynamic group 0
    EntityInfoPtr entityDg0Ele0 = std::make_shared<EntityInfo>(4002U, 0U);
    bqs::OptionalArg args = {};
    args.globalId = 1U;
    EntityInfoPtr entityDg0Ele1 = std::make_shared<EntityInfo>(4003U, 0U, &args);
    std::vector<EntityInfoPtr> entitiesInGroupDg0;
    entitiesInGroupDg0.emplace_back(entityDg0Ele0);
    entitiesInGroupDg0.emplace_back(entityDg0Ele1);
    uint32_t dynamicGroupId0 = 0U;
    CreateGroup(entitiesInGroupDg0, dynamicGroupId0);

    // create dst dynamic group 1
    args.globalId = 2U;
    EntityInfoPtr entityDg1Ele0 = std::make_shared<EntityInfo>(4004U, 0U, &args);
    args.globalId = 3U;
    EntityInfoPtr entityDg1Ele1 = std::make_shared<EntityInfo>(4005U, 0U, &args);
    std::vector<EntityInfoPtr> entitiesInGroupDg1;
    entitiesInGroupDg1.emplace_back(entityDg1Ele0);
    entitiesInGroupDg1.emplace_back(entityDg1Ele1);
    uint32_t dynamicGroupId1 = 0U;
    CreateGroup(entitiesInGroupDg1, dynamicGroupId1);

    // create dst static group 1
    args.globalId = 4U;
    EntityInfoPtr entitySg0Ele0 = std::make_shared<EntityInfo>(4006U, 0U, &args);
    args.globalId = 5U;
    EntityInfoPtr entitySg0Ele1 = std::make_shared<EntityInfo>(4007U, 0U, &args);
    std::vector<EntityInfoPtr> entitiesInGroupSg0;
    entitiesInGroupSg0.emplace_back(entitySg0Ele0);
    entitiesInGroupSg0.emplace_back(entitySg0Ele1);
    uint32_t staticGroupId0 = 0U;
    CreateGroup(entitiesInGroupSg0, staticGroupId0);

    // bind relation1
    args.globalId = 6U;
    EntityInfo src(4001U, 0U, &args);
    args.eType = dgw::EntityType::ENTITY_GROUP;
    args.policy = bqs::GroupPolicy::DYNAMIC;
    args.globalId = 7U;
    EntityInfo dstDg0(dynamicGroupId0, 0U, &args);
    AddBindRelation(src, dstDg0);
    // bind relation2
    args.globalId = 8U;
    EntityInfo dstDg1(dynamicGroupId1, 0U, &args);
    AddBindRelation(src, dstDg1);
    // bind relation3
    args.policy = bqs::GroupPolicy::HASH;
    args.globalId = 9U;
    EntityInfo dstSg0(staticGroupId0, 0U, &args);
    AddBindRelation(src, dstSg0);
    // bind relation4
    args.eType = dgw::EntityType::ENTITY_QUEUE;
    args.globalId = 10U;
    EntityInfo dstQ(4008U, 0U, &args);
    AddBindRelation(src, dstQ);

    // bind dynamic relation
    args.globalId = 11U;
    EntityInfo respSrc(4009U, 0U, &args);
    args.globalId = 12U;
    EntityInfo respDst(4010U, 0U, &args);
    AddBindRelation(respSrc, respDst);

    // enqueue
    std::vector<int32_t> valueVec{90001, 90002};
    std::vector<int32_t> indexVec{1, 2};
    std::vector<EntityInfoPtr> enQueueEntities;
    EntityInfoPtr enqueEntity = std::make_shared<EntityInfo>(4001U, 0U);
    enQueueEntities.emplace_back(enqueEntity);
    EnQueue(enQueueEntities, valueVec, indexVec);

    // check result
    CheckQueueSize(4001, 0);
    CheckQueueSize(4002, 0);
    CheckQueueSize(4003, 0);
    CheckQueueSize(4004, 0);
    CheckQueueSize(4005, 0);
    CheckQueueSize(4006, 0);
    CheckQueueSize(4007, 1);
    CheckQueueSize(4008, 1);
    CheckAndDeQueue(4007, std::vector<int32_t>{90001}, std::vector<int32_t>{1});
    CheckAndDeQueue(4008, std::vector<int32_t>{90001}, std::vector<int32_t>{1});

    EntityInfoPtr enqueEntityRespSrc = std::make_shared<EntityInfo>(4009U, 0U);
    std::vector<EntityInfoPtr> enQueueEntitiesResp;
    enQueueEntitiesResp.emplace_back(enqueEntityRespSrc);
    std::vector<int32_t> enqueElem{1};
    EnQueue(enQueueEntitiesResp, enqueElem, enqueElem);
    CheckQueueSize(4009, 0);
    CheckQueueSize(4010, 0);
    CheckQueueSize(4002, 1);
    CheckQueueSize(4005, 1);
    CheckQueueSize(4006, 1);
    CheckQueueSize(4008, 1);
    CheckAndDeQueue(4002, std::vector<int32_t>{90001}, std::vector<int32_t>{1});
    CheckAndDeQueue(4005, std::vector<int32_t>{90001}, std::vector<int32_t>{1});
    CheckAndDeQueue(4006, std::vector<int32_t>{90002}, std::vector<int32_t>{2});
    CheckAndDeQueue(4008, std::vector<int32_t>{90002}, std::vector<int32_t>{2});

    EnQueue(enQueueEntitiesResp, enqueElem, enqueElem);
    CheckQueueSize(4009, 0);
    CheckQueueSize(4010, 0);
    CheckQueueSize(4002, 1);
    CheckQueueSize(4005, 1);
    CheckAndDeQueue(4002, std::vector<int32_t>{90002}, std::vector<int32_t>{2});
    CheckAndDeQueue(4005, std::vector<int32_t>{90002}, std::vector<int32_t>{2});

    QueueScheduleDestroy();
    dgw::ScheduleConfig::GetInstance().schedKeys_.clear();
    dgw::ScheduleConfig::GetInstance().configMap_.clear();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, Schedule_1to1_Group2Queue_LostOneTransId_Success)
{
     MOCKER(halMbufGetPrivInfo)
        .stubs()
        .will(invoke(halMbufGetPrivInfoFake));

    // create queue 6001 and queue 6002 and queue 6003
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(6001, 10));
    id2Depth.insert(std::make_pair(6002, 10));
    id2Depth.insert(std::make_pair(6003, 10));
    CreateQueue(id2Depth, true);

    // create group
    EntityInfoPtr entity1 = std::make_shared<EntityInfo>(6001U, 0U);
    EntityInfoPtr entity2 = std::make_shared<EntityInfo>(6002U, 0U);
    std::vector<EntityInfoPtr> entitiesInGroup;
    entitiesInGroup.emplace_back(entity1);
    entitiesInGroup.emplace_back(entity2);
    uint32_t groupId = 0U;
    CreateGroup(entitiesInGroup, groupId);

    // bind relation
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_GROUP;
    EntityInfo src(groupId, 0U, &args);
    EntityInfo dst(6003U, 0U);
    AddBindRelation(src, dst);

    auto groupEntityMap = dgw::EntityManager::Instance().groupEntityMap_;
    auto idToEntity = dgw::EntityManager::Instance().idToEntity_;
    EXPECT_EQ(groupEntityMap.size(), 1);
    EXPECT_EQ(idToEntity[0][0].size(), 2);
    EXPECT_EQ(idToEntity[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_GROUP].size(), 1);
    EXPECT_EQ(idToEntity[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_QUEUE].size(), 3);

    // enqueue
    std::vector<int32_t> valueVec{90001, 90002, 90003, 90004, 90005, 90006, 90007, 90008};
    std::vector<int32_t> indexVec{1, 2, 4, 5, 6, 7, 8, 9};
    EnQueue(entitiesInGroup, valueVec, indexVec);

    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));

    // check result
    CheckQueueSize(6001, 0);
    CheckQueueSize(6002, 0);
    CheckQueueSize(6003, 8);
    CheckAndDeQueue(6003, std::vector<int32_t>{90001, 90002, 90003, 90004, 90005, 90006, 90007, 90008},
                    std::vector<int32_t>{1, 2, 4, 5, 6, 7, 8, 9});
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, Schedule_1to1_QueueToGroup_Full_Success)
{
    MOCKER(halMbufGetPrivInfo)
        .stubs()
        .will(invoke(halMbufGetPrivInfoFake));

    // create queue 5001 and queue 5002 and queue 5003
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(7001, 10));
    id2Depth.insert(std::make_pair(7002, 3));
    id2Depth.insert(std::make_pair(7003, 3));
    CreateQueue(id2Depth, true);

    // create dst group
    EntityInfoPtr entity1 = std::make_shared<EntityInfo>(7002U, 0U);
    EntityInfoPtr entity2 = std::make_shared<EntityInfo>(7003U, 0U);
    std::vector<EntityInfoPtr> entitiesInGroup;
    entitiesInGroup.emplace_back(entity1);
    entitiesInGroup.emplace_back(entity2);
    uint32_t groupId = 0U;
    CreateGroup(entitiesInGroup, groupId);

    // bind relation1
    EntityInfo src(7001U, 0U);
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_GROUP;
    EntityInfo dst(groupId, 0U, &args);
    AddBindRelation(src, dst);
    // include 4 inner queue
    EXPECT_EQ(g_dataSubscribeVec.size(), 5UL);

    auto groupEntityMap = dgw::EntityManager::Instance().groupEntityMap_;
    auto idToEntity = dgw::EntityManager::Instance().idToEntity_;
    EXPECT_EQ(groupEntityMap.size(), 1);
    EXPECT_EQ(idToEntity[0][0].size(), 2);
    EXPECT_EQ(idToEntity[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_GROUP].size(), 1);
    EXPECT_EQ(idToEntity[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_QUEUE].size(), 3);

    // enqueue
    std::vector<int32_t> valueVec{90001, 90002, 90003, 90004, 90005, 90006, 90007, 90008};
    std::vector<int32_t> indexVec{1, 2, 3, 4, 5, 6, 7, 8};
    std::vector<EntityInfoPtr> entities;
    EntityInfoPtr entity = std::make_shared<EntityInfo>(7001U, 0U);
    entities.emplace_back(entity);
    EnQueue(entities, valueVec, indexVec);

    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));
    CheckQueueSize(7002, 3);
    CheckQueueSize(7003, 3);
    CheckAndDeQueue(7002, std::vector<int32_t>{90002, 90004, 90006},
                    std::vector<int32_t>{2, 4, 6});
    CheckAndDeQueue(7003, std::vector<int32_t>{90001, 90003, 90005},
                    std::vector<int32_t>{1, 3, 5});
    EXPECT_EQ(g_dataSubscribeVec.size(), 4UL);

    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));

    // check result
    CheckQueueSize(7001, 0);
    CheckQueueSize(7002, 1);
    CheckQueueSize(7003, 1);
    // include 2 inner queue
    EXPECT_EQ(g_dataSubscribeVec.size(), 5UL);

    CheckAndDeQueue(7002, std::vector<int32_t>{90008}, std::vector<int32_t>{8});
    CheckAndDeQueue(7003, std::vector<int32_t>{90007}, std::vector<int32_t>{7});
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, Schedule_1to1_QueueToGroup_Error)
{
    MOCKER(halMbufGetPrivInfo)
        .stubs()
        .will(invoke(halMbufGetPrivInfoFake));

    // create queue 5001 and queue 5002 and queue 5003
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(7001, 10));
    CreateQueue(id2Depth, true);

    // create dst group
    EntityInfoPtr entity1 = std::make_shared<EntityInfo>(7002U, 0U);
    EntityInfoPtr entity2 = std::make_shared<EntityInfo>(7003U, 0U);
    std::vector<EntityInfoPtr> entitiesInGroup;
    entitiesInGroup.emplace_back(entity1);
    entitiesInGroup.emplace_back(entity2);
    uint32_t groupId = 0U;
    CreateGroup(entitiesInGroup, groupId);

    // bind relation1
    EntityInfo src(7001U, 0U);
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_GROUP;
    EntityInfo dst(groupId, 0U, &args);
    AddBindRelation(src, dst);
    // include 2 inner queue
    EXPECT_EQ(g_dataSubscribeVec.size(), 5UL);

    auto groupEntityMap = dgw::EntityManager::Instance().groupEntityMap_;
    auto idToEntity = dgw::EntityManager::Instance().idToEntity_;
    EXPECT_EQ(groupEntityMap.size(), 1);
    EXPECT_EQ(idToEntity[0][0].size(), 2);
    EXPECT_EQ(idToEntity[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_GROUP].size(), 1);
    EXPECT_EQ(idToEntity[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_QUEUE].size(), 3);

    // enqueue
    std::vector<int32_t> valueVec{90001, 90002, 90003, 90004, 90005, 90006, 90007, 90008};
    std::vector<int32_t> indexVec{1, 2, 3, 4, 5, 6, 7, 8};
    std::vector<EntityInfoPtr> entities;
    EntityInfoPtr entity = std::make_shared<EntityInfo>(7001U, 0U);
    entities.emplace_back(entity);
    EnQueue(entities, valueVec, indexVec);

    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));
    EXPECT_EQ(g_dataSubscribeVec.size(), 4UL);

    // check result
    // first dequeue, fail to enque entity1 for queue not exist
    // second dequeue, fail to enque entity1 for queue not exist
    // third dequeue, when visit entity1, we recognize there's sick queue in group, then delete route
    // after that, there's no schedule for src
    CheckQueueSize(7001, 5);
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, Schedule_1to1_Group2Group_Full_Success)
{
    MOCKER(halMbufGetPrivInfo)
        .stubs()
        .will(invoke(halMbufGetPrivInfoFake));

    // create queue 1001 and queue 1002
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(8001, 10));
    id2Depth.insert(std::make_pair(8002, 10));
    id2Depth.insert(std::make_pair(8003, 10));
    id2Depth.insert(std::make_pair(8004, 2));
    id2Depth.insert(std::make_pair(8005, 2));
    CreateQueue(id2Depth, true);

    // create src group
    EntityInfoPtr entity1 = std::make_shared<EntityInfo>(8003U, 0U);
    EntityInfoPtr entity2 = std::make_shared<EntityInfo>(8002U, 0U);
    EntityInfoPtr entity3 = std::make_shared<EntityInfo>(8001U, 0U);
    std::vector<EntityInfoPtr> entitiesInGroup;
    entitiesInGroup.emplace_back(entity1);
    entitiesInGroup.emplace_back(entity2);
    entitiesInGroup.emplace_back(entity3);
    uint32_t groupId = 0U;
    CreateGroup(entitiesInGroup, groupId);

    // create dst group
    EntityInfoPtr entity4 = std::make_shared<EntityInfo>(8004U, 0U);
    EntityInfoPtr entity5 = std::make_shared<EntityInfo>(8005U, 0U);
    std::vector<EntityInfoPtr> entitiesInGroup2;
    entitiesInGroup2.emplace_back(entity4);
    entitiesInGroup2.emplace_back(entity5);
    uint32_t groupId2 = 0U;
    CreateGroup(entitiesInGroup2, groupId2);

    // bind relation
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_GROUP;
    EntityInfo src(groupId, 0U, &args);
    EntityInfo dst(groupId2, 0U, &args);
    AddBindRelation(src, dst);
    
    // include 2 inner queue
    EXPECT_EQ(g_dataSubscribeVec.size(), 7UL);

    auto groupEntityMap = dgw::EntityManager::Instance().groupEntityMap_;
    auto idToEntity = dgw::EntityManager::Instance().idToEntity_;
    EXPECT_EQ(groupEntityMap.size(), 2);
    EXPECT_EQ(idToEntity[0][0].size(), 2);
    EXPECT_EQ(idToEntity[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_GROUP].size(), 2);
    EXPECT_EQ(idToEntity[0][bqs::LOCAL_Q][dgw::EntityType::ENTITY_QUEUE].size(), 5);

    // enqueue
    std::vector<int32_t> valueVec{90001, 90002, 90003, 90004, 90005, 90006, 90007, 90008};
    std::vector<int32_t> indexVec{1, 2, 3, 4, 5, 6, 7, 8};
    EnQueue(entitiesInGroup, valueVec, indexVec);

    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));
    CheckQueueSize(8004, 2);
    CheckQueueSize(8005, 2);
    CheckAndDeQueue(8004, std::vector<int32_t>{90002, 90004},
                    std::vector<int32_t>{2, 4});
    CheckAndDeQueue(8005, std::vector<int32_t>{90001, 90003},
                    std::vector<int32_t>{1, 3});

    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));
    // include 7 inner queue
    EXPECT_EQ(g_dataSubscribeVec.size(), 7UL);

    // check result
    CheckQueueSize(8001, 0);
    CheckQueueSize(8002, 0);
    CheckQueueSize(8003, 0);
    CheckQueueSize(8004, 2);
    CheckQueueSize(8005, 2);
    CheckAndDeQueue(8005, std::vector<int32_t>{90005, 90007},
                    std::vector<int32_t>{5, 7});
    CheckAndDeQueue(8004, std::vector<int32_t>{90006, 90008},
                    std::vector<int32_t>{6, 8});
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, Schedule_1to1_T2Q_FULL_Success)
{
    // create queue
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(72, 1));
    CreateQueue(id2Depth);

    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    uint32_t uniqueTagId = 7U;
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_TAG;
    args.channelPtr = &channel;
    EntityInfo src(uniqueTagId, 0U, &args);
    EntityInfo dst(72U, 0U);
    AddBindRelation(src, dst);

    // include 2 inner queue
    EXPECT_EQ(g_dataSubscribeVec.size(), 5UL);

    uint32_t headBufSize = 256U;
    char headBuf[256];
    void *headBufAddr = (void *)(&headBuf[0]);
    MOCKER(halMbufGetPrivInfo)
        .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
        .will(returnValue((int)DRV_ERROR_NONE));

    dgw::HcclProcess hcclProcess;
    // hccl recv request: 4 envelope, process 2, cache 2
    g_totalEnvelopeCount = 4U;
    event_info event;
    event.comm.event_id = dgw::EVENT_RECV_REQUEST_MSG;
    auto ret = hcclProcess.ProcessRecvRequestEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);

    dgw::EntityPtr entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
        dgw::EntityDirection::DIRECTION_SEND);
    ASSERT_NE(entity, nullptr);
    dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity.get());
    EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 2U);
    EXPECT_EQ(channelEntity->cachedEnvelopeQueue_.Size(), 2U);
    EXPECT_EQ(channelEntity->cachedReqCount_, 2U);

    // hccl recv completion
    event.comm.event_id = dgw::EVENT_RECV_COMPLETION_MSG;
    ret = hcclProcess.ProcessRecvCompletionEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);
    EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 0U);
    // CheckQueueSize(channelEntity->compReqQueueId_, 1);

    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));

    // check result
    CheckQueueSize(72, 1);

    // process cached envelope
    event.comm.event_id = dgw::EVENT_RECV_REQUEST_MSG;
    ret = hcclProcess.ProcessRecvRequestEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);
    event.comm.event_id = dgw::EVENT_RECV_COMPLETION_MSG;
    ret = hcclProcess.ProcessRecvCompletionEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);
    EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 0U);
    // CheckQueueSize(channelEntity->compReqQueueId_, 1);

    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));
    // check result
    CheckQueueSize(72, 1);
    dgw::EntityPtr queueEntity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 72,
        dgw::EntityDirection::DIRECTION_RECV);
    EXPECT_NE(queueEntity, nullptr);
    CheckAndDeQueue(72, std::vector<int32_t>{g_tagMbuf});

    // include 4 inner queue
    EXPECT_EQ(g_dataSubscribeVec.size(), 4UL);

    // waiting for work schedule
    std::this_thread::sleep_for(std::chrono::seconds(1));
    // check result
    CheckQueueSize(72, 1);
    CheckAndDeQueue(72, std::vector<int32_t>{g_tagMbuf});

    // include 2 inner queue
    EXPECT_EQ(g_dataSubscribeVec.size(), 5UL);

    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, Schedule_build_link)
{
    // create queue
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(72, 5));
    CreateQueue(id2Depth);

    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    uint32_t uniqueTagId = 7U;
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_TAG;
    args.channelPtr = &channel;
    EntityInfo src(uniqueTagId, 0U, &args);
    EntityInfo dest(72U, 0U);
    AddBindRelation(src, dest);

    // include four inner queue
    EXPECT_EQ(g_dataSubscribeVec.size(), 5UL);

    uint32_t headBufSize = 256U;
    char headBuf[256];
    void *headBufAddr = (void *)(&headBuf[0]);
    MOCKER(halMbufGetPrivInfo)
        .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
        .will(returnValue((int)DRV_ERROR_NONE));

    dgw::HcclProcess hcclProcess;
    // hccl recv request: 4 envelope, process 2, cache 2
    g_totalEnvelopeCount = 1U;
    g_link = true;
    event_info event;
    event.comm.event_id = dgw::EVENT_RECV_REQUEST_MSG;
    auto ret = hcclProcess.ProcessRecvRequestEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);

    dgw::EntityPtr entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
        dgw::EntityDirection::DIRECTION_SEND);
    ASSERT_NE(entity, nullptr);
    dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity.get());
    EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 1U);

    // hccl recv completion
    event.comm.event_id = dgw::EVENT_RECV_COMPLETION_MSG;
    ret = hcclProcess.ProcessRecvCompletionEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);
    EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 0U);
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, HcclProcess_AllocMbuf_fail1)
{
    // create queue
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(72, 5));
    CreateQueue(id2Depth);

    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    uint32_t uniqueTagId = 7U;
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_TAG;
    args.channelPtr = &channel;
    EntityInfo src(uniqueTagId, 0U, &args);
    EntityInfo dest(72U, 0U);
    AddBindRelation(src, dest);

    // include four inner queue
    EXPECT_EQ(g_dataSubscribeVec.size(), 5UL);

    uint32_t headBufSize = 256U;
    char headBuf11[256];
    void *headBufAddr = (void *)(&headBuf11[0]);
    MOCKER(halMbufGetPrivInfo)
        .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
        .will(returnValue((int)DRV_ERROR_NONE));

    dgw::HcclProcess hcclProcess;
    // hccl recv request: 4 envelope, process 2, cache 2
    g_totalEnvelopeCount = 1U;
    g_link = true;
    event_info event;
    event.comm.event_id = dgw::EVENT_RECV_REQUEST_MSG;
    auto ret = hcclProcess.ProcessRecvRequestEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);

    dgw::EntityPtr entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
        dgw::EntityDirection::DIRECTION_SEND);
    ASSERT_NE(entity, nullptr);
    dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity.get());

    MOCKER(halMbufAlloc).stubs().will(returnValue(0));

    MOCKER(halMbufSetDataLen)
        .stubs()
        .will(returnValue(-1));
    MOCKER(halMbufFree)
            .stubs()
            .will(returnValue(0));

    Mbuf *mbuf1 = nullptr;
    void *headBuf = nullptr;
    void *dataBuf = nullptr;
    const uint64_t dataSize = 128;
    channelEntity->AllocMbuf(mbuf1, headBuf, dataBuf, dataSize);
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, HcclProcess_AllocMbuf_fail2)
{
    // create queue
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(72, 5));
    CreateQueue(id2Depth);

    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    uint32_t uniqueTagId = 7U;
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_TAG;
    args.channelPtr = &channel;
    EntityInfo src(uniqueTagId, 0U, &args);
    EntityInfo dest(72U, 0U);
    AddBindRelation(src, dest);

    // include four inner queue
    EXPECT_EQ(g_dataSubscribeVec.size(), 5UL);

    dgw::HcclProcess hcclProcess;
    // hccl recv request: 4 envelope, process 2, cache 2
    g_totalEnvelopeCount = 1U;
    g_link = true;
    event_info event;
    event.comm.event_id = dgw::EVENT_RECV_REQUEST_MSG;
    auto ret = hcclProcess.ProcessRecvRequestEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);

    dgw::EntityPtr entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
        dgw::EntityDirection::DIRECTION_SEND);
    ASSERT_NE(entity, nullptr);
    dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity.get());

    MOCKER(halMbufAlloc).stubs().will(returnValue(0));

    MOCKER(halMbufSetDataLen)
        .stubs()
        .will(returnValue(0));
    MOCKER(halMbufGetPrivInfo)
        .stubs()
        .will(returnValue(-1));

    MOCKER(halMbufFree)
            .stubs()
            .will(returnValue(0));

    Mbuf *mbuf1 = nullptr;
    void *headBuf = nullptr;
    void *dataBuf = nullptr;
    const uint64_t dataSize = 128;
    channelEntity->AllocMbuf(mbuf1, headBuf, dataBuf, dataSize);
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, HcclProcess_AllocMbuf_fail3)
{
    // create queue
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(72, 5));
    CreateQueue(id2Depth);

    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    uint32_t uniqueTagId = 7U;
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_TAG;
    args.channelPtr = &channel;
    EntityInfo src(uniqueTagId, 0U, &args);
    EntityInfo dest(72U, 0U);
    AddBindRelation(src, dest);

    // include four inner queue
    EXPECT_EQ(g_dataSubscribeVec.size(), 5UL);

    dgw::HcclProcess hcclProcess;
    // hccl recv request: 4 envelope, process 2, cache 2
    g_totalEnvelopeCount = 1U;
    g_link = true;
    event_info event;
    event.comm.event_id = dgw::EVENT_RECV_REQUEST_MSG;
    auto ret = hcclProcess.ProcessRecvRequestEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);

    dgw::EntityPtr entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
        dgw::EntityDirection::DIRECTION_SEND);
    ASSERT_NE(entity, nullptr);
    dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity.get());

    MOCKER(halMbufAlloc).stubs().will(returnValue(0));

    MOCKER(halMbufSetDataLen)
        .stubs()
        .will(returnValue(0));

    MOCKER(halMbufFree)
            .stubs()
            .will(returnValue(0));
    uint32_t headBufSize = 256U;
    char headBuf11[256];
    void *headBufAddr = (void *)(&headBuf11[0]);
    MOCKER(halMbufGetPrivInfo)
        .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
        .will(returnValue((int)DRV_ERROR_NONE));
    MOCKER(halMbufGetBuffAddr)
            .stubs()
            .will(returnValue(-1));

    Mbuf *mbuf1 = nullptr;
    void *headBuf = nullptr;
    void *dataBuf = nullptr;
    const uint64_t dataSize = 128;
    channelEntity->AllocMbuf(mbuf1, headBuf, dataBuf, dataSize);
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, HcclProcess_AllocMbuf_fail4)
{
    // create queue
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(72, 5));
    CreateQueue(id2Depth);

    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    uint32_t uniqueTagId = 7U;
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_TAG;
    args.channelPtr = &channel;
    EntityInfo src(uniqueTagId, 0U, &args);
    EntityInfo dest(72U, 0U);
    AddBindRelation(src, dest);

    // include four inner queue
    EXPECT_EQ(g_dataSubscribeVec.size(), 5UL);

    MOCKER(halMbufAlloc).stubs().will(returnValue(0));

    MOCKER(halMbufSetDataLen)
        .stubs()
        .will(returnValue(0));
    uint32_t headBufSize = 256U;
    char headBuf11[256];
    void *headBufAddr = (void *)(&headBuf11[0]);
    MOCKER(halMbufGetPrivInfo)
        .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
        .will(returnValue((int)DRV_ERROR_NONE));

    MOCKER(halMbufFree)
            .stubs()
            .will(returnValue(0));
    int32_t mbufValue = 1;
    int32_t *mbuf = &mbufValue;

    MOCKER(halMbufGetBuffAddr)
        .stubs().with(mockcpp::any(),  outBoundP((void **)&mbuf))
        .will(returnValue((int)DRV_ERROR_NONE));

    dgw::HcclProcess hcclProcess;
    // hccl recv request: 4 envelope, process 2, cache 2
    g_totalEnvelopeCount = 1U;
    g_link = true;
    event_info event;
    event.comm.event_id = dgw::EVENT_RECV_REQUEST_MSG;
    auto ret = hcclProcess.ProcessRecvRequestEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);

    dgw::EntityPtr entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
        dgw::EntityDirection::DIRECTION_SEND);
    ASSERT_NE(entity, nullptr);
    dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity.get());


    Mbuf *mbuf1 = nullptr;
    void *headBuf = nullptr;
    void *dataBuf = nullptr;
    const uint64_t dataSize = 128;
    channelEntity->AllocMbuf(mbuf1, headBuf, dataBuf, dataSize);
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, HcclProcess_ReceiveMbufData_fail1)
{
    // create queue
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(72, 5));
    CreateQueue(id2Depth);

    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    uint32_t uniqueTagId = 7U;
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_TAG;
    args.channelPtr = &channel;
    EntityInfo src(uniqueTagId, 0U, &args);
    EntityInfo dest(72U, 0U);
    AddBindRelation(src, dest);

    // include four inner queue
    EXPECT_EQ(g_dataSubscribeVec.size(), 5UL);

    uint32_t headBufSize = 256U;
    char headBuf11[256];
    void *headBufAddr = (void *)(&headBuf11[0]);
    MOCKER(halMbufGetPrivInfo)
        .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
        .will(returnValue((int)DRV_ERROR_NONE));

    dgw::HcclProcess hcclProcess;
    // hccl recv request: 4 envelope, process 2, cache 2
    g_totalEnvelopeCount = 1U;
    g_link = true;
    event_info event;
    event.comm.event_id = dgw::EVENT_RECV_REQUEST_MSG;
    auto ret = hcclProcess.ProcessRecvRequestEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);

    dgw::EntityPtr entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
        dgw::EntityDirection::DIRECTION_SEND);
    ASSERT_NE(entity, nullptr);
    dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity.get());

    MOCKER(halMbufAlloc).stubs().will(returnValue(0));

    MOCKER(halMbufFree)
            .stubs()
            .will(returnValue(0));
    MOCKER_CPP(&dgw::ChannelEntity::AllocMbuf)
            .stubs()
            .will(returnValue(0));
    MOCKER(HcclImrecv)
            .stubs()
            .will(returnValue(-1));

    HcclMessage msg = nullptr;
    channelEntity->ReceiveMbufData(msg);
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, HcclProcess_ReceiveMbufData_fail2)
{
    // create queue
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(72, 5));
    CreateQueue(id2Depth);

    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    uint32_t uniqueTagId = 7U;
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_TAG;
    args.channelPtr = &channel;
    EntityInfo src(uniqueTagId, 0U, &args);
    EntityInfo dest(72U, 0U);
    AddBindRelation(src, dest);

    // include four inner queue
    EXPECT_EQ(g_dataSubscribeVec.size(), 5UL);

    uint32_t headBufSize = 256U;
    char headBuf11[256];
    void *headBufAddr = (void *)(&headBuf11[0]);
    MOCKER(halMbufGetPrivInfo)
        .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
        .will(returnValue((int)DRV_ERROR_NONE));

    dgw::HcclProcess hcclProcess;
    // hccl recv request: 4 envelope, process 2, cache 2
    g_totalEnvelopeCount = 1U;
    g_link = true;
    event_info event;
    event.comm.event_id = dgw::EVENT_RECV_REQUEST_MSG;
    auto ret = hcclProcess.ProcessRecvRequestEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);

    dgw::EntityPtr entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
        dgw::EntityDirection::DIRECTION_SEND);
    ASSERT_NE(entity, nullptr);
    dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity.get());

    MOCKER(halMbufAlloc).stubs().will(returnValue(0));

    MOCKER(halMbufFree)
            .stubs()
            .will(returnValue(0));
    MOCKER_CPP(&dgw::ChannelEntity::AllocMbuf)
            .stubs()
            .will(returnValue(0));

    MOCKER(HcclImrecv)
            .stubs()
            .will(returnValue(0));

    HcclMessage msg = nullptr;
    channelEntity->ReceiveMbufData(msg);
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, HcclProcess_SendMbufData_fail1)
{
    // create queue
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(72, 5));
    CreateQueue(id2Depth);

    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    uint32_t uniqueTagId = 7U;
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_TAG;
    args.channelPtr = &channel;
    EntityInfo src(uniqueTagId, 0U, &args);
    EntityInfo dest(72U, 0U);
    AddBindRelation(src, dest);

    // include four inner queue
    EXPECT_EQ(g_dataSubscribeVec.size(), 5UL);

    uint32_t headBufSize = 256U;
    char headBuf11[256];
    void *headBufAddr = (void *)(&headBuf11[0]);
    MOCKER(halMbufGetPrivInfo)
        .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
        .will(returnValue((int)DRV_ERROR_NONE));

    dgw::HcclProcess hcclProcess;
    // hccl recv request: 4 envelope, process 2, cache 2
    g_totalEnvelopeCount = 1U;
    g_link = true;
    event_info event;
    event.comm.event_id = dgw::EVENT_RECV_REQUEST_MSG;
    auto ret = hcclProcess.ProcessRecvRequestEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);

    dgw::EntityPtr entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
        dgw::EntityDirection::DIRECTION_SEND);
    ASSERT_NE(entity, nullptr);
    dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity.get());

    MOCKER(halMbufAlloc).stubs().will(returnValue(0));

    MOCKER(halMbufFree)
            .stubs()
            .will(returnValue(0));

    MOCKER(halMbufGetBuffSize)
            .stubs()
            .will(returnValue(-1));

    Mbuf *mbuf1 = nullptr;
    channelEntity->SendMbufData(mbuf1);
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, HcclProcess_SendMbufHead_fail1)
{
    // create queue
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(72, 5));
    CreateQueue(id2Depth);

    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    uint32_t uniqueTagId = 7U;
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_TAG;
    args.channelPtr = &channel;
    EntityInfo src(uniqueTagId, 0U, &args);
    EntityInfo dest(72U, 0U);
    AddBindRelation(src, dest);

    // include four inner queue
    EXPECT_EQ(g_dataSubscribeVec.size(), 5UL);

    dgw::HcclProcess hcclProcess;
    // hccl recv request: 4 envelope, process 2, cache 2
    g_totalEnvelopeCount = 1U;
    g_link = true;
    event_info event;
    event.comm.event_id = dgw::EVENT_RECV_REQUEST_MSG;
    auto ret = hcclProcess.ProcessRecvRequestEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);

    dgw::EntityPtr entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
        dgw::EntityDirection::DIRECTION_SEND);
    ASSERT_NE(entity, nullptr);
    dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity.get());

    MOCKER(halMbufAlloc).stubs().will(returnValue(0));

    MOCKER(halMbufFree)
            .stubs()
            .will(returnValue(0));

    MOCKER(halMbufGetPrivInfo)
            .stubs()
            .will(returnValue(-1));

    Mbuf *mbuf1 = nullptr;
    channelEntity->SendMbufHead(mbuf1);
    QueueScheduleDestroy();
}

TEST_F(BQS_QUEUE_SCHEDULE_STTest, Schedule_build_link_with_HcclTestSome_Fail)
{
    MOCKER(HcclTestSome)
        .stubs()
        .will(invoke(HcclTestSomeFakeFail));
    MOCKER(HcclTestSomeFake)
        .stubs()
        .will(invoke(HcclTestSomeFakeFail));
    // create queue
    std::map<uint32_t, int32_t> id2Depth;
    id2Depth.insert(std::make_pair(72, 5));
    CreateQueue(id2Depth);

    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
    uint32_t uniqueTagId = 7U;
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_TAG;
    args.channelPtr = &channel;
    EntityInfo src(uniqueTagId, 0U, &args);
    EntityInfo dest(72U, 0U);
    AddBindRelation(src, dest);

    // include four inner queue
    EXPECT_EQ(g_dataSubscribeVec.size(), 5UL);

    uint32_t headBufSize = 256U;
    char headBuf[256];
    void *headBufAddr = (void *)(&headBuf[0]);
    MOCKER(halMbufGetPrivInfo)
        .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
        .will(returnValue((int)DRV_ERROR_NONE));

    dgw::HcclProcess hcclProcess;
    // hccl recv request: 4 envelope, process 2, cache 2
    g_totalEnvelopeCount = 1U;
    g_link = true;
    event_info event;
    event.comm.event_id = dgw::EVENT_RECV_REQUEST_MSG;
    auto ret = hcclProcess.ProcessRecvRequestEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);

    dgw::EntityPtr entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
        dgw::EntityDirection::DIRECTION_SEND);
    ASSERT_NE(entity, nullptr);
    dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity.get());
    EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 1U);

    // hccl recv completion
    event.comm.event_id = dgw::EVENT_RECV_COMPLETION_MSG;
    ret = hcclProcess.ProcessRecvCompletionEvent(event, 0U, 0U);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);
    EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 1U);
    QueueScheduleDestroy();
}

class QUEUE_SCHEDULE_STest : public testing::Test {
protected:
    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }

    void QueueScheduleDestroy(bqs::QueueSchedule &queueSchedule)
    {
        queueSchedule.StopQueueSchedule();
        queueSchedule.WaitForStop();
        DelAllBindRelation();
        queueSchedule.Destroy();
    }

    void DelAllBindRelation()
    {
        std::vector<std::tuple<bqs::EntityInfo, bqs::EntityInfo>> allRelation;
        auto& bindRelation = bqs::BindRelation::GetInstance();
        auto& dstToSrcRelation = bindRelation.GetDstToSrcRelation();
        for (auto& relation : dstToSrcRelation) {
            const auto &dstId = relation.first;
            for (auto srcId : relation.second){
                allRelation.emplace_back(std::make_tuple(srcId, dstId));
            }
        }

        for (auto& relation : allRelation) {
            auto &srcId = std::get<0>(relation);
            auto &dstId = std::get<1>(relation);
            bqs::BqsStatus ret = bindRelation.UnBind(srcId, dstId);
            EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
        }
    }
};

TEST_F(QUEUE_SCHEDULE_STest, start_schedule_success)
{
    MOCKER(halEschedWaitEvent).stubs().will(returnValue(DRV_ERROR_SCHED_INNER_ERR));
    MOCKER(BindCpuUtils::BindAicpu).stubs().will(returnValue(BQS_STATUS_OK));
    MOCKER(&QueueScheduleInterface::GetAicpuPhysIndex).stubs().will(returnValue(1));
    bqs::QueueSchedule queueSchedule{{0, 0, 1, 30U}};
    queueSchedule.running_ = true;
    BindCpuUtils::InitSem();
    EXPECT_EQ(queueSchedule.StartThreadGroup(1U, 0U, 0U, 0U), BQS_STATUS_OK);
    queueSchedule.WaitForStop();
}

TEST_F(QUEUE_SCHEDULE_STest, LoopProcessEnqueueEvent_with_halEschedWaitEventFail)
{
    MOCKER(halEschedWaitEvent)
        .stubs()
        .will(invoke(halEschedWaitEventErrorOrTimeOut));

    bqs::QueueSchedule queueSchedule{{0, 0, 1, 30U}};

    std::thread controlThread {[&] {
        usleep(50);
        g_schedule_wait_fake_to_err = true;
        usleep(1000);

        g_schedule_wait_fake_to_err = false;
        usleep(50);

        g_schedule_wait_fake_to_param_err = true;
        usleep(50);
        queueSchedule.running_ = false;
    }};

    queueSchedule.running_ = true;
    queueSchedule.LoopProcessEnqueueEvent(1U, 0U, 0U, 0U);

    controlThread.join();
    EXPECT_FALSE(queueSchedule.running_);
}

TEST_F(QUEUE_SCHEDULE_STest, StartWithAos_SUCCESS)
{
    char *hostNameAos = "AOS_SD";
    MOCKER(gethostname)
        .stubs().with(outBoundP(hostNameAos, strlen(hostNameAos) + 1))
        .will(returnValue(0));
    MOCKER(bqs::GetRunContext).stubs().will(returnValue(bqs::RunContext::DEVICE));
    MOCKER(&QueueScheduleInterface::GetAicpuPhysIndex).stubs().will(returnValue(1));
    bqs::QueueSchedule queueSchedule{{0, 0, 1}};
    int32_t ret = queueSchedule.StartQueueSchedule();
    EXPECT_EQ(ret, BQS_STATUS_OK);

    QueueScheduleDestroy(queueSchedule);
}

TEST_F(QUEUE_SCHEDULE_STest, StartWithDeviceBindAicpu_FAILED)
{
    MOCKER(bqs::GetRunContext).stubs().will(returnValue(bqs::RunContext::DEVICE));
    MOCKER(BindCpuUtils::BindAicpu).stubs().will(returnValue(BQS_STATUS_INNER_ERROR));
    MOCKER(&QueueScheduleInterface::GetAiCpuNum).stubs().will(returnValue(1));
    MOCKER(&QueueScheduleInterface::GetAicpuPhysIndex).stubs().will(returnValue(1));
    bqs::QueueSchedule queueSchedule{{0, 0, 1}};
    int32_t ret = queueSchedule.StartQueueSchedule();
    EXPECT_EQ(queueSchedule.running_, false);

    QueueScheduleDestroy(queueSchedule);
}

TEST_F(QUEUE_SCHEDULE_STest, ChannelEntity_ProcessSendCompleteion_success)
{
    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
    uint32_t uniqueTagId = 100U;
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    material.channel = &channel;
    material.id = uniqueTagId;
    auto channelEntity= std::make_shared<dgw::ChannelEntity>(material, 0U);

    MbufTypeInfo typeInfo = {};
    typeInfo.type = static_cast<uint32_t>(MBUF_CREATE_BY_BUILD);
    MOCKER(halBuffGetInfo)
        .stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP((void*)(&typeInfo)), mockcpp::any())
        .will(returnValue(0));

    auto ret = channelEntity->ProcessSendCompletion(nullptr);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);
}

TEST_F(QUEUE_SCHEDULE_STest, ChannelEntity_ProcessSendCompleteion_success_with_halBuffGetInfo_Fail)
{
    dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
    uint32_t uniqueTagId = 100U;
    dgw::EntityMaterial material = {};
    material.eType = dgw::EntityType::ENTITY_TAG;
    material.channel = &channel;
    material.id = uniqueTagId;
    auto channelEntity= std::make_shared<dgw::ChannelEntity>(material, 0U);

    MOCKER(halBuffGetInfo)
        .stubs()
        .will(returnValue(1));

    auto ret = channelEntity->ProcessSendCompletion(nullptr);
    EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);
}

TEST_F(QUEUE_SCHEDULE_STest, GetInstanceConnectFailedServerNotCreate)
{
    MOCKER(usleep).stubs().will(returnValue(0));
    MOCKER(sleep).stubs().will(returnValue(0U));
    bqs::BqsClient* bqsClient = bqs::BqsClient::GetInstance("test", 4, PipBrokenException);
    if (bqsClient != nullptr) {
        bqsClient->initFlag_ = false;
        MOCKER(EzcomCreateClient)
            .stubs()
            .will(returnValue(-2));
        bqs::BqsClient* bqsClientptr = bqs::BqsClient::GetInstance("test", 4, PipBrokenException);
        EXPECT_EQ(bqsClientptr, nullptr);
    }
}

TEST_F(QUEUE_SCHEDULE_STest, EnqueueAsynMemBuffEventBuffFailed)
{
    MOCKER(halQueueEnQueue).stubs().will(returnValue(200));
    bqs::QueueManager::GetInstance().asyncMemDequeueBuffQId_ = 103;
    bqs::QueueManager::GetInstance().isTriggeredByAsyncMemDequeue_ = true;
    bqs::BqsStatus ret = bqs::QueueManager::GetInstance().EnqueueAsynMemBuffEvent();
    bqs::QueueManager::GetInstance().isTriggeredByAsyncMemEnqueue_ = true;
    ret = bqs::QueueManager::GetInstance().EnqueueAsynMemBuffEvent();
    EXPECT_EQ(ret, bqs::BQS_STATUS_DRIVER_ERROR);
}

TEST_F(QUEUE_SCHEDULE_STest, EnqueueAsynMemBuffEventBuffSuccess)
{
    MOCKER(halQueueEnQueue).stubs().will(returnValue(0));
    bqs::QueueManager::GetInstance().asyncMemDequeueBuffQId_ = 103;
    bqs::QueueManager::GetInstance().isTriggeredByAsyncMemDequeue_ = true;
    bqs::QueueManager::GetInstance().isTriggeredByAsyncMemEnqueue_ = true;
    bqs::BqsStatus ret = bqs::QueueManager::GetInstance().EnqueueAsynMemBuffEvent();
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
}

TEST_F(QUEUE_SCHEDULE_STest, HandleAsynMemBuffEventSuccess)
{
    MOCKER(halQueueDeQueue).stubs().will(returnValue((int)DRV_ERROR_NONE)).then(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
    MOCKER(halMbufFree).stubs().will(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
    bqs::QueueManager::GetInstance().isTriggeredByAsyncMemDequeue_ = true;
    bqs::QueueManager::GetInstance().isTriggeredByAsyncMemEnqueue_ = true;
    bqs::QueueManager::GetInstance().asyncMemDequeueBuffQId_ = 101;
    bool ret = bqs::QueueManager::GetInstance().HandleAsynMemBuffEvent(0);
    EXPECT_EQ(ret, true);
}

TEST_F(QUEUE_SCHEDULE_STest, Start_DeviceVec_SUCCESS)
{
    MOCKER(BindCpuUtils::BindAicpu)
            .stubs()
            .will(returnValue(BQS_STATUS_OK));
    MOCKER(&QueueScheduleInterface::GetAicpuPhysIndex).stubs().will(returnValue(1));
    MOCKER(&QueueScheduleInterface::GetExtraAicpuPhysIndex).stubs().will(returnValue(1));
    MOCKER(HcclSetGrpIdCallback).stubs().will(returnValue(HCCL_SUCCESS));
    bqs::QueueSchedule queueSchedule{{0, 0, 1}};
    queueSchedule.initQsParams_.numaFlag = true;
    queueSchedule.initQsParams_.devIdVec = {1,2};
    int32_t ret = queueSchedule.StartQueueSchedule();
    EXPECT_EQ(ret, BQS_STATUS_OK);

    QueueScheduleDestroy(queueSchedule);
    queueSchedule.initQsParams_.numaFlag = false;
    GlobalCfg::GetInstance().SetNumaFlag(false);
    GlobalCfg::GetInstance().deviceIdToResIndex_.clear();
    GlobalMockObject::verify();
}

drvError_t halQueuePeekFake(unsigned int devId, unsigned int qid, uint64_t *buf_len, int timeout)
{
    std::cout << "peek fake" << std::endl;
    *buf_len = 256U;
    return DRV_ERROR_NONE;
}

TEST_F(QUEUE_SCHEDULE_STest, ScheduleDataBuffAll_MemQueue_ProcessAsysnc_failed)
{
    GlobalMockObject::verify();
    bqs::BqsStatus ret = bqs::QueueManager::GetInstance().InitQueueManager(0, 0, true, "iniQ");
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    dgw::EntityManager::Instance(0).SetExistAsyncMemEntity();
    bool dataEnqueue = true;
    bqs::QueueSchedule queueSchedule{{0, 0, 1}};
    queueSchedule.ScheduleDataBuffAll(dataEnqueue);
}

TEST_F(QUEUE_SCHEDULE_STest, ScheduleDataBuffAll_MemQueue_ProcessAsysnc_success01)
{
    GlobalMockObject::verify();
    bqs::BqsStatus ret = bqs::QueueManager::GetInstance().InitQueueManager(0, 0, true, "iniQ");
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    dgw::EntityManager::Instance(0).SetExistAsyncMemEntity();

    auto &bindRelation = BindRelation::GetInstance();
    auto srcEntity = EntityInfo(1261U, 0U);
    auto dstEntity = EntityInfo(1271U, 0U);
    bindRelation.Bind(srcEntity, dstEntity);
    bindRelation.Order();
    bool dataEnqueue = true;
    bqs::QueueSchedule queueSchedule{{0, 0, 1}};
    queueSchedule.ScheduleDataBuffAll(dataEnqueue); 
    sleep(1);
    GlobalMockObject::verify();
}

TEST_F(QUEUE_SCHEDULE_STest, ScheduleDataBuffAll_MemQueue_ProcessAsysnc_success02)
{
    GlobalMockObject::verify();
    bqs::BqsStatus ret = bqs::QueueManager::GetInstance().InitQueueManager(0, 0, true, "iniQ");
    EXPECT_EQ(ret, bqs::BQS_STATUS_OK);
    dgw::EntityManager::Instance(0).SetExistAsyncMemEntity();

    auto &bindRelation = BindRelation::GetInstance();
    std::vector<EntityInfoPtr> entities;
    EntityInfoPtr entity1 = std::make_shared<EntityInfo>(1281U, 0U);
    EntityInfoPtr entity2 = std::make_shared<EntityInfo>(1291U, 0U);
    uint32_t groupId;
    entities.emplace_back(entity1);
    entities.emplace_back(entity2);
    bindRelation.CreateGroup(entities, groupId);
    bqs::OptionalArg args = {};
    args.eType = dgw::EntityType::ENTITY_GROUP;
    auto dstEntity = EntityInfo(1293U, 0U, &args);
    EntityInfo src(1298U, 0U);
    EntityInfo dst(groupId, 0U, &args);
    bindRelation.Bind(src, dst);
    bindRelation.Order();
    bool dataEnqueue = true;
    bqs::QueueSchedule queueSchedule{{0, 0, 1}};
    queueSchedule.ScheduleDataBuffAll(dataEnqueue);
    sleep(1);
    GlobalMockObject::verify();
}

TEST_F(QUEUE_SCHEDULE_STest, GetInstance_001)
{
    MOCKER(nanosleep).stubs().will(returnValue(0));
    MOCKER(EzcomCreateClient).stubs().will(returnValue(-2));
    MOCKER_CPP(&bqs::FeatureCtrl::IsAosCore).stubs().will(returnValue(true));
    bqs::BqsClient* bqsClient = bqs::BqsClient::GetInstance("test", 4, PipBrokenException);
    EXPECT_EQ(bqsClient, nullptr);
}

TEST_F(QUEUE_SCHEDULE_STest, BindQueueMbufPool)
{
    std::vector<bqs::BQSBindQueueMbufPoolItem> bindQueueVec;
    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    uint32_t result = bqs::BqsClient::GetInstance("test", 4, PipBrokenException)->
            BindQueueMbufPool(bindQueueVec, bindResultVec);
    EXPECT_EQ(result, 0);
}

TEST_F(QUEUE_SCHEDULE_STest, UnbindQueueMbufPool)
{
    std::vector<bqs::BQSUnbindQueueMbufPoolItem> bindQueueVec;
    std::vector<bqs::BQSBindQueueResult> bindResultVec;
    uint32_t result = bqs::BqsClient::GetInstance("test", 4, PipBrokenException)->
            UnbindQueueMbufPool(bindQueueVec, bindResultVec);
    EXPECT_EQ(result, 0);
}

TEST_F(QUEUE_SCHEDULE_STest, BindQueueInterChip)
{
    bqs::BindQueueInterChipInfo interChipInfo;
    uint32_t result = bqs::BqsClient::GetInstance("test", 4, PipBrokenException)->
            BindQueueInterChip(interChipInfo);
    EXPECT_EQ(result, 0);
}

TEST_F(QUEUE_SCHEDULE_STest, UnbindQueueInterChip)
{
    uint32_t result = bqs::BqsClient::GetInstance("test", 4, PipBrokenException)->
            UnbindQueueInterChip(0);
    EXPECT_EQ(result, 0);
}

TEST_F(QUEUE_SCHEDULE_STest, SendBqsMsgFailForMemCpy)
{
    MOCKER(memset_s).stubs().will(returnValue(EINVAL));
    bqs::BQSMsg bqsReqMsg;
    bqs::BQSMsg bqsRespMsg;
    bqs::BqsStatus ret = bqs::EzcomClient::GetInstance(0)->SendBqsMsg(bqsReqMsg, bqsRespMsg);
    EXPECT_EQ(ret, bqs::BQS_STATUS_INNER_ERROR);
}

TEST_F(QUEUE_SCHEDULE_STest, SendBqsMsgFailForPbSerialize)
{
    MOCKER_CPP(&bqs::BQSMsg::SerializePartialToArray).stubs().will(returnValue(false));
    bqs::BQSMsg bqsReqMsg;
    bqs::BQSMsg bqsRespMsg;
    bqs::BqsStatus ret = bqs::EzcomClient::GetInstance(0)->SendBqsMsg(bqsReqMsg, bqsRespMsg);
    EXPECT_EQ(ret, bqs::BQS_STATUS_INNER_ERROR);
}

int EzcomRPCSyncSuccessFake(int fd, struct EzcomRequest *req, struct EzcomResponse *resp)
{
    std::cout << "EzcomRPCSync stub  begin" << std::endl;
    resp->size = req->size;
    char *respData = new (std::nothrow) char[req->size];
    memcpy(respData, (char*)req->data, req->size);
    resp->data = (uint8_t*)respData;
    std::cout << "EzcomRPCSync stub end" << std::endl;
    return 0;
}
TEST_F(QUEUE_SCHEDULE_STest, SendBqsMsgFailForPbParse)
{
    MOCKER(EzcomRPCSync)
        .stubs()
        .will(invoke(EzcomRPCSyncSuccessFake));
    MOCKER_CPP(&bqs::BQSMsg::ParseFromArray).stubs().will(returnValue(false));
    bqs::BQSMsg bqsReqMsg;
    bqs::BQSMsg bqsRespMsg;
    bqs::BqsStatus ret = bqs::EzcomClient::GetInstance(0)->SendBqsMsg(bqsReqMsg, bqsRespMsg);
    EXPECT_EQ(ret, bqs::BQS_STATUS_INNER_ERROR);
}