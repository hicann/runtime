/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <atomic>
#include <unordered_set>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#define private public
#define protected public
#include "hccl/hccl_types_in.h"
#include "entity_manager.h"
#include "client_entity.h"
#include "server/bind_relation.h"
#include "server/queue_schedule.h"
#include "server/queue_manager.h"
#include "server/statistic_manager.h"
#include "peek_state.h"
#include "wait_push_state.h"
#include "try_push_state.h"
#include "strategy/broadcast_strategy.h"
#include "strategy/hash_strategy.h"
#include "hccl/comm_channel_manager.h"
#include "dynamic_sched_mgr.hpp"
#include "schedule_config.h"
#include "state_manager.h"
#include "subscribe_manager.h"
#include "fsm/push_state.h"
#include "profile_manager.h"
#include "simple_entity.h"
#include "channel_entity.h"
#include "hccl_process.h"
#undef private
#undef protected

#include "common/bqs_status.h"
#include "server/bqs_server.h"
#include "driver/ascend_hal_define.h"
#include "server/bind_cpu_utils.h"
#include "easy_comm.h"
#include "server/router_server.h"
#include "common/bqs_util.h"
#include "driver/ascend_hal.h"
#include "qs_interface_process.h"
#include "simple_entity.h"

namespace bqs {
    namespace {
        uint64_t g_buffer[1025] = { 0 };
        uint32_t g_tagMbuf = 256U;
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

        int32_t eSchedWaitTimes = 0;
        HcclResult g_hcclIsendRet = HCCL_SUCCESS;
        struct TestStatus {
            TestStatus(){
                clear();
            }

            void clear(){
                isDistory = false;
                isDaemonThreadWork = false;
            }
            bool isDistory;
            bool isDaemonThreadWork;
        };
        TestStatus testStatus;

        drvError_t halEschedWaitEventFake(unsigned int devId, unsigned int grpId,
            unsigned int threadId, int timeout, struct event_info *event)
        {
            if (eSchedWaitTimes == 0 && event != nullptr) {
                event->comm.event_id = EVENT_AICPU_MSG;
            } else if (event != nullptr) {
                event->comm.event_id = EVENT_QUEUE_ENQUEUE;
            }
            eSchedWaitTimes++;
            if (eSchedWaitTimes > 1) {
                eSchedWaitTimes = 0;
            }

            sleep(1);
            return DRV_ERROR_NONE;
        }

        drvError_t halQueuePeekFake(unsigned int devId, unsigned int qid, uint64_t *buf_len, int timeout)
        {
            *buf_len = 256U;
            return DRV_ERROR_NONE;
        }

        drvError_t MbufAllocFake(unsigned int size, Mbuf **mbuf)
        {
            *(uint32_t **) mbuf = &g_tagMbuf;
            return DRV_ERROR_NONE;
        }

        drvError_t halQueueCtrlEventDoWork (struct QueueSubscriber *subscriber, QUE_EVENT_CMD cmdType)
        {
            testStatus.isDaemonThreadWork = true;
            return DRV_ERROR_NONE;
        }

        drvError_t halEschedWaitEventSleep(unsigned int devId, unsigned int grpId,
            unsigned int threadId, int timeout, struct event_info *event)
        {
            std::this_thread::sleep_for(std::chrono::seconds(10));
            return DRV_ERROR_NONE;
        }

        bool HandleFullToNotFullEventSleep()
        {
            std::this_thread::sleep_for(std::chrono::seconds(40));
            return true;
        }

        int gethostnamefake(char *name, size_t len)
        {
            memcpy(name, "AOS_SD", 6);
            return 0;
        }

        void QueueScheduleDestroy(bqs::QueueSchedule &queueSchedule)
        {
            queueSchedule.StopQueueSchedule();
            queueSchedule.WaitForStop();
            queueSchedule.Destroy();
        }

        int HcclIsendFake(void *buffer, int count, HcclDataType dataType, int dstRank,
                          int tag, HcclComm comm, HcclRequest *request)
        {
            std::cout << "HcclIsendWithEventFake begin, g_hcclIsendRet is:" << g_hcclIsendRet << std::endl;
            return (int)g_hcclIsendRet;
        }

        void ClearEntity(const EntityInfo &entity)
        {
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

        int halMbufCopyRefFake(Mbuf *mbuf, Mbuf **newMbuf) {
            *newMbuf = mbuf;
            return static_cast<int32_t>(DRV_ERROR_NONE);
        }
    }

    class QueueScheduleSTest : public testing::Test {
    protected:
        static void SetUpTestCase()
        {
            GlobalCfg::GetInstance().RecordDeviceId(0U, 0U, 0U);
            Subscribers::GetInstance().InitSubscribeManagers(std::set<uint32_t>{0U}, 0U);
            std::cout << "QueueScheduleSTest SetUpTestCase" << std::endl;
        }

        static void TearDownTestCase()
        {
            Subscribers::GetInstance().subscribeManagers_.clear();
            GlobalCfg::GetInstance().deviceIdToResIndex_.clear();
            std::cout << "QueueScheduleSTest TearDownTestCase" << std::endl;
        }
        virtual void SetUp()
        {
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
            MOCKER(BindCpuUtils::InitSem)
                .stubs()
                .will(returnValue(BQS_STATUS_OK));
            MOCKER(BindCpuUtils::WaitSem)
                .stubs()
                .will(returnValue(BQS_STATUS_OK));
            MOCKER(BindCpuUtils::PostSem)
                .stubs()
                .will(returnValue(BQS_STATUS_OK));
            MOCKER(BindCpuUtils::DestroySem)
                .stubs()
                .will(returnValue(BQS_STATUS_OK));
            MOCKER_CPP(&RouterServer::InitRouterServer)
                .stubs()
                .will(returnValue(BQS_STATUS_OK));
            MOCKER(HcclIsend)
                .stubs()
                .will(invoke(HcclIsendFake));
            queueSchedule.qsInitGroupName_ = "Default";
        }

        virtual void TearDown()
        {
            queueSchedule.StopQueueSchedule();
            queueSchedule.WaitForStop();
            testStatus.clear();
            g_hcclIsendRet = HCCL_SUCCESS;
            DelAllBindRelation();
            GlobalMockObject::verify();
        }

    public:
        QueueSchedule queueSchedule{{0, 0, 1, 30U}};
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

    TEST_F(QueueScheduleSTest, drvGetCpuInfo_success)
    {
        MOCKER(bqs::GetRunContext).stubs().will(returnValue(bqs::RunContext::DEVICE));
        MOCKER(&QueueScheduleInterface::GetAicpuPhysIndex).stubs().will(returnValue(1));
        queueSchedule.initQsParams_.schedPolicy = 1U;
        int32_t ret = queueSchedule.StartQueueSchedule();
        std::cout <<"reschedInterval_" <<queueSchedule.reschedInterval_<<std::endl;
        EXPECT_EQ(ret, BQS_STATUS_OK);
        EXPECT_EQ(dgw::EntityManager::Instance().ShouldPauseSubscirpiton(), false);
        QueueScheduleDestroy(queueSchedule);
        queueSchedule.initQsParams_.schedPolicy = 0U;
    }

    TEST_F(QueueScheduleSTest, halEschedAttachDevice_failed)
    {
        MOCKER(halEschedAttachDevice)
                .stubs()
                .will(returnValue((int) DRV_ERROR_IOCRL_FAIL));
        int32_t ret = queueSchedule.StartQueueSchedule();
        EXPECT_EQ(ret, BQS_STATUS_DRIVER_ERROR);
        QueueScheduleDestroy(queueSchedule);
    }

    TEST_F(QueueScheduleSTest, halEschedCreateGrp_failed)
    {
        MOCKER(halEschedCreateGrp)
                .stubs()
                .will(returnValue((int) DRV_ERROR_IOCRL_FAIL));
        int32_t ret = queueSchedule.StartQueueSchedule();
        EXPECT_EQ(ret, BQS_STATUS_DRIVER_ERROR);
        QueueScheduleDestroy(queueSchedule);
    }

    TEST_F(QueueScheduleSTest, BuffQueueInit_failed)
    {
        MOCKER(halQueueInit)
                .stubs()
                .will(returnValue((int) DRV_ERROR_IOCRL_FAIL));
        int32_t ret = queueSchedule.StartQueueSchedule();
        EXPECT_EQ(ret, BQS_STATUS_DRIVER_ERROR);
        QueueScheduleDestroy(queueSchedule);
    }

    TEST_F(QueueScheduleSTest, Start_SUCCESS)
    {
        MOCKER(BindCpuUtils::BindAicpu)
                .stubs()
                .will(returnValue(BQS_STATUS_OK));
        MOCKER(&QueueScheduleInterface::GetAicpuPhysIndex).stubs().will(returnValue(1));
        int32_t ret = queueSchedule.StartQueueSchedule();
        EXPECT_EQ(ret, BQS_STATUS_OK);

        QueueScheduleDestroy(queueSchedule);
    }

    TEST_F(QueueScheduleSTest, StartWithZeroAicpuCore_SUCCESS)
    {
        uint32_t aicpuNumZero = 0U;
        MOCKER(BindCpuUtils::BindAicpu)
                .stubs()
                .will(returnValue(BQS_STATUS_OK));
        MOCKER(&QueueScheduleInterface::GetAicpuPhysIndex).stubs().will(returnValue(1));
        int32_t ret = queueSchedule.StartQueueSchedule();
        EXPECT_EQ(ret, BQS_STATUS_OK);

        QueueScheduleDestroy(queueSchedule);
    }

    TEST_F(QueueScheduleSTest, Start_SD_SUCCESS)
    {
        MOCKER(BindCpuUtils::BindAicpu)
                .stubs()
                .will(returnValue(BQS_STATUS_OK));

        MOCKER(gethostname)
                .stubs()
                .will(invoke(gethostnamefake));
        MOCKER(&QueueScheduleInterface::GetAicpuPhysIndex).stubs().will(returnValue(1));

        int32_t ret = queueSchedule.StartQueueSchedule();
        EXPECT_EQ(ret, BQS_STATUS_OK);

        QueueScheduleDestroy(queueSchedule);
    }

    TEST_F(QueueScheduleSTest, BindCpu_failed)
    {
        MOCKER(BindCpuUtils::BindAicpu)
                .stubs()
                .will(returnValue(BQS_STATUS_INNER_ERROR));
        MOCKER(&QueueScheduleInterface::GetAicpuPhysIndex).stubs().will(returnValue(1));
        int32_t ret = queueSchedule.StartQueueSchedule();
        EXPECT_EQ(ret, BQS_STATUS_OK);
        QueueScheduleDestroy(queueSchedule);
    }

    TEST_F(QueueScheduleSTest, StartWithAos_SUCCESS)
    {
        char *hostNameAos = "AOS_SD";
        MOCKER(gethostname)
            .stubs().with(outBoundP(hostNameAos, strlen(hostNameAos) + 1))
            .will(returnValue(0));
        MOCKER(bqs::GetRunContext).stubs().will(returnValue(bqs::RunContext::DEVICE));
        MOCKER(&QueueScheduleInterface::GetAicpuPhysIndex).stubs().will(returnValue(1));
        int32_t ret = queueSchedule.StartQueueSchedule();
        EXPECT_EQ(ret, BQS_STATUS_OK);

        QueueScheduleDestroy(queueSchedule);
    }

    TEST_F(QueueScheduleSTest, StartWithDeviceBindAicpu_FAILED)
    {
        MOCKER(bqs::GetRunContext).stubs().will(returnValue(bqs::RunContext::DEVICE));
        MOCKER(BindCpuUtils::BindAicpu).stubs().will(returnValue(BQS_STATUS_INNER_ERROR));
        MOCKER(&QueueScheduleInterface::GetAiCpuNum).stubs().will(returnValue(1));
        MOCKER(&QueueScheduleInterface::GetAicpuPhysIndex).stubs().will(returnValue(1));
        int32_t ret = queueSchedule.StartQueueSchedule();
        sleep(1);
        EXPECT_EQ(queueSchedule.running_, false);

        QueueScheduleDestroy(queueSchedule);
    }

    TEST_F(QueueScheduleSTest, Start_Fail_for_routerInit)
    {
        GlobalMockObject::verify();
        MOCKER(BindCpuUtils::InitSem)
                .stubs()
                .will(returnValue(BQS_STATUS_OK));
        MOCKER(BindCpuUtils::WaitSem)
            .stubs()
            .will(returnValue(BQS_STATUS_OK));
        MOCKER(BindCpuUtils::PostSem)
            .stubs()
            .will(returnValue(BQS_STATUS_OK));
        MOCKER(BindCpuUtils::DestroySem)
            .stubs()
            .will(returnValue(BQS_STATUS_OK));
        MOCKER(BindCpuUtils::BindAicpu)
                .stubs()
                .will(returnValue(BQS_STATUS_OK));
        MOCKER(&QueueScheduleInterface::GetAicpuPhysIndex).stubs().will(returnValue(1));
        MOCKER(&RouterServer::InitRouterServer).stubs().will(returnValue(BQS_STATUS_INNER_ERROR));
        int32_t ret = queueSchedule.StartQueueSchedule();
        EXPECT_EQ(ret, BQS_STATUS_INNER_ERROR);

        QueueScheduleDestroy(queueSchedule);
    }

    TEST_F(QueueScheduleSTest, Start_Thread_SUCCESS)
    {
        MOCKER(BindCpuUtils::BindAicpu).stubs().will(returnValue(BQS_STATUS_OK));
        MOCKER(gethostname).stubs().will(invoke(gethostnamefake));
        MOCKER(bqs::GetRunContext).stubs().will(returnValue(bqs::RunContext::DEVICE));
        int32_t ret = queueSchedule.StartQueueSchedule();
        EXPECT_EQ(ret, BQS_STATUS_OK);

        QueueScheduleDestroy(queueSchedule);
    }

    TEST_F(QueueScheduleSTest, Start_AcrossNuma_SUCCESS)
    {
        MOCKER(BindCpuUtils::BindAicpu)
                .stubs()
                .will(returnValue(BQS_STATUS_OK));
        MOCKER(&QueueScheduleInterface::GetAiCpuNum).stubs().will(returnValue(1U));
        MOCKER(&QueueScheduleInterface::GetExtraAiCpuNum).stubs().will(returnValue(1U));
        MOCKER(&QueueScheduleInterface::GetAicpuPhysIndex).stubs().will(returnValue(1));
        MOCKER(&QueueScheduleInterface::GetExtraAicpuPhysIndex).stubs().will(returnValue(1));
        MOCKER(HcclSetGrpIdCallback).stubs().will(returnValue(HCCL_SUCCESS));
        queueSchedule.initQsParams_.numaFlag = true;
        int32_t ret = queueSchedule.StartQueueSchedule();
        EXPECT_EQ(ret, BQS_STATUS_OK);

        QueueScheduleDestroy(queueSchedule);
        queueSchedule.initQsParams_.numaFlag = false;
        GlobalCfg::GetInstance().SetNumaFlag(false);
        GlobalCfg::GetInstance().deviceIdToResIndex_.clear();
    }

    TEST_F(QueueScheduleSTest, Start_AcrossNuma_FAIL_InitDrvSchedModule)
    {
        MOCKER(BindCpuUtils::BindAicpu)
                .stubs()
                .will(returnValue(BQS_STATUS_OK));
        MOCKER(&QueueScheduleInterface::GetAiCpuNum).stubs().will(returnValue(0U));
        MOCKER(&QueueScheduleInterface::GetAicpuPhysIndex).stubs().will(returnValue(1));
        MOCKER_CPP(&QueueSchedule::InitDrvSchedModule)
            .stubs()
            .will(returnValue(BQS_STATUS_OK))
            .then(returnValue(BQS_STATUS_DRIVER_ERROR));
        queueSchedule.initQsParams_.numaFlag = true;
        int32_t ret = queueSchedule.StartQueueSchedule();
        EXPECT_EQ(ret, BQS_STATUS_DRIVER_ERROR);

        QueueScheduleDestroy(queueSchedule);
        queueSchedule.initQsParams_.numaFlag = false;
        GlobalCfg::GetInstance().SetNumaFlag(false);
        GlobalCfg::GetInstance().deviceIdToResIndex_.clear();
    }

    TEST_F(QueueScheduleSTest, Start_AcrossNuma_FAIL_StartThreadGroup)
    {
        MOCKER(BindCpuUtils::BindAicpu)
                .stubs()
                .will(returnValue(BQS_STATUS_OK));
        MOCKER(bqs::GetRunContext).stubs().will(returnValue(bqs::RunContext::DEVICE));
        MOCKER(&QueueScheduleInterface::GetExtraAiCpuNum).stubs().will(returnValue(0U));
        MOCKER(&QueueScheduleInterface::GetAicpuPhysIndex).stubs().will(returnValue(1));
        MOCKER(&QueueScheduleInterface::GetExtraAicpuPhysIndex).stubs().will(returnValue(1));
        MOCKER_CPP(&QueueSchedule::StartThreadGroup)
            .stubs()
            .will(returnValue(BQS_STATUS_OK))
            .then(returnValue(BQS_STATUS_DRIVER_ERROR));
        queueSchedule.initQsParams_.numaFlag = true;
        int32_t ret = queueSchedule.StartQueueSchedule();
        EXPECT_EQ(ret, BQS_STATUS_DRIVER_ERROR);

        QueueScheduleDestroy(queueSchedule);
        queueSchedule.initQsParams_.numaFlag = false;
        GlobalCfg::GetInstance().SetNumaFlag(false);
        GlobalCfg::GetInstance().deviceIdToResIndex_.clear();
    }

    TEST_F(QueueScheduleSTest, Start_AcrossNuma_FAIL_HcclSetGrpIdCallback)
    {
        MOCKER(BindCpuUtils::BindAicpu)
                .stubs()
                .will(returnValue(BQS_STATUS_OK));
        MOCKER(&QueueScheduleInterface::GetAicpuPhysIndex).stubs().will(returnValue(1));
        MOCKER(&QueueScheduleInterface::GetExtraAicpuPhysIndex).stubs().will(returnValue(1));
        MOCKER(HcclSetGrpIdCallback).stubs().will(returnValue(HCCL_E_PARA));
        queueSchedule.initQsParams_.numaFlag = true;
        int32_t ret = queueSchedule.StartQueueSchedule();
        EXPECT_EQ(ret, BQS_STATUS_HCCL_ERROR);

        QueueScheduleDestroy(queueSchedule);
        queueSchedule.initQsParams_.numaFlag = false;
        GlobalCfg::GetInstance().SetNumaFlag(false);
        GlobalCfg::GetInstance().deviceIdToResIndex_.clear();
    }

    TEST_F(QueueScheduleSTest, Start_DeviceVec_SUCCESS)
    {
        MOCKER(BindCpuUtils::BindAicpu)
                .stubs()
                .will(returnValue(BQS_STATUS_OK));
        MOCKER(&QueueScheduleInterface::GetAicpuPhysIndex).stubs().will(returnValue(1));
        MOCKER(&QueueScheduleInterface::GetExtraAicpuPhysIndex).stubs().will(returnValue(1));
        MOCKER(HcclSetGrpIdCallback).stubs().will(returnValue(HCCL_SUCCESS));
        queueSchedule.initQsParams_.numaFlag = true;
        queueSchedule.initQsParams_.devIdVec = {1,2};
        int32_t ret = queueSchedule.StartQueueSchedule();
        EXPECT_EQ(ret, BQS_STATUS_OK);

        QueueScheduleDestroy(queueSchedule);
        queueSchedule.initQsParams_.numaFlag = false;
        GlobalCfg::GetInstance().SetNumaFlag(false);
        GlobalCfg::GetInstance().deviceIdToResIndex_.clear();
    }

    static void ScheduleDataBuffAllStub(QueueSchedule* qs, bool dataEnqueue)
    {
        qs->running_ = false;
    };

    TEST_F(QueueScheduleSTest, EnqueueEvent_FAILED01)
    {
        struct event_info event = {};
        event.comm.event_id = EVENT_QUEUE_ENQUEUE;
        uint64_t falseAwakenTimes = bqs::StatisticManager::GetInstance().totalStat_.enqueueFalseAwakenTimes;
        queueSchedule.queueEventAtomicFlag_.test_and_set();
        queueSchedule.ProcessEnqueueEvent(0, event);
        EXPECT_EQ(falseAwakenTimes + 1, bqs::StatisticManager::GetInstance().totalStat_.enqueueFalseAwakenTimes);
        queueSchedule.queueEventAtomicFlag_.clear();
    }

    TEST_F(QueueScheduleSTest, EnqueueEvent_Success)
    {
        MOCKER(halQueueDeQueue).stubs().will(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
        uint64_t scheduleTime = bqs::StatisticManager::GetInstance().totalStat_.eventScheduleTimes;
        struct event_info event = {};
        event.comm.event_id = EVENT_QUEUE_ENQUEUE;
        queueSchedule.ProcessEnqueueEvent(0, event);
        EXPECT_EQ(scheduleTime + 1, bqs::StatisticManager::GetInstance().totalStat_.eventScheduleTimes);
    }

    TEST_F(QueueScheduleSTest, ScheduleDataBuffAll_success)
    {
        auto &bindRelation = BindRelation::GetInstance();
        auto srcEntity = EntityInfo(2U, 0U);
        auto dstEntity = EntityInfo(3U, 0U);
        bindRelation.Bind(srcEntity, dstEntity);
        bindRelation.Order();

        bool dataEnqueue = true;
        int32_t mbuf = 1;
        int32_t *pmbuf = &mbuf;
        MOCKER(halQueueDeQueue)
            .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP((void **)&pmbuf))
            .will(returnValue((int)DRV_ERROR_NONE))
            .then(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
        queueSchedule.ScheduleDataBuffAll(dataEnqueue);
        EXPECT_TRUE(ProfileManager::GetInstance(0U).enqueEventTrack_.srcQueueNum > 0);
    }

    TEST_F(QueueScheduleSTest, ScheduleDataBuffAll_Q2T_success)
    {
        auto &bindRelation = BindRelation::GetInstance();
        EntityInfo src(20U, 0U);
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo dest(30U, 0U, &args);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dest));
        bindRelation.Order();

        bool dataEnqueue = true;
        int32_t mbuf = 1;
        int32_t *pmbuf = &mbuf;
        MOCKER(halQueueDeQueue)
            .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP((void **)&pmbuf))
            .will(returnValue((int)DRV_ERROR_NONE))
            .then(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
        MOCKER(halMbufFree)
                .stubs()
                .will(returnValue(0));
        queueSchedule.ScheduleDataBuffAll(dataEnqueue);

        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dest));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, ChangeErrorState_success)
    {
        auto &bindRelation = BindRelation::GetInstance();
        EntityInfo src(21U, 0U);
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo dest(31U, 0U, &args);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dest));
        bindRelation.Order();

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 21,
            dgw::EntityDirection::DIRECTION_SEND);
        EXPECT_EQ(true, entity != nullptr);
        EXPECT_EQ(dgw::FsmStatus::FSM_ERROR, entity->ChangeState(dgw::FsmState::FSM_ERROR_STATE));
        dgw::InnerMessage msg;
        msg.msgType = dgw::InnerMsgType::INNER_MSG_F2NF;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ProcessMessage(msg));
        msg.msgType = dgw::InnerMsgType::INNER_MSG_RECOVER;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ProcessMessage(msg));

        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dest));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, ChangeErrorState01_success)
    {
        auto &bindRelation = BindRelation::GetInstance();
        EntityInfo src(21U, 0U);
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo dest(31U, 0U, &args);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dest));
        bindRelation.Order();

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 21,
            dgw::EntityDirection::DIRECTION_SEND);
        EXPECT_EQ(true, entity != nullptr);
        Mbuf *mbuf = 1;
        auto dataObj = dgw::DataObjManager::Instance().CreateDataObj(entity.get(), mbuf);
        entity->AddDataObjToRecvList(dataObj);
        EXPECT_EQ(dgw::FsmStatus::FSM_ERROR, entity->ChangeState(dgw::FsmState::FSM_ERROR_STATE));
        dgw::InnerMessage msg;
        msg.msgType = dgw::InnerMsgType::INNER_MSG_PUSH;
        EXPECT_EQ(dgw::FsmStatus::FSM_ERROR, entity->ProcessMessage(msg));

        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dest));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, ChangeFullState_success)
    {
        auto &bindRelation = BindRelation::GetInstance();
        EntityInfo src(22U, 0U);
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo dest(32U, 0U, &args);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dest));
        bindRelation.Order();

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 22,
            dgw::EntityDirection::DIRECTION_SEND);
        EXPECT_EQ(true, entity != nullptr);
        auto recvEntity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, 32,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_EQ(true, recvEntity != nullptr);
        auto dataObj = dgw::DataObjManager::Instance().CreateDataObj(entity.get(), nullptr);
        entity->AddDataObjToRecvList(dataObj);

        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ChangeState(dgw::FsmState::FSM_FULL_STATE));
        dgw::InnerMessage msg;
        msg.msgType = dgw::InnerMsgType::INNER_MSG_RECOVER;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ProcessMessage(msg));

        msg.msgType = dgw::InnerMsgType::INNER_MSG_PUSH;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ProcessMessage(msg));

        msg.msgType = dgw::InnerMsgType::INNER_MSG_F2NF;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ProcessMessage(msg));

        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dest));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, ChangeIdleState_success)
    {
        auto &bindRelation = BindRelation::GetInstance();
        EntityInfo src(23U, 0U);
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo dest(33U, 0U, &args);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dest));
        bindRelation.Order();

        int status = QUEUE_EMPTY;
        MOCKER(halQueueGetStatus)
                .stubs()
                .will(returnValue((int)DRV_ERROR_NONE));

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 23,
            dgw::EntityDirection::DIRECTION_SEND);
        EXPECT_EQ(true, entity != nullptr);
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ChangeState(dgw::FsmState::FSM_IDLE_STATE));
        dgw::InnerMessage msg;
        msg.msgType = dgw::InnerMsgType::INNER_MSG_PUSH;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ProcessMessage(msg));

        entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, 33,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_EQ(true, entity != nullptr);
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ChangeState(dgw::FsmState::FSM_IDLE_STATE));
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ProcessMessage(msg));

        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dest));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, ChangePeekState_Q2T_success)
    {
        auto &bindRelation = BindRelation::GetInstance();
        EntityInfo src(24U, 0U);
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo dest(34U, 0U, &args);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dest));
        bindRelation.Order();
        void *mbuf = nullptr;
        MOCKER(halQueueDeQueue)
                    .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP((void **)&mbuf))
                    .will(returnValue((int)DRV_ERROR_NONE))
                    .then(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
        uint64_t count = 0;
        void *headBuf = nullptr;
        HcclDataType dataType;

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 24,
            dgw::EntityDirection::DIRECTION_SEND);
        EXPECT_EQ(true, entity != nullptr);
        auto recvEntity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, 34,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_EQ(true, recvEntity != nullptr);
        auto dataObj = dgw::DataObjManager::Instance().CreateDataObj(entity.get(), nullptr);

        //send list not empty
        entity->AddDataObjToSendList(dataObj);
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ChangeState(dgw::FsmState::FSM_PEEK_STATE));
        EXPECT_EQ(entity->GetCurState(), dgw::FsmState::FSM_PEEK_STATE);

        dgw::InnerMessage msg;
        msg.msgType = dgw::InnerMsgType::INNER_MSG_PUSH;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ProcessMessage(msg));

        //send list empty
        entity->RemoveDataObjFromSendList(dataObj);
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ChangeState(dgw::FsmState::FSM_PEEK_STATE));
        EXPECT_EQ(entity->GetCurState(), dgw::FsmState::FSM_IDLE_STATE);
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ProcessMessage(msg));

        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dest));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, Change_PeekState_T2Q_success)
    {
        auto &bindRelation = BindRelation::GetInstance();
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo src(25U, 0U, &args);
        EntityInfo dest(35U, 0U);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dest));
        bindRelation.Order();
        int32_t mbufValue = 1;
        int32_t *mbuf = &mbufValue;
        MOCKER(halQueueDeQueue)
                    .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP((void **)&mbuf))
                    .will(returnValue((int)DRV_ERROR_NONE))
                    .then(returnValue((int)DRV_ERROR_QUEUE_EMPTY));

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, 25,
            dgw::EntityDirection::DIRECTION_SEND);
        EXPECT_EQ(true, entity != nullptr);
        auto recvEntity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 35,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_EQ(true, recvEntity != nullptr);
        auto dataObj = dgw::DataObjManager::Instance().CreateDataObj(entity.get(), nullptr);

        //send list not empty
        entity->AddDataObjToSendList(dataObj);
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ChangeState(dgw::FsmState::FSM_PEEK_STATE));
        EXPECT_EQ(entity->GetCurState(), dgw::FsmState::FSM_PEEK_STATE);

        dgw::InnerMessage msg;
        msg.msgType = dgw::InnerMsgType::INNER_MSG_PUSH;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ProcessMessage(msg));

        //send list empty
        entity->RemoveDataObjFromSendList(dataObj);
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ChangeState(dgw::FsmState::FSM_PEEK_STATE));
        EXPECT_EQ(entity->GetCurState(), dgw::FsmState::FSM_IDLE_STATE);
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ProcessMessage(msg));

        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dest));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, ChangeTryPush_success)
    {
        auto &bindRelation = BindRelation::GetInstance();
        EntityInfo src(26U, 0U);
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo dest(36U, 0U, &args);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dest));
        bindRelation.Order();

        int32_t mbufValue = 1;
        int32_t *mbuf = &mbufValue;

        MOCKER(halMbufGetBuffAddr)
            .stubs().with(mockcpp::any(),  outBoundP((void **)&mbuf))
            .will(returnValue((int)DRV_ERROR_NONE));

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 26,
            dgw::EntityDirection::DIRECTION_SEND);
        EXPECT_EQ(true, entity != nullptr);
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ChangeState(dgw::FsmState::FSM_TRY_PUSH_STATE));

        dgw::InnerMessage msg;
        msg.msgType = dgw::InnerMsgType::INNER_MSG_PUSH;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ProcessMessage(msg));

        g_hcclIsendRet = HCCL_E_AGAIN;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ChangeState(dgw::FsmState::FSM_TRY_PUSH_STATE));
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ProcessMessage(msg));

        ClearEntity(dest);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dest));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, ChangePush_success)
    {
        auto &bindRelation = BindRelation::GetInstance();
        EntityInfo src(26U, 0U);
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo dest(36U, 0U, &args);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dest));
        bindRelation.Order();

        int32_t mbufValue = 1;
        int32_t *mbuf = &mbufValue;

        MOCKER(halMbufGetBuffAddr)
            .stubs().with(mockcpp::any(),  outBoundP((void **)&mbuf))
            .will(returnValue((int)DRV_ERROR_NONE));

        MOCKER(halQueueEnQueue)
            .stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any())
            .will(returnValue((int)DRV_ERROR_QUEUE_FULL));

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 26,
            dgw::EntityDirection::DIRECTION_SEND);
        EXPECT_EQ(true, entity != nullptr);

        auto recvEntity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, 36,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_EQ(true, recvEntity != nullptr);
        auto dataObj = dgw::DataObjManager::Instance().CreateDataObj(entity.get(), nullptr);

        recvEntity->AddDataObjToRecvList(dataObj);
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ChangeState(dgw::FsmState::FSM_TRY_PUSH_STATE));

        dgw::InnerMessage msg;
        msg.msgType = dgw::InnerMsgType::INNER_MSG_PUSH;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, recvEntity->ProcessMessage(msg));

        ClearEntity(dest);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dest));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, ChangePush_AcrossNuma_success)
    {
        GlobalCfg::GetInstance().SetNumaFlag(true);
        Subscribers::GetInstance().InitSubscribeManagers(std::set<uint32_t>{1U}, 0U);

        auto &bindRelation = BindRelation::GetInstance();
        EntityInfo src(26U, 0U);
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo dest(36U, 1U, &args);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dest));
        bindRelation.Order();

        int32_t mbufValue = 1;
        int32_t *mbuf = &mbufValue;

        MOCKER(halMbufGetBuffAddr)
            .stubs().with(mockcpp::any(), outBoundP((void **)&mbuf))
            .will(returnValue((int)DRV_ERROR_NONE));

        uint32_t headSize = 1LU;
        MOCKER(halMbufGetPrivInfo)
            .stubs().with(mockcpp::any(), outBoundP((void **)&mbuf), outBoundP(&headSize))
            .will(returnValue((int)DRV_ERROR_NONE));
        MOCKER(halQueueEnQueue)
            .stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any())
            .will(returnValue((int)DRV_ERROR_QUEUE_FULL));
        MOCKER(halMbufAllocEx)
            .stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP((Mbuf **)&mbuf))
            .will(returnValue((int)DRV_ERROR_NONE));

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 26,
            dgw::EntityDirection::DIRECTION_SEND);
        EXPECT_EQ(true, entity != nullptr);

        auto recvEntity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 1, dgw::EntityType::ENTITY_TAG, 36,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_EQ(true, recvEntity != nullptr);
        auto dataObj = dgw::DataObjManager::Instance().CreateDataObj(entity.get(), nullptr);

        recvEntity->AddDataObjToRecvList(dataObj);
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ChangeState(dgw::FsmState::FSM_TRY_PUSH_STATE));
        dgw::InnerMessage msg;
        msg.msgType = dgw::InnerMsgType::INNER_MSG_PUSH;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, recvEntity->ProcessMessage(msg));

        ClearEntity(dest);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dest));
        bindRelation.Order();

        GlobalCfg::GetInstance().SetNumaFlag(false);
        GlobalCfg::GetInstance().deviceIdToResIndex_.clear();
    }

    TEST_F(QueueScheduleSTest, ChangeWaitPush_success)
    {
        auto &bindRelation = BindRelation::GetInstance();
        EntityInfo src(27U, 0U);
        EntityInfo dest(37U, 0U);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dest));
        bindRelation.Order();

        auto recvEntity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 37,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_EQ(true, recvEntity != nullptr);
        dgw::InnerMessage msg;
        msg.msgType = dgw::InnerMsgType::INNER_MSG_PUSH;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, recvEntity->ProcessMessage(msg));

        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dest));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, ChangeIdle2Error)
    {
        MOCKER(halQueueGetStatus)
            .stubs()
            .will(returnValue(DRV_ERROR_NOT_EXIST));

        auto &bindRelation = BindRelation::GetInstance();
        EntityInfo src(27U, 0U);
        EntityInfo dest(37U, 0U);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dest));
        bindRelation.Order();

        auto recvEntity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 37,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_EQ(true, recvEntity != nullptr);

        dgw::InnerMessage msg;
        msg.msgType = dgw::InnerMsgType::INNER_MSG_PUSH;
        EXPECT_EQ(dgw::FsmStatus::FSM_ERROR, src.GetEntity()->ProcessMessage(msg));
        EXPECT_EQ(src.GetEntity()->GetCurState(), dgw::FsmState::FSM_ERROR_STATE);
        bindRelation.UpdateRelation(0U);

        const auto &src2Dest = bindRelation.GetSrcToDstRelation();
        EXPECT_TRUE(src2Dest.find(src) == src2Dest.end());
        EXPECT_TRUE(dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, 
            dgw::EntityType::ENTITY_QUEUE, 37, dgw::EntityDirection::DIRECTION_RECV) == nullptr);

        const auto &abnormalSrc2Dest = bindRelation.GetAbnormalSrcToDstRelation();
        const auto &abnormalIter = abnormalSrc2Dest.find(src);
        ASSERT_TRUE(abnormalIter != abnormalSrc2Dest.end());
        EXPECT_TRUE(abnormalIter->second.count(dest) != 0);

        ClearEntity(dest);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dest));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, ChangePeek2Error)
    {
        MOCKER(halQueueDeQueue)
            .stubs()
            .will(returnValue(DRV_ERROR_NOT_EXIST));

        auto &bindRelation = BindRelation::GetInstance();
        EntityInfo src(27U, 0U);
        EntityInfo dest(37U, 0U);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dest));
        bindRelation.Order();

        auto recvEntity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 37,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_EQ(true, recvEntity != nullptr);

        dgw::InnerMessage msg;
        msg.msgType = dgw::InnerMsgType::INNER_MSG_PUSH;
        EXPECT_EQ(dgw::FsmStatus::FSM_ERROR, src.GetEntity()->ChangeState(dgw::FsmState::FSM_PEEK_STATE));
        EXPECT_EQ(src.GetEntity()->GetCurState(), dgw::FsmState::FSM_ERROR_STATE);
        bindRelation.UpdateRelation(0U);

        const auto &src2Dest = bindRelation.GetSrcToDstRelation();
        EXPECT_TRUE(src2Dest.find(src) == src2Dest.end());
        EXPECT_TRUE(dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, 
            dgw::EntityType::ENTITY_QUEUE, 37, dgw::EntityDirection::DIRECTION_RECV) == nullptr);

        const auto &abnormalSrc2Dest = bindRelation.GetAbnormalSrcToDstRelation();
        const auto &abnormalIter = abnormalSrc2Dest.find(src);
        ASSERT_TRUE(abnormalIter != abnormalSrc2Dest.end());
        EXPECT_TRUE(abnormalIter->second.count(dest) != 0);

        ClearEntity(dest);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dest));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, ChangePeek2ErrorForGroup)
    {
        MOCKER(halQueueDeQueue)
            .stubs()
            .will(returnValue(DRV_ERROR_NOT_EXIST));

        auto &bindRelation = BindRelation::GetInstance();
        uint32_t groupId;
        std::vector<EntityInfoPtr> entities;
        EntityInfoPtr entity1 = std::make_shared<EntityInfo>(1001U, 0U);
        EntityInfoPtr entity2 = std::make_shared<EntityInfo>(1002U, 0U);
        entities.emplace_back(entity1);
        entities.emplace_back(entity2);
        bindRelation.CreateGroup(entities, groupId);
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_GROUP;
        EntityInfo src(groupId, 0U, &args);

        EntityInfo dest(37U, 0U);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dest));
        bindRelation.Order();

        auto recvEntity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 37,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_EQ(true, recvEntity != nullptr);

        EXPECT_EQ(dgw::FsmStatus::FSM_ERROR, src.GetEntity()->ChangeState(dgw::FsmState::FSM_PEEK_STATE));
        EXPECT_EQ(src.GetEntity()->GetCurState(), dgw::FsmState::FSM_ERROR_STATE);
        bindRelation.UpdateRelation(0U);

        const auto &src2Dest = bindRelation.GetSrcToDstRelation();
        EXPECT_TRUE(src2Dest.find(src) == src2Dest.end());
        EXPECT_TRUE(dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, 
            dgw::EntityType::ENTITY_QUEUE, 37, dgw::EntityDirection::DIRECTION_RECV) == nullptr);

        const auto &abnormalSrc2Dest = bindRelation.GetAbnormalSrcToDstRelation();
        const auto &abnormalIter = abnormalSrc2Dest.find(src);
        ASSERT_TRUE(abnormalIter != abnormalSrc2Dest.end());
        EXPECT_TRUE(abnormalIter->second.count(dest) != 0);

        ClearEntity(dest);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dest));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, ChangePush2Error)
    {
        MOCKER(halQueueEnQueue)
            .stubs()
            .will(returnValue(DRV_ERROR_NOT_EXIST));
        MOCKER(halMbufCopyRef)
            .stubs()
            .will(invoke(halMbufCopyRefFake));

        auto &bindRelation = BindRelation::GetInstance();
        EntityInfo src(27U, 0U);
        EntityInfo dest(37U, 0U);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dest));
        bindRelation.Order();

        auto recvEntity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 37,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_EQ(true, recvEntity != nullptr);

        Mbuf *mbuf = 1;
        auto dataObj = dgw::DataObjManager::Instance().CreateDataObj(src.GetEntity().get(), mbuf);

        recvEntity->AddDataObjToRecvList(dataObj);
        dgw::InnerMessage msg;
        msg.msgType = dgw::InnerMsgType::INNER_MSG_PUSH;
        EXPECT_EQ(dgw::FsmStatus::FSM_ERROR, dest.GetEntity()->ChangeState(dgw::FsmState::FSM_PUSH_STATE));
        EXPECT_EQ(dest.GetEntity()->GetCurState(), dgw::FsmState::FSM_ERROR_STATE);
        bindRelation.UpdateRelation(0U);

        const auto &src2Dest = bindRelation.GetSrcToDstRelation();
        EXPECT_TRUE(src2Dest.find(src) == src2Dest.end());
        EXPECT_TRUE(dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, 
            dgw::EntityType::ENTITY_QUEUE, 37, dgw::EntityDirection::DIRECTION_RECV) == nullptr);

        const auto &abnormalSrc2Dest = bindRelation.GetAbnormalSrcToDstRelation();
        const auto &abnormalIter = abnormalSrc2Dest.find(src);
        ASSERT_TRUE(abnormalIter != abnormalSrc2Dest.end());
        EXPECT_TRUE(abnormalIter->second.count(dest) != 0);

        ClearEntity(dest);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dest));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, ChangeTryPush2ErrorForGroup)
    {
        MOCKER(halQueueEnQueue)
            .stubs()
            .will(returnValue(DRV_ERROR_NOT_EXIST));

        EntityInfo src(27U, 0U);
        auto &bindRelation = BindRelation::GetInstance();
        uint32_t groupId;
        std::vector<EntityInfoPtr> entities;
        EntityInfoPtr entity1 = std::make_shared<EntityInfo>(1001U, 0U);
        EntityInfoPtr entity2 = std::make_shared<EntityInfo>(1002U, 0U);
        entities.emplace_back(entity1);
        entities.emplace_back(entity2);
        bindRelation.CreateGroup(entities, groupId);
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_GROUP;
        EntityInfo dest(groupId, 0U, &args);

        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dest));
        bindRelation.Order();

        auto entity1ForSchedule = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 1001,
            dgw::EntityDirection::DIRECTION_RECV);
        entity1ForSchedule->ChangeState(dgw::FsmState::FSM_ERROR_STATE);
        src.GetEntity()->SetTransId(2U);
        src.GetEntity()->SetRouteLabel(0U);
        EXPECT_EQ(dgw::FsmStatus::FSM_ERROR, src.GetEntity()->ChangeState(dgw::FsmState::FSM_TRY_PUSH_STATE));
        EXPECT_EQ(dest.GetEntity()->GetCurState(), dgw::FsmState::FSM_ERROR_STATE);
        bindRelation.UpdateRelation(0U);

        const auto &src2Dest = bindRelation.GetSrcToDstRelation();
        EXPECT_TRUE(src2Dest.find(src) == src2Dest.end());
        EXPECT_TRUE(dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, 
            dgw::EntityType::ENTITY_QUEUE, 27, dgw::EntityDirection::DIRECTION_SEND) == nullptr);

        const auto &abnormalSrc2Dest = bindRelation.GetAbnormalSrcToDstRelation();
        const auto &abnormalIter = abnormalSrc2Dest.find(src);
        ASSERT_TRUE(abnormalIter != abnormalSrc2Dest.end());
        EXPECT_TRUE(abnormalIter->second.count(dest) != 0);

        ClearEntity(dest);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dest));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, ProcessEvent_success)
    {
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
        uint32_t uniqueTagId = 100U;
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo src(uniqueTagId, 0U, &args);
        uint32_t queueId = 1001;
        EntityInfo dst(queueId, 0U);
        auto &bindRelation = BindRelation::GetInstance();
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dst));
        bindRelation.Order();

        MOCKER(halQueueDeQueue).stubs().will(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
        // process queue f2nf event
        event_info event;
        event.comm.event_id = EVENT_QUEUE_FULL_TO_NOT_FULL;
        event.comm.subevent_id = queueId;
        queueSchedule.queueEventAtomicFlag_.test_and_set();
        auto ret = queueSchedule.ProcessEvent(0U, event, 0U);
        EXPECT_EQ(ret, bqs::BqsStatus::BQS_STATUS_OK);
        queueSchedule.queueEventAtomicFlag_.clear();

        // process hccl congestion relief msg
        event.comm.event_id = dgw::EVENT_CONGESTION_RELIEF_MSG;
        ret = queueSchedule.ProcessEvent(0U, event, 0U);
        EXPECT_EQ(ret, bqs::BqsStatus::BQS_STATUS_OK);

        // process unsupported msg
        event.comm.event_id = 1;
        ret = queueSchedule.ProcessEvent(0U, event, 0U);
        EXPECT_EQ(ret, bqs::BqsStatus::BQS_STATUS_INNER_ERROR);

        // unbind
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dst));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, HcclProcess_ProcessRecvRequest_success)
    {
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
        uint32_t uniqueTagId = 100U;
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo src(uniqueTagId, 0U, &args);
        uint32_t queueId = 1001;
        EntityInfo dst(queueId, 0U);
        auto &bindRelation = BindRelation::GetInstance();
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dst));
        bindRelation.Order();

        int32_t temp = 1;
        int32_t *tempPtr = &temp;
        MOCKER(halMbufAlloc)
            .stubs().with(mockcpp::any(), outBoundP((Mbuf **)&tempPtr))
            .will(returnValue((int)DRV_ERROR_NONE));
        MOCKER(halMbufGetBuffAddr)
            .stubs().with(mockcpp::any(), outBoundP((void **)&tempPtr))
            .will(returnValue((int)DRV_ERROR_NONE));

        uint32_t headBufSize = 256U;
        char headBuf[256];
        void *headBufAddr = (void *)(&headBuf[0]);
        MOCKER(halMbufGetPrivInfo)
            .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
            .will(returnValue((int)DRV_ERROR_NONE));

        // hccl recv request: 4 envelope, process 2, cache 2
        g_totalEnvelopeCount = 4U;
        g_link = true;
        event_info event;
        event.comm.event_id = dgw::EVENT_RECV_REQUEST_MSG;
        auto ret = queueSchedule.ProcessEvent(0U, event, 0U);
        EXPECT_EQ(ret, bqs::BqsStatus::BQS_STATUS_OK);

        dgw::EntityPtr entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
            dgw::EntityDirection::DIRECTION_SEND);
        EXPECT_NE(entity, nullptr);
        dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity.get());
        EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 2U);
        EXPECT_EQ(channelEntity->cachedEnvelopeQueue_.Size(), 2U);
        EXPECT_EQ(channelEntity->cachedReqCount_, 2U);

        // hccl recv completion
        event.comm.event_id = dgw::EVENT_RECV_COMPLETION_MSG;
        ret = queueSchedule.ProcessEvent(0U, event, 0U);
        EXPECT_EQ(ret, bqs::BqsStatus::BQS_STATUS_OK);
        EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 0U);

        // clear cachedReqCount, then process cached envelope
        channelEntity->cachedReqCount_ = 0U;
        event.comm.event_id = dgw::EVENT_RECV_REQUEST_MSG;
        ret = queueSchedule.ProcessEvent(0U, event, 0U);
        EXPECT_EQ(ret, bqs::BqsStatus::BQS_STATUS_OK);
        EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 2U);
        EXPECT_EQ(channelEntity->cachedEnvelopeQueue_.Size(), 0U);
        EXPECT_EQ(channelEntity->cachedReqCount_, 2U);

        // unbind
        ClearEntity(src);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dst));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, HcclProcess_ProcessOneTrackEvent_success)
    {
        auto &hcclProcessInstance = dgw::HcclProcess::GetInstance();
        hcclProcessInstance.inited_ = false;
        hcclProcessInstance.Init();
        hcclProcessInstance.oneTrackEventEnabled_ = true;

        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 1U, 1U);
        uint32_t uniqueTagId = 100U;
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo src(uniqueTagId, 0U, &args);
        uint32_t queueId = 1001;
        EntityInfo dst(queueId, 0U);
        auto &bindRelation = BindRelation::GetInstance();
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dst));
        bindRelation.Order();

        int32_t temp = 1;
        int32_t *tempPtr = &temp;
        MOCKER(halMbufAlloc)
            .stubs().with(mockcpp::any(), outBoundP((Mbuf **)&tempPtr))
            .will(returnValue((int)DRV_ERROR_NONE));
        MOCKER(halMbufGetBuffAddr)
            .stubs().with(mockcpp::any(), outBoundP((void **)&tempPtr))
            .will(returnValue((int)DRV_ERROR_NONE));

        uint32_t headBufSize = 256U;
        char headBuf[256];
        void *headBufAddr = (void *)(&headBuf[0]);
        MOCKER(halMbufGetPrivInfo)
            .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
            .will(returnValue((int)DRV_ERROR_NONE));

        // hccl recv request: 4 envelope, process 2, cache 2
        g_totalEnvelopeCount = 4U;
        g_link = true;
        event_info event;;
        event.comm.event_id = dgw::EVENT_RECV_COMPLETION_MSG;
        auto ret = queueSchedule.ProcessEvent(0U, event, 0U);
        EXPECT_EQ(ret, bqs::BqsStatus::BQS_STATUS_OK);

        dgw::EntityPtr entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
            dgw::EntityDirection::DIRECTION_SEND);
        EXPECT_NE(entity, nullptr);
        dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity.get());
        EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 2U);
        EXPECT_EQ(channelEntity->cachedEnvelopeQueue_.Size(), 2U);
        EXPECT_EQ(channelEntity->cachedReqCount_, 2U);

        // hccl recv completion
        ret = queueSchedule.ProcessEvent(0U, event, 0U);
        EXPECT_EQ(ret, bqs::BqsStatus::BQS_STATUS_OK);
        EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 0U);

        // clear cachedReqCount, then process cached envelope
        channelEntity->cachedReqCount_ = 0U;
        ret = queueSchedule.ProcessEvent(0U, event, 0U);
        EXPECT_EQ(ret, bqs::BqsStatus::BQS_STATUS_OK);
        EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 2U);
        EXPECT_EQ(channelEntity->cachedEnvelopeQueue_.Size(), 0U);
        EXPECT_EQ(channelEntity->cachedReqCount_, 2U);

        event.comm.event_id = dgw::EVENT_RECV_REQUEST_MSG;
        EXPECT_EQ(queueSchedule.ProcessEvent(0U, event, 0U), bqs::BqsStatus::BQS_STATUS_OK);
        event.comm.event_id = dgw::EVENT_SEND_COMPLETION_MSG;
        EXPECT_EQ(queueSchedule.ProcessEvent(0U, event, 0U), bqs::BqsStatus::BQS_STATUS_OK);
        // unbind
        ClearEntity(src);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dst));
        bindRelation.Order();
        hcclProcessInstance.oneTrackEventEnabled_ = false;
    }

    TEST_F(QueueScheduleSTest, HcclProcess_ProcessSendCompleteion_success)
    {
        uint32_t queueId = 1001;
        EntityInfo src(queueId, 0U);
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        uint32_t uniqueTagId = 100U;
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo dst(uniqueTagId, 0U, &args);
        auto &bindRelation = BindRelation::GetInstance();
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dst));
        bindRelation.Order();

        int32_t mbufValue = 1;
        int32_t *mbuf = &mbufValue;
        MOCKER(halMbufGetBuffAddr)
            .stubs().with(mockcpp::any(),  outBoundP((void **)&mbuf))
            .will(returnValue((int)DRV_ERROR_NONE));

        MOCKER_CPP(&dgw::Entity::GetMbuf)
                .stubs()
                .will(returnValue((Mbuf *)mbuf));
        MbufTypeInfo typeInfo = {};
        typeInfo.type = static_cast<uint32_t>(MBUF_CREATE_BY_BUILD);
        MOCKER(halBuffGetInfo)
            .stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP((void*)(&typeInfo), sizeof(typeInfo)), mockcpp::any())
            .will(returnValue(0));

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, queueId,
            dgw::EntityDirection::DIRECTION_SEND);
        EXPECT_EQ(true, entity != nullptr);
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ChangeState(dgw::FsmState::FSM_TRY_PUSH_STATE));

        dgw::EntityPtr entity2 = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_NE(entity2, nullptr);
        dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity2.get());
        // include one request for link establishment
        EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 3U);

        event_info event;
        event.comm.event_id = dgw::EVENT_SEND_COMPLETION_MSG;
        auto ret = queueSchedule.ProcessEvent(0U, event, 0U);
        EXPECT_EQ(ret, bqs::BqsStatus::BQS_STATUS_OK);
        EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 0U);

        ClearEntity(dst);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dst));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, HcclProcess_ProcessSendCompleteion_success_with_halBuffGetInfo_Fail)
    {
        uint32_t queueId = 1001;
        EntityInfo src(queueId, 0U);
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        uint32_t uniqueTagId = 100U;
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo dst(uniqueTagId, 0U, &args);
        auto &bindRelation = BindRelation::GetInstance();
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dst));
        bindRelation.Order();

        int32_t mbufValue = 1;
        int32_t *mbuf = &mbufValue;
        MOCKER(halMbufGetBuffAddr)
            .stubs().with(mockcpp::any(),  outBoundP((void **)&mbuf))
            .will(returnValue((int)DRV_ERROR_NONE));

        MOCKER_CPP(&dgw::Entity::GetMbuf)
                .stubs()
                .will(returnValue((Mbuf *)mbuf));
        MOCKER(halBuffGetInfo)
            .stubs()
            .will(returnValue(1));

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, queueId,
            dgw::EntityDirection::DIRECTION_SEND);
        EXPECT_EQ(true, entity != nullptr);
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ChangeState(dgw::FsmState::FSM_TRY_PUSH_STATE));

        dgw::EntityPtr entity2 = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_NE(entity2, nullptr);
        dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity2.get());
        // include one request for link establishment
        EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 3U);

        event_info event;
        event.comm.event_id = dgw::EVENT_SEND_COMPLETION_MSG;
        auto ret = queueSchedule.ProcessEvent(0U, event, 0U);
        EXPECT_EQ(ret, bqs::BqsStatus::BQS_STATUS_OK);
        EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 0U);

        ClearEntity(dst);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dst));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, HcclProcess_ProcessSendCompleteion_success_with_HcclTestSome_Fail)
    {
        MOCKER(HcclTestSome)
            .stubs()
            .will(invoke(HcclTestSomeFakeFail));
        MOCKER(HcclTestSomeFake)
            .stubs()
            .will(invoke(HcclTestSomeFakeFail));
        uint32_t queueId = 10011;
        EntityInfo src(queueId, 0U);
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        uint32_t uniqueTagId = 100U;
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo dst(uniqueTagId, 0U, &args);
        auto &bindRelation = BindRelation::GetInstance();
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dst));
        bindRelation.Order();

        int32_t mbufValue = 1;
        int32_t *mbuf = &mbufValue;
        MOCKER(halMbufGetBuffAddr)
            .stubs().with(mockcpp::any(),  outBoundP((void **)&mbuf))
            .will(returnValue((int)DRV_ERROR_NONE));

        MOCKER_CPP(&dgw::Entity::GetMbuf)
                .stubs()
                .will(returnValue((Mbuf *)mbuf));
        MOCKER(halBuffGetInfo)
            .stubs()
            .will(returnValue(1));

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, queueId,
            dgw::EntityDirection::DIRECTION_SEND);
        EXPECT_EQ(true, entity != nullptr);
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ChangeState(dgw::FsmState::FSM_TRY_PUSH_STATE));

        dgw::EntityPtr entity2 = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_NE(entity2, nullptr);
        dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity2.get());
        // include one request for link establishment
        EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 3U);

        event_info event;
        event.comm.event_id = dgw::EVENT_SEND_COMPLETION_MSG;
        auto ret = queueSchedule.ProcessEvent(0U, event, 0U);
        EXPECT_EQ(ret, bqs::BqsStatus::BQS_STATUS_OK);
        EXPECT_EQ(channelEntity->uncompReqQueue_.Size(), 3U);

        ClearEntity(dst);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dst));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, ChangeGroupIdleState_success)
    {
        auto &bindRelation = BindRelation::GetInstance();

        uint32_t groupId;
        std::vector<EntityInfoPtr> entities;
        EntityInfoPtr entity1 = std::make_shared<EntityInfo>(1001U, 0U);
        EntityInfoPtr entity2 = std::make_shared<EntityInfo>(1002U, 0U);
        entities.emplace_back(entity1);
        entities.emplace_back(entity2);
        bindRelation.CreateGroup(entities, groupId);

        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_GROUP;
        EntityInfo src(groupId, 0U, &args);
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo dst(2U, 0U, &args);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dst));
        bindRelation.Order();

        int status = QUEUE_EMPTY;
        MOCKER(halQueueGetStatus)
                .stubs().with(mockcpp::any(), mockcpp::any(), mockcpp::any(), mockcpp::any(), outBoundP((void *)&status))
                .will(returnValue((int)DRV_ERROR_NONE));

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_GROUP, groupId,
            dgw::EntityDirection::DIRECTION_SEND);
        EXPECT_EQ(true, entity != nullptr);
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ChangeState(dgw::FsmState::FSM_IDLE_STATE));
        dgw::InnerMessage msg;
        msg.msgType = dgw::InnerMsgType::INNER_MSG_PUSH;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ProcessMessage(msg));

        entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, 2,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_EQ(true, entity != nullptr);
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ChangeState(dgw::FsmState::FSM_IDLE_STATE));
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ProcessMessage(msg));

        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dst));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, ChangePeekState_G2Q_success)
    {
        auto &bindRelation = BindRelation::GetInstance();
        uint32_t groupId;
        std::vector<EntityInfoPtr> entities;
        EntityInfoPtr entity1 = std::make_shared<EntityInfo>(9001U, 0U);
        entities.emplace_back(entity1);
        bindRelation.CreateGroup(entities, groupId);

        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_GROUP;
        EntityInfo src(groupId, 0U, &args);
        EntityInfo dst(9002U, 0U);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dst));
        bindRelation.Order();

        void *mbuf = nullptr;
        MOCKER(halQueueDeQueue)
                    .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP((void **)&mbuf))
                    .will(returnValue((int)DRV_ERROR_NONE))
                    .then(returnValue((int)DRV_ERROR_QUEUE_EMPTY));

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_GROUP, groupId,
            dgw::EntityDirection::DIRECTION_SEND);
        EXPECT_EQ(true, entity != nullptr);
        entity->SetNeedTransId(true);
        auto recvEntity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 9002,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_EQ(true, recvEntity != nullptr);
        auto dataObj = dgw::DataObjManager::Instance().CreateDataObj(entity.get(), nullptr);

        //send list not empty
        entity->AddDataObjToSendList(dataObj);
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ChangeState(dgw::FsmState::FSM_PEEK_STATE));
        EXPECT_EQ(entity->GetCurState(), dgw::FsmState::FSM_PEEK_STATE);

        dgw::InnerMessage msg;
        msg.msgType = dgw::InnerMsgType::INNER_MSG_PUSH;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ProcessMessage(msg));

        //send list empty
        entity->RemoveDataObjFromSendList(dataObj);
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ChangeState(dgw::FsmState::FSM_PEEK_STATE));
        EXPECT_EQ(entity->GetCurState(), dgw::FsmState::FSM_IDLE_STATE);
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ProcessMessage(msg));
    }

    TEST_F(QueueScheduleSTest, ChangePeekState_G2Q_success02)
    {
        auto &bindRelation = BindRelation::GetInstance();
        uint32_t groupId;
        std::vector<EntityInfoPtr> entities;
        EntityInfoPtr entity1 = std::make_shared<EntityInfo>(7001U, 0U);
        entities.emplace_back(entity1);
        bindRelation.CreateGroup(entities, groupId);

        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_GROUP;
        EntityInfo src(groupId, 0U, &args);
        EntityInfo dst(7002U, 0U);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dst));
        bindRelation.Order();

        int32_t temp = 5;
        void *mbuf = (void *)(&temp);
        MOCKER(halQueueDeQueue)
                    .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP((void **)&mbuf))
                    .will(returnValue((int)DRV_ERROR_NONE));

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_GROUP, groupId,
            dgw::EntityDirection::DIRECTION_SEND);
        EXPECT_EQ(true, entity != nullptr);
        entity->SetNeedTransId(true);

        dgw::InnerMessage msg;
        msg.msgType = dgw::InnerMsgType::INNER_MSG_PUSH;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ProcessMessage(msg));
    }

    TEST_F(QueueScheduleSTest, ChangePeekState_G2Q_success03)
    {
        auto &bindRelation = BindRelation::GetInstance();
        uint32_t groupId;
        std::vector<EntityInfoPtr> entities;
        EntityInfoPtr entity1 = std::make_shared<EntityInfo>(6001U, 0U);
        entities.emplace_back(entity1);
        bindRelation.CreateGroup(entities, groupId);

        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_GROUP;
        EntityInfo src(groupId, 0U, &args);
        EntityInfo dst(6002U, 0U);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dst));
        bindRelation.Order();

        int32_t temp = 5;
        void *mbuf = (void *)(&temp);
        MOCKER(halQueueDeQueue)
            .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP((void **)&mbuf))
            .will(returnValue((int)DRV_ERROR_NONE))
            .then(returnValue((int)DRV_ERROR_QUEUE_EMPTY));

        uint32_t headBufSize = 256U;
        char headBuf[256];
        bqs::IdentifyInfo *info = (bqs::IdentifyInfo *)(headBuf + 256 - sizeof(bqs::IdentifyInfo));
        info->transId = 1;
        info->routeLabel = 1U;
        void *headBufAddr = (void *)(&headBuf[0]);
        MOCKER(halMbufGetPrivInfo)
            .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
            .will(returnValue((int)DRV_ERROR_NONE));
        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_GROUP, groupId,
            dgw::EntityDirection::DIRECTION_SEND);
        EXPECT_EQ(true, entity != nullptr);
        entity->SetNeedTransId(true);

        dgw::InnerMessage msg;
        msg.msgType = dgw::InnerMsgType::INNER_MSG_PUSH;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ProcessMessage(msg));
    }

    TEST_F(QueueScheduleSTest, ChangePeekState_G2Q_success04)
    {     
        auto &bindRelation = BindRelation::GetInstance();
        uint32_t groupId;
        std::vector<EntityInfoPtr> entities;
        EntityInfoPtr entity1 = std::make_shared<EntityInfo>(5001U, 0U);
        entities.emplace_back(entity1);
        bindRelation.CreateGroup(entities, groupId);

        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_GROUP;
        EntityInfo src(groupId, 0U, &args);
        EntityInfo dst(5002U, 0U);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dst));
        bindRelation.Order();

        int32_t temp = 5;
        void *mbuf = (void *)(&temp);
        MOCKER(halQueueDeQueue)
            .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP((void **)&mbuf))
            .will(returnValue((int)DRV_ERROR_NONE))
            .then(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
        MOCKER(halQueueGetStatus)
            .stubs()
            .will(returnValue(77)).then(returnValue((int)DRV_ERROR_NONE));
        uint32_t headBufSize = 256U;
        char headBuf[256];
        bqs::IdentifyInfo *info = (bqs::IdentifyInfo *)(headBuf + 256 - sizeof(bqs::IdentifyInfo));
        info->transId = 1;
        void *headBufAddr = (void *)(&headBuf[0]);
        MOCKER(halMbufGetPrivInfo)
            .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
            .will(returnValue((int)DRV_ERROR_NONE));

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_GROUP, groupId,
            dgw::EntityDirection::DIRECTION_SEND);
        EXPECT_EQ(true, entity != nullptr);
        entity->SetNeedTransId(true);

        dgw::InnerMessage msg;
        msg.msgType = dgw::InnerMsgType::INNER_MSG_PUSH;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ProcessMessage(msg));
    }

    TEST_F(QueueScheduleSTest, ChangeTryPush_success02)
    {
        auto &bindRelation = BindRelation::GetInstance();

        uint32_t groupId;
        std::vector<EntityInfoPtr> entities;
        EntityInfoPtr entity1 = std::make_shared<EntityInfo>(101U, 0U);
        EntityInfoPtr entity2 = std::make_shared<EntityInfo>(102U, 0U);
        entities.emplace_back(entity1);
        entities.emplace_back(entity2);
        bindRelation.CreateGroup(entities, groupId);

        EntityInfo src(103U, 0U);
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_GROUP;
        EntityInfo dst(groupId, 0U, &args);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dst));
        bindRelation.Order();

        int32_t mbufValue = 1;
        int32_t *mbuf = &mbufValue;

        MOCKER(halMbufGetBuffAddr)
            .stubs().with(mockcpp::any(),  outBoundP((void **)&mbuf))
            .will(returnValue((int)DRV_ERROR_NONE));

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 103,
            dgw::EntityDirection::DIRECTION_SEND);
        EXPECT_EQ(true, entity != nullptr);
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ChangeState(dgw::FsmState::FSM_TRY_PUSH_STATE));

        entity->SetTransId(1UL);
        entity->SetRouteLabel(0U);
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ChangeState(dgw::FsmState::FSM_TRY_PUSH_STATE));

        dgw::InnerMessage msg;
        msg.msgType = dgw::InnerMsgType::INNER_MSG_PUSH;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ProcessMessage(msg));
    }

    TEST_F(QueueScheduleSTest, ChangeTryPush_success03)
    {
        auto &bindRelation = BindRelation::GetInstance();

        uint32_t groupId;
        std::vector<EntityInfoPtr> entities;
        EntityInfoPtr entity1 = std::make_shared<EntityInfo>(201U, 0U);
        EntityInfoPtr entity2 = std::make_shared<EntityInfo>(202U, 0U);
        entities.emplace_back(entity1);
        entities.emplace_back(entity2);
        bindRelation.CreateGroup(entities, groupId);

        EntityInfo src(203U, 0U);
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_GROUP;
        args.policy = bqs::GroupPolicy::BROADCAST;
        EntityInfo dst(groupId, 0U, &args);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dst));
        bindRelation.Order();

        int32_t mbufValue = 1;
        int32_t *mbuf = &mbufValue;

        MOCKER(halMbufGetBuffAddr)
            .stubs().with(mockcpp::any(),  outBoundP((void **)&mbuf))
            .will(returnValue((int)DRV_ERROR_NONE));

        auto groupEntity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_GROUP, groupId,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_EQ(true, groupEntity != nullptr);

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 203,
            dgw::EntityDirection::DIRECTION_SEND);
        EXPECT_EQ(true, entity != nullptr);
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ChangeState(dgw::FsmState::FSM_TRY_PUSH_STATE));

        dgw::InnerMessage msg;
        msg.msgType = dgw::InnerMsgType::INNER_MSG_PUSH;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, entity->ProcessMessage(msg));
    }

    TEST_F(QueueScheduleSTest, ChangeFullState_success02)
    {
        auto &bindRelation = BindRelation::GetInstance();

        uint32_t groupId;
        std::vector<EntityInfoPtr> entities;
        EntityInfoPtr entity1 = std::make_shared<EntityInfo>(301U, 0U);
        EntityInfoPtr entity2 = std::make_shared<EntityInfo>(302U, 0U);
        entities.emplace_back(entity1);
        entities.emplace_back(entity2);
        bindRelation.CreateGroup(entities, groupId);

        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_GROUP;
        EntityInfo src(groupId, 0U, &args);
        EntityInfo dst(303U, 0U);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dst));
        bindRelation.Order();

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_GROUP, groupId,
            dgw::EntityDirection::DIRECTION_SEND);
        EXPECT_EQ(true, entity != nullptr);
        auto recvEntity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 303,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_EQ(true, recvEntity != nullptr);
        auto dataObj = dgw::DataObjManager::Instance().CreateDataObj(entity.get(), nullptr);
        recvEntity->AddDataObjToRecvList(dataObj);

        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, recvEntity->ChangeState(dgw::FsmState::FSM_FULL_STATE));
        dgw::InnerMessage msg;
        msg.msgType = dgw::InnerMsgType::INNER_MSG_RECOVER;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, recvEntity->ProcessMessage(msg));

        msg.msgType = dgw::InnerMsgType::INNER_MSG_PUSH;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, recvEntity->ProcessMessage(msg));

        msg.msgType = dgw::InnerMsgType::INNER_MSG_F2NF;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, recvEntity->ProcessMessage(msg));
    }
 
    TEST_F(QueueScheduleSTest, PostProcess_Fail01)
    {
        GlobalMockObject::verify();
        dgw::PeekState peekState;
        dgw::EntityMaterial material = {};
        material.eType = dgw::EntityType::ENTITY_QUEUE;
        material.id = 1001U;
        dgw::Entity* entity = new dgw::SimpleEntity(material, 0U);
        MOCKER(halMbufGetPrivInfo)
            .stubs()
            .will(returnValue(-1));
        entity->SetNeedTransId(true);
        dgw::Entity& entityRef = *entity;
        auto ret = peekState.PostProcess(entityRef);
        EXPECT_EQ(ret, dgw::FsmStatus::FSM_SUCCESS);
        delete entity;
    }

    TEST_F(QueueScheduleSTest, AddSrcToDst_fail)
    {
        auto srcEntity = EntityInfo(200U, 0U);
        auto dstEntity = EntityInfo(300U, 0U);
        EXPECT_EQ(BindRelation::GetInstance().AddSrcToDst(srcEntity, dstEntity),
                  bqs::BqsStatus::BQS_STATUS_INNER_ERROR);
    }

    TEST_F(QueueScheduleSTest, AddDstToSrc_fail)
    {
        auto srcEntity = EntityInfo(200U, 0U);
        auto dstEntity = EntityInfo(300U, 0U);
        EXPECT_EQ(BindRelation::GetInstance().AddDstToSrc(srcEntity, dstEntity),
                  bqs::BqsStatus::BQS_STATUS_INNER_ERROR);
    }

    TEST_F(QueueScheduleSTest, LoopProcessEnqueueEvent_with_halEschedWaitEventFail)
    {
        MOCKER(halEschedWaitEvent)
            .stubs()
            .will(invoke(halEschedWaitEventErrorOrTimeOut));

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
        queueSchedule.LoopProcessEnqueueEvent(1U, 0U, 5, 0);

        controlThread.join();
        EXPECT_FALSE(queueSchedule.running_);
    }

    TEST_F(QueueScheduleSTest, HcclProcess_AllocMbuf_fail1)
    {
        uint32_t queueId = 1001;
        EntityInfo src(queueId, 0U);
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        uint32_t uniqueTagId = 100U;
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo dst(uniqueTagId, 0U, &args);
        auto &bindRelation = BindRelation::GetInstance();
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dst));
        bindRelation.Order();

        MOCKER(halMbufAlloc).stubs().will(returnValue(0));

        MOCKER(halMbufSetDataLen)
            .stubs()
            .will(returnValue(-1));

        MOCKER(halMbufFree)
                .stubs()
                .will(returnValue(0));

        dgw::EntityPtr entity2 = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_NE(entity2, nullptr);
        dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity2.get());
        // include one request for link establishment
        Mbuf *mbuf1 = nullptr;
        void *headBuf = nullptr;
        void *dataBuf = nullptr;
        const uint64_t dataSize = 128;
        channelEntity->AllocMbuf(mbuf1, headBuf, dataBuf, dataSize);

        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dst));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, HcclProcess_AllocMbuf_fail2)
    {
        uint32_t queueId = 1001;
        EntityInfo src(queueId, 0U);
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        uint32_t uniqueTagId = 100U;
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo dst(uniqueTagId, 0U, &args);
        auto &bindRelation = BindRelation::GetInstance();
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dst));
        bindRelation.Order();

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

        dgw::EntityPtr entity2 = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_NE(entity2, nullptr);
        dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity2.get());
        // include one request for link establishment
        Mbuf *mbuf1 = nullptr;
        void *headBuf = nullptr;
        void *dataBuf = nullptr;
        const uint64_t dataSize = 128;
        channelEntity->AllocMbuf(mbuf1, headBuf, dataBuf, dataSize);

        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dst));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, HcclProcess_AllocMbuf_fail3)
    {
        uint32_t queueId = 1001;
        EntityInfo src(queueId, 0U);
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        uint32_t uniqueTagId = 100U;
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo dst(uniqueTagId, 0U, &args);
        auto &bindRelation = BindRelation::GetInstance();
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dst));
        bindRelation.Order();

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
        MOCKER(halMbufGetBuffAddr)
                .stubs()
                .will(returnValue(-1));

        dgw::EntityPtr entity2 = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_NE(entity2, nullptr);
        dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity2.get());
        // include one request for link establishment
        Mbuf *mbuf1 = nullptr;
        void *headBuf = nullptr;
        void *dataBuf = nullptr;
        const uint64_t dataSize = 128;
        channelEntity->AllocMbuf(mbuf1, headBuf, dataBuf, dataSize);

        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dst));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, HcclProcess_AllocMbuf_fail4)
    {
        uint32_t queueId = 1001;
        EntityInfo src(queueId, 0U);
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        uint32_t uniqueTagId = 100U;
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo dst(uniqueTagId, 0U, &args);
        auto &bindRelation = BindRelation::GetInstance();
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dst));
        bindRelation.Order();

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

        dgw::EntityPtr entity2 = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_NE(entity2, nullptr);
        dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity2.get());
        // include one request for link establishment
        Mbuf *mbuf1 = nullptr;
        void *headBuf = nullptr;
        void *dataBuf = nullptr;
        const uint64_t dataSize = 128;
        channelEntity->AllocMbuf(mbuf1, headBuf, dataBuf, dataSize);

        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dst));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, HcclProcess_ReceiveMbufData_fail1)
    {
        uint32_t queueId = 1001;
        EntityInfo src(queueId, 0U);
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        uint32_t uniqueTagId = 100U;
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo dst(uniqueTagId, 0U, &args);
        auto &bindRelation = BindRelation::GetInstance();
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dst));
        bindRelation.Order();

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

        dgw::EntityPtr entity2 = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_NE(entity2, nullptr);
        dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity2.get());
        // include one request for link establishment
        HcclMessage msg = nullptr;
        channelEntity->ReceiveMbufData(msg);

        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dst));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, HcclProcess_ReceiveMbufData_fail2)
    {
        uint32_t queueId = 1001;
        EntityInfo src(queueId, 0U);
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        uint32_t uniqueTagId = 100U;
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo dst(uniqueTagId, 0U, &args);
        auto &bindRelation = BindRelation::GetInstance();
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dst));
        bindRelation.Order();

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

        dgw::EntityPtr entity2 = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_NE(entity2, nullptr);
        dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity2.get());
        // include one request for link establishment
        HcclMessage msg = nullptr;
        channelEntity->ReceiveMbufData(msg);

        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dst));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, HcclProcess_SendMbufData_fail1)
    {
        uint32_t queueId = 1001;
        EntityInfo src(queueId, 0U);
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        uint32_t uniqueTagId = 100U;
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo dst(uniqueTagId, 0U, &args);
        auto &bindRelation = BindRelation::GetInstance();
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dst));
        bindRelation.Order();

        MOCKER(halMbufAlloc).stubs().will(returnValue(0));

        MOCKER(halMbufFree)
                .stubs()
                .will(returnValue(0));

        MOCKER(halMbufGetBuffSize)
                .stubs()
                .will(returnValue(-1));

        dgw::EntityPtr entity2 = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_NE(entity2, nullptr);
        dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity2.get());
        // include one request for link establishment
        Mbuf *mbuf1 = nullptr;
        channelEntity->SendMbufData(mbuf1);

        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dst));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, HcclProcess_SendMbufHead_fail1)
    {
        uint32_t queueId = 1001;
        EntityInfo src(queueId, 0U);
        dgw::CommChannel channel(hcclComm, 1U, 1U, 0U, 1U, 128U, 128U);
        uint32_t uniqueTagId = 100U;
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_TAG;
        args.channelPtr = &channel;
        EntityInfo dst(uniqueTagId, 0U, &args);
        auto &bindRelation = BindRelation::GetInstance();
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dst));
        bindRelation.Order();

        MOCKER(halMbufAlloc).stubs().will(returnValue(0));

        MOCKER(halMbufFree)
                .stubs()
                .will(returnValue(0));

        MOCKER(halMbufGetPrivInfo)
                .stubs()
                .will(returnValue(-1));

        dgw::EntityPtr entity2 = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_TAG, uniqueTagId,
            dgw::EntityDirection::DIRECTION_RECV);
        EXPECT_NE(entity2, nullptr);
        dgw::ChannelEntity *channelEntity = static_cast<dgw::ChannelEntity *>(entity2.get());
        // include one request for link establishment
        Mbuf *mbuf1 = nullptr;
        channelEntity->SendMbufHead(mbuf1);

        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dst));
        bindRelation.Order();

        MOCKER(bqs::GetRunContext).stubs().will(returnValue(bqs::RunContext::DEVICE));
        queueSchedule.initQsParams_.schedPolicy = static_cast<uint64_t>(bqs::QsStartType::START_BY_TSD);
        queueSchedule.initQsParams_.runMode = QueueSchedulerRunMode::SINGLE_PROCESS;
        queueSchedule.ReportAbnormal();
    }

    TEST_F(QueueScheduleSTest, DynamicSchedule_success)
    {
        auto &bindRelation = BindRelation::GetInstance();
        uint32_t groupId;
        std::vector<EntityInfoPtr> entities;
        bqs::OptionalArg args = {};
        args.schedCfgKey = 1U;
        EntityInfoPtr entity1 = std::make_shared<EntityInfo>(4002U, 0U, &args);
        args.globalId = 1U;
        EntityInfoPtr entity2 = std::make_shared<EntityInfo>(4003U, 0U, &args);
        entities.emplace_back(entity1);
        entities.emplace_back(entity2);
        bindRelation.CreateGroup(entities, groupId);
        args.eType = dgw::EntityType::ENTITY_GROUP;
        args.policy = bqs::GroupPolicy::DYNAMIC;
        args.globalId = 7U;
        EntityInfo dest(groupId, 0U, &args);

        args.eType = dgw::EntityType::ENTITY_QUEUE;
        args.policy = bqs::GroupPolicy::HASH;
        args.globalId = 6U;
        EntityInfo src(4001U, 0U, &args);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, dest));
        bindRelation.Order();

        auto srcEntity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 4001,
            dgw::EntityDirection::DIRECTION_SEND);
        auto dataObj = dgw::DataObjManager::Instance().CreateDataObj(srcEntity.get(), 1);
        auto destEntity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_GROUP, groupId,
            dgw::EntityDirection::DIRECTION_RECV);
        dataObj->AddRecvEntity(destEntity.get());
        srcEntity->AddDataObjToSendList(dataObj);
        srcEntity->SetWaitDecisionState(true);

        MOCKER(halQueueDeQueue).stubs().will(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
        std::vector<dgw::DynamicSchedMgr::ResponseInfo> responses;
        dgw::DynamicSchedMgr::ResponseInfo dynamicResponse = {};
        dynamicResponse.src.queueLogicId = 6U;
        dynamicResponse.groupResults.emplace_back(dgw::DynamicSchedMgr::GroupResult{7U, 0U});
        responses.emplace_back(dynamicResponse);
        MOCKER_CPP(&dgw::DynamicSchedMgr::GetResponse)
            .stubs().with(mockcpp::any(), outBound(responses))
            .will(returnValue(dgw::FsmStatus::FSM_SUCCESS))
            .then(returnValue(dgw::FsmStatus::FSM_FAILED));

        DynamicSchedQueueAttr queueAttr = {};
        dgw::ScheduleConfig::GetInstance().RecordConfig(1U, queueAttr, queueAttr);
        queueSchedule.DynamicSchedule(0U);
        dgw::ScheduleConfig::GetInstance().schedKeys_.clear();
        dgw::ScheduleConfig::GetInstance().configMap_.clear();

        EXPECT_TRUE(srcEntity->GetSendDataObjs().empty());
        EXPECT_FALSE(srcEntity->GetWaitDecisionState());

        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBind(src, dest));
        bindRelation.Order();
    }

    TEST_F(QueueScheduleSTest, TryPushWithDynamicDstGroup_success)
    {
        auto &bindRelation = BindRelation::GetInstance();
        bqs::OptionalArg args = {};
        args.globalId = 6U;
        EntityInfo src(4001U, 0U, &args);
        args.globalId = 7U;
        EntityInfo destQ(4002U, 0U, &args);
        uint32_t groupId;
        std::vector<EntityInfoPtr> entities;
        EntityInfoPtr entity1 = std::make_shared<EntityInfo>(4003U, 0U);
        args.globalId = 1U;
        EntityInfoPtr entity2 = std::make_shared<EntityInfo>(4004U, 0U, &args);
        entities.emplace_back(entity1);
        entities.emplace_back(entity2);
        bindRelation.CreateGroup(entities, groupId);
        args.globalId = 7U;
        args.eType = dgw::EntityType::ENTITY_GROUP;
        args.policy = bqs::GroupPolicy::DYNAMIC;
        EntityInfo destGroup(groupId, 0U, &args);
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, destQ));
        EXPECT_EQ(BQS_STATUS_OK, bindRelation.Bind(src, destGroup));
        bindRelation.Order();

        auto srcEntity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 4001,
            dgw::EntityDirection::DIRECTION_SEND);

        auto dstGroupEntity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_GROUP, groupId,
            dgw::EntityDirection::DIRECTION_RECV);
        auto dst1Entity = dgw::EntityManager::Instance().GetEntityById(bqs::LOCAL_Q, 0, dgw::EntityType::ENTITY_QUEUE, 4003,
            dgw::EntityDirection::DIRECTION_RECV);

        MOCKER(halQueueDeQueue).stubs().will(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
        Mbuf *mbuf = PtrToPtr<void, Mbuf>(ValueToPtr(1));
        MOCKER(halMbufCopyRef).stubs().with(mockcpp::any(), outBoundP(&mbuf)).will(returnValue(0));
        MOCKER_CPP(&dgw::DynamicSchedMgr::SendRequest)
            .stubs()
            .will(returnValue(dgw::FsmStatus::FSM_FAILED))
            .then(returnValue(dgw::FsmStatus::FSM_SUCCESS));
        EXPECT_EQ(dgw::FsmStatus::FSM_FAILED, srcEntity->ChangeState(dgw::FsmState::FSM_TRY_PUSH_STATE));

        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, srcEntity->ChangeState(dgw::FsmState::FSM_TRY_PUSH_STATE));
        EXPECT_EQ(srcEntity->GetSendDataObjs().size(), 1);
        EXPECT_EQ(srcEntity->GetSendDataObjs().front()->GetRecvEntitySize(), 1);

        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, srcEntity->ChangeState(dgw::FsmState::FSM_TRY_PUSH_STATE));
        EXPECT_EQ(srcEntity->GetSendDataObjs().size(), 2);
        EXPECT_EQ(srcEntity->GetSendDataObjs().back()->GetRecvEntitySize(), 2);

        EXPECT_EQ(BQS_STATUS_OK, bindRelation.UnBindBySrc(src));
        bindRelation.Order();
    }
    
    TEST_F(QueueScheduleSTest, ScheduleDataBuffAll_MemQueue_SrcClientQ_Failed_Peek)
    {
        GlobalMockObject::verify();
        bqs::BqsStatus ret = bqs::QueueManager::GetInstance().InitQueueManager(0, 0, true, "iniQ");
        EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

        auto &bindRelation = BindRelation::GetInstance();
        bqs::OptionalArg args = {};
        args.queueType = 1U;
        auto srcEntity = EntityInfo(142U, 0U, &args);
        auto dstEntity = EntityInfo(152U, 0U);
        bindRelation.Bind(srcEntity, dstEntity);
        bindRelation.Order();

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::CLIENT_Q, 0, dgw::EntityType::ENTITY_QUEUE, 142U,
            dgw::EntityDirection::DIRECTION_SEND);
        dgw::ClientEntity *clientEntity = reinterpret_cast<dgw::ClientEntity*>(entity.get());
        clientEntity->asyncDataState_ = dgw::AsyncDataState::FSM_ASYNC_ENTITY_DONE;

        bool dataEnqueue = true;
        int32_t buf = 1;
        int32_t *pmbuf = &buf;
        MOCKER(halQueuePeek)
            .stubs()
            .will(returnValue((int)BQS_STATUS_PARAM_INVALID));
        queueSchedule.ScheduleDataBuffAll(dataEnqueue);
        int32_t reTry = 0;
        while (reTry++ < 3) {
            if (clientEntity->asyncDataState_ == dgw::AsyncDataState::FSM_ASYNC_DATA_INIT) {
                break;
            }
            sleep(2);
        }
        EXPECT_EQ(clientEntity->asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_INIT);
        bindRelation.UnBind(srcEntity, dstEntity);
        bindRelation.Order();
        QueueScheduleDestroy(queueSchedule);
        GlobalMockObject::verify();
    }

    TEST_F(QueueScheduleSTest, ScheduleDataBuffAll_MemQueue_SrcClientQ_Failed_Alloc)
    {
        GlobalMockObject::verify();
        bqs::BqsStatus ret = bqs::QueueManager::GetInstance().InitQueueManager(0, 0, true, "iniQ");
        EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

        auto &bindRelation = BindRelation::GetInstance();
        bqs::OptionalArg args = {};
        args.queueType = 1U;
        auto srcEntity = EntityInfo(242U, 0U, &args);
        auto dstEntity = EntityInfo(252U, 0U);
        bindRelation.Bind(srcEntity, dstEntity);
        bindRelation.Order();

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::CLIENT_Q, 0, dgw::EntityType::ENTITY_QUEUE, 242U,
            dgw::EntityDirection::DIRECTION_SEND);
        dgw::ClientEntity *clientEntity = reinterpret_cast<dgw::ClientEntity*>(entity.get());
        clientEntity->asyncDataState_ = dgw::AsyncDataState::FSM_ASYNC_ENTITY_DONE;

        bool dataEnqueue = true;
        int32_t buf = 1;
        int32_t *pmbuf = &buf;
        MOCKER(halQueuePeek)
            .stubs()
            .will(invoke(halQueuePeekFake));
        int32_t temp = 1;
        int32_t *tempPtr = &temp;
        MOCKER(halMbufAlloc)
            .stubs().with(mockcpp::any(), outBoundP((Mbuf **)&tempPtr))
            .will(returnValue((int)DRV_ERROR_PARA_ERROR));
        queueSchedule.ScheduleDataBuffAll(dataEnqueue);
        int32_t reTry = 0;
        while (reTry++ < 3) {
            if (clientEntity->asyncDataState_ == dgw::AsyncDataState::FSM_ASYNC_DATA_INIT) {
                break;
            }
            sleep(2);
        }
        EXPECT_EQ(clientEntity->asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_INIT);
        bindRelation.UnBind(srcEntity, dstEntity);
        bindRelation.Order();
        QueueScheduleDestroy(queueSchedule);
        GlobalMockObject::verify();
    }

    TEST_F(QueueScheduleSTest, ScheduleDataBuffAll_MemQueue_SrcClientQ_Failed_GetPrivInfo)
    {
        GlobalMockObject::verify();
        bqs::BqsStatus ret = bqs::QueueManager::GetInstance().InitQueueManager(0, 0, true, "iniQ");
        EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

        auto &bindRelation = BindRelation::GetInstance();
        bqs::OptionalArg args = {};
        args.queueType = 1U;
        auto srcEntity = EntityInfo(342U, 0U, &args);
        auto dstEntity = EntityInfo(352U, 0U);
        bindRelation.Bind(srcEntity, dstEntity);
        bindRelation.Order();

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::CLIENT_Q, 0, dgw::EntityType::ENTITY_QUEUE, 342U,
            dgw::EntityDirection::DIRECTION_SEND);
        dgw::ClientEntity *clientEntity = reinterpret_cast<dgw::ClientEntity*>(entity.get());
        clientEntity->asyncDataState_ = dgw::AsyncDataState::FSM_ASYNC_ENTITY_DONE;

        bool dataEnqueue = true;
        int32_t buf = 1;
        int32_t *pmbuf = &buf;
        MOCKER(halQueuePeek)
            .stubs()
            .will(invoke(halQueuePeekFake));
        int32_t temp = 1;
        int32_t *tempPtr = &temp;
        MOCKER(halMbufAlloc)
            .stubs().with(mockcpp::any(), outBoundP((Mbuf **)&tempPtr))
            .will(returnValue((int)DRV_ERROR_NONE));
        uint32_t headBufSize = 256U;
        char headBuf[256];
        void *headBufAddr = (void *)(&headBuf[0]);
        MOCKER(halMbufGetPrivInfo)
            .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
            .will(returnValue((int)DRV_ERROR_PARA_ERROR));
        queueSchedule.ScheduleDataBuffAll(dataEnqueue);
        int32_t reTry = 0;
        while (reTry++ < 3) {
            if (clientEntity->asyncDataState_ == dgw::AsyncDataState::FSM_ASYNC_DATA_INIT) {
                break;
            }
            sleep(2);
        }
        EXPECT_EQ(clientEntity->asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_INIT);
        bindRelation.UnBind(srcEntity, dstEntity);
        bindRelation.Order();
        QueueScheduleDestroy(queueSchedule);
        GlobalMockObject::verify();
    }

    TEST_F(QueueScheduleSTest, ScheduleDataBuffAll_MemQueue_SrcClientQ_InvalidHeadLen)
    {
        GlobalMockObject::verify();
        bqs::BqsStatus ret = bqs::QueueManager::GetInstance().InitQueueManager(0, 0, true, "iniQ");
        EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

        auto &bindRelation = BindRelation::GetInstance();
        bqs::OptionalArg args = {};
        args.queueType = 1U;
        auto srcEntity = EntityInfo(442U, 0U, &args);
        auto dstEntity = EntityInfo(452U, 0U);
        bindRelation.Bind(srcEntity, dstEntity);
        bindRelation.Order();

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::CLIENT_Q, 0, dgw::EntityType::ENTITY_QUEUE, 442U,
            dgw::EntityDirection::DIRECTION_SEND);
        dgw::ClientEntity *clientEntity = reinterpret_cast<dgw::ClientEntity*>(entity.get());
        clientEntity->asyncDataState_ = dgw::AsyncDataState::FSM_ASYNC_ENTITY_DONE;

        bool dataEnqueue = true;
        int32_t buf = 1;
        int32_t *pmbuf = &buf;
        MOCKER(halQueuePeek)
            .stubs()
            .will(invoke(halQueuePeekFake));
        int32_t temp = 1;
        int32_t *tempPtr = &temp;
        MOCKER(halMbufAlloc)
            .stubs().with(mockcpp::any(), outBoundP((Mbuf **)&tempPtr))
            .will(returnValue((int)DRV_ERROR_NONE));
        uint32_t headBufSize = 128U;
        char headBuf[128];
        void *headBufAddr = (void *)(&headBuf[0]);
        MOCKER(halMbufGetPrivInfo)
            .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
            .will(returnValue((int)DRV_ERROR_NONE));
        queueSchedule.ScheduleDataBuffAll(dataEnqueue);
        int32_t reTry = 0;
        while (reTry++ < 3) {
            if (clientEntity->asyncDataState_ == dgw::AsyncDataState::FSM_ASYNC_DATA_INIT) {
                break;
            }
            sleep(2);
        }
        EXPECT_EQ(clientEntity->asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_INIT);
        bindRelation.UnBind(srcEntity, dstEntity);
        bindRelation.Order();
        QueueScheduleDestroy(queueSchedule);
        GlobalMockObject::verify();
    }

    TEST_F(QueueScheduleSTest, ScheduleDataBuffAll_MemQueue_SrcClientQ_Failed_GetBuffAddr)
    {
        GlobalMockObject::verify();
        bqs::BqsStatus ret = bqs::QueueManager::GetInstance().InitQueueManager(0, 0, true, "iniQ");
        EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

        auto &bindRelation = BindRelation::GetInstance();
        bqs::OptionalArg args = {};
        args.queueType = 1U;
        auto srcEntity = EntityInfo(542U, 0U, &args);
        auto dstEntity = EntityInfo(552U, 0U);
        bindRelation.Bind(srcEntity, dstEntity);
        bindRelation.Order();

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::CLIENT_Q, 0, dgw::EntityType::ENTITY_QUEUE, 542U,
            dgw::EntityDirection::DIRECTION_SEND);
        dgw::ClientEntity *clientEntity = reinterpret_cast<dgw::ClientEntity*>(entity.get());
        clientEntity->asyncDataState_ = dgw::AsyncDataState::FSM_ASYNC_ENTITY_DONE;

        bool dataEnqueue = true;
        int32_t buf = 1;
        int32_t *pmbuf = &buf;
        MOCKER(halQueuePeek)
            .stubs()
            .will(invoke(halQueuePeekFake));
        int32_t temp = 1;
        int32_t *tempPtr = &temp;
        MOCKER(halMbufAlloc)
            .stubs().with(mockcpp::any(), outBoundP((Mbuf **)&tempPtr))
            .will(returnValue((int)DRV_ERROR_NONE));
        uint32_t headBufSize = 256U;
        char headBuf[256];
        void *headBufAddr = (void *)(&headBuf[0]);
        MOCKER(halMbufGetPrivInfo)
            .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
            .will(returnValue((int)DRV_ERROR_NONE));
        MOCKER(halMbufGetBuffAddr)
            .stubs()
            .will(returnValue((int)DRV_ERROR_PARA_ERROR));
        queueSchedule.ScheduleDataBuffAll(dataEnqueue);
        int32_t reTry = 0;
        while (reTry++ < 3) {
            if (clientEntity->asyncDataState_ == dgw::AsyncDataState::FSM_ASYNC_DATA_INIT) {
                break;
            }
            sleep(2);
        }
        EXPECT_EQ(clientEntity->asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_INIT);
        bindRelation.UnBind(srcEntity, dstEntity);
        bindRelation.Order();
        QueueScheduleDestroy(queueSchedule);
        GlobalMockObject::verify();
    }

    TEST_F(QueueScheduleSTest, ScheduleDataBuffAll_MemQueue_SrcClientQ_InvalidDataPtr)
    {
        GlobalMockObject::verify();
        bqs::BqsStatus ret = bqs::QueueManager::GetInstance().InitQueueManager(0, 0, true, "iniQ");
        EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

        auto &bindRelation = BindRelation::GetInstance();
        bqs::OptionalArg args = {};
        args.queueType = 1U;
        auto srcEntity = EntityInfo(642U, 0U, &args);
        auto dstEntity = EntityInfo(652U, 0U);
        bindRelation.Bind(srcEntity, dstEntity);
        bindRelation.Order();

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::CLIENT_Q, 0, dgw::EntityType::ENTITY_QUEUE, 642U,
            dgw::EntityDirection::DIRECTION_SEND);
        dgw::ClientEntity *clientEntity = reinterpret_cast<dgw::ClientEntity*>(entity.get());
        clientEntity->asyncDataState_ = dgw::AsyncDataState::FSM_ASYNC_ENTITY_DONE;

        bool dataEnqueue = true;
        int32_t buf = 1;
        int32_t *pmbuf = &buf;
        MOCKER(halQueuePeek)
            .stubs()
            .will(invoke(halQueuePeekFake));
        int32_t temp = 1;
        int32_t *tempPtr = &temp;
        MOCKER(halMbufAlloc)
            .stubs().with(mockcpp::any(), outBoundP((Mbuf **)&tempPtr))
            .will(returnValue((int)DRV_ERROR_NONE));
        uint32_t headBufSize = 256U;
        char headBuf[256];
        void *headBufAddr = (void *)(&headBuf[0]);
        MOCKER(halMbufGetPrivInfo)
            .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
            .will(returnValue((int)DRV_ERROR_NONE));
        MOCKER(halMbufGetBuffAddr)
            .stubs()
            .will(returnValue((int)DRV_ERROR_NONE));
        queueSchedule.ScheduleDataBuffAll(dataEnqueue);
        int32_t reTry = 0;
        while (reTry++ < 3) {
            if (clientEntity->asyncDataState_ == dgw::AsyncDataState::FSM_ASYNC_DATA_INIT) {
                break;
            }
            sleep(2);
        }
        EXPECT_EQ(clientEntity->asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_INIT);
        bindRelation.UnBind(srcEntity, dstEntity);
        bindRelation.Order();
        QueueScheduleDestroy(queueSchedule);
        GlobalMockObject::verify();
    }

    TEST_F(QueueScheduleSTest, ScheduleDataBuffAll_MemQueue_SrcClientQ_Failed_DequeBuf)
    {
        GlobalMockObject::verify();
        bqs::BqsStatus ret = bqs::QueueManager::GetInstance().InitQueueManager(0, 0, true, "iniQ");
        EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

        auto &bindRelation = BindRelation::GetInstance();
        bqs::OptionalArg args = {};
        args.queueType = 1U;
        auto srcEntity = EntityInfo(842U, 0U, &args);
        auto dstEntity = EntityInfo(852U, 0U);
        bindRelation.Bind(srcEntity, dstEntity);
        bindRelation.Order();

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::CLIENT_Q, 0, dgw::EntityType::ENTITY_QUEUE, 842U,
            dgw::EntityDirection::DIRECTION_SEND);
        dgw::ClientEntity *clientEntity = reinterpret_cast<dgw::ClientEntity*>(entity.get());
        clientEntity->asyncDataState_ = dgw::AsyncDataState::FSM_ASYNC_ENTITY_DONE;

        bool dataEnqueue = true;
        int32_t buf = 1;
        int32_t *pmbuf = &buf;
        MOCKER(halQueuePeek)
            .stubs()
            .will(invoke(halQueuePeekFake));
        int32_t temp = 1;
        int32_t *tempPtr = &temp;
        MOCKER(halMbufAlloc)
            .stubs().with(mockcpp::any(), outBoundP((Mbuf **)&tempPtr))
            .will(returnValue((int)DRV_ERROR_NONE));
        uint32_t headBufSize = 256U;
        char headBuf[256];
        void *headBufAddr = (void *)(&headBuf[0]);
        MOCKER(halMbufGetPrivInfo)
            .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
            .will(returnValue((int)DRV_ERROR_NONE));
        MOCKER(halMbufGetBuffAddr)
            .stubs()
            .with(mockcpp::any(), outBoundP((void **)&headBufAddr))
            .will(returnValue((int)DRV_ERROR_NONE));
        MOCKER(halQueueDeQueueBuff)
            .stubs()
            .will(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
        queueSchedule.ScheduleDataBuffAll(dataEnqueue);
        int32_t reTry = 0;
        while (reTry++ < 3) {
            if (clientEntity->asyncDataState_ == dgw::AsyncDataState::FSM_ASYNC_DATA_INIT) {
                break;
            }
            sleep(2);
        }
        EXPECT_EQ(clientEntity->asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_INIT);
        bindRelation.UnBind(srcEntity, dstEntity);
        bindRelation.Order();
        QueueScheduleDestroy(queueSchedule);
        GlobalMockObject::verify();
    }

    TEST_F(QueueScheduleSTest, ScheduleDataBuffAll_MemQueue_SrcClientQ_success)
    {
        GlobalMockObject::verify();
        bqs::BqsStatus ret = bqs::QueueManager::GetInstance().InitQueueManager(0, 0, true, "iniQ");
        EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

        auto &bindRelation = BindRelation::GetInstance();
        bqs::OptionalArg args = {};
        args.queueType = 1U;
        auto srcEntity = EntityInfo(942U, 0U, &args);
        auto dstEntity = EntityInfo(952U, 0U);
        bindRelation.Bind(srcEntity, dstEntity);
        bindRelation.Order();

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::CLIENT_Q, 0, dgw::EntityType::ENTITY_QUEUE, 942U,
            dgw::EntityDirection::DIRECTION_SEND);
        dgw::ClientEntity *clientEntity = reinterpret_cast<dgw::ClientEntity*>(entity.get());
        clientEntity->asyncDataState_ = dgw::AsyncDataState::FSM_ASYNC_DATA_INIT;

        bool dataEnqueue = true;
        int32_t buf = 1;
        int32_t *pmbuf = &buf;
        MOCKER(halQueuePeek)
            .stubs()
            .will(invoke(halQueuePeekFake));
        int32_t temp = 1;
        int32_t *tempPtr = &temp;
        MOCKER(halMbufAlloc)
            .stubs().with(mockcpp::any(), outBoundP((Mbuf **)&tempPtr))
            .will(returnValue((int)DRV_ERROR_NONE));
        uint32_t headBufSize = 256U;
        char headBuf[256];
        void *headBufAddr = (void *)(&headBuf[0]);
        MOCKER(halMbufGetPrivInfo)
            .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
            .will(returnValue((int)DRV_ERROR_NONE));
        MOCKER(halMbufGetBuffAddr)
            .stubs()
            .with(mockcpp::any(), outBoundP((void **)&headBufAddr))
            .will(returnValue((int)DRV_ERROR_NONE));
        MOCKER(halQueueDeQueueBuff)
            .stubs()
            .will(returnValue((int)DRV_ERROR_NONE));
        queueSchedule.ScheduleDataBuffAll(dataEnqueue);
        int32_t reTry = 0;
        while (reTry++ < 3) {
            if (clientEntity->asyncDataState_ == dgw::AsyncDataState::FSM_ASYNC_DATA_SENT) {
                break;
            }
            sleep(2);
        }
        EXPECT_EQ(clientEntity->asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_SENT);
        bindRelation.UnBind(srcEntity, dstEntity);
        bindRelation.Order();
        QueueScheduleDestroy(queueSchedule);
        GlobalMockObject::verify();
    }

    TEST_F(QueueScheduleSTest, ScheduleDataBuffAll_MemQueue_SrcClientQ_Failed_Event)
    {
        GlobalMockObject::verify();
        bqs::BqsStatus ret = bqs::QueueManager::GetInstance().InitQueueManager(0, 0, true, "iniQ");
        EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

        auto &bindRelation = BindRelation::GetInstance();
        bqs::OptionalArg args = {};
        args.queueType = 1U;
        auto srcEntity = EntityInfo(942U, 0U, &args);
        auto dstEntity = EntityInfo(952U, 0U);
        bindRelation.Bind(srcEntity, dstEntity);
        bindRelation.Order();

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::CLIENT_Q, 0, dgw::EntityType::ENTITY_QUEUE, 942U,
            dgw::EntityDirection::DIRECTION_SEND);
        dgw::ClientEntity *clientEntity = reinterpret_cast<dgw::ClientEntity*>(entity.get());
        clientEntity->asyncDataState_ = dgw::AsyncDataState::FSM_ASYNC_DATA_INIT;

        bool dataEnqueue = true;
        int32_t buf = 1;
        int32_t *pmbuf = &buf;
        MOCKER(halQueuePeek)
            .stubs()
            .will(invoke(halQueuePeekFake));
        int32_t temp = 1;
        int32_t *tempPtr = &temp;
        MOCKER(halMbufAlloc)
            .stubs().with(mockcpp::any(), outBoundP((Mbuf **)&tempPtr))
            .will(returnValue((int)DRV_ERROR_NONE));
        uint32_t headBufSize = 256U;
        char headBuf[256];
        void *headBufAddr = (void *)(&headBuf[0]);
        MOCKER(halMbufGetPrivInfo)
            .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
            .will(returnValue((int)DRV_ERROR_NONE));
        MOCKER(halMbufGetBuffAddr)
            .stubs()
            .with(mockcpp::any(), outBoundP((void **)&headBufAddr))
            .will(returnValue((int)DRV_ERROR_NONE));
        MOCKER(halQueueDeQueueBuff)
            .stubs()
            .will(returnValue((int)DRV_ERROR_NONE));
        MOCKER(&bqs::QueueManager::GetInstance().EnqueueAsynMemBuffEvent)
            .stubs()
            .will(returnValue((int)bqs::BQS_STATUS_PARAM_INVALID));
        queueSchedule.ScheduleDataBuffAll(dataEnqueue);
        int32_t reTry = 0;
        while (reTry++ < 3) {
            if (clientEntity->asyncDataState_ == dgw::AsyncDataState::FSM_ASYNC_DATA_SENT) {
                break;
            }
            sleep(2);
        }
        EXPECT_EQ(clientEntity->asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_SENT);
        bindRelation.UnBind(srcEntity, dstEntity);
        bindRelation.Order();
        QueueScheduleDestroy(queueSchedule);
        GlobalMockObject::verify();
    }

    TEST_F(QueueScheduleSTest, ScheduleDataBuffAll_MemQueue_DstClientQ_Failed_GetPrivInfo)
    {
        GlobalMockObject::verify();
        bqs::BqsStatus ret = bqs::QueueManager::GetInstance().InitQueueManager(0, 0, true, "iniQ");
        EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

        auto &bindRelation = BindRelation::GetInstance();
        auto srcEntity = EntityInfo(161U, 0U);
        bqs::OptionalArg args = {};
        args.queueType = 1U;
        auto dstEntity = EntityInfo(171U, 0U, &args);
        bindRelation.Bind(srcEntity, dstEntity);
        bindRelation.Order();

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::CLIENT_Q, 0, dgw::EntityType::ENTITY_QUEUE, 171U,
            dgw::EntityDirection::DIRECTION_RECV);
        dgw::ClientEntity *clientEntity = reinterpret_cast<dgw::ClientEntity*>(entity.get());
        clientEntity->asyncDataState_ = dgw::AsyncDataState::FSM_ASYNC_ENTITY_DONE;


        bool dataEnqueue = true;
        int32_t buf = 1;
        int32_t *pmbuf = &buf;
        MOCKER(halQueueDeQueue)
            .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP((void **)&pmbuf))
            .will(returnValue((int)DRV_ERROR_NONE))
            .then(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
        uint32_t headBufSize = 256U;
        char headBuf[256];
        void *headBufAddr = (void *)(&headBuf[0]);
        MOCKER(halMbufGetPrivInfo)
            .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
            .will(returnValue((int)DRV_ERROR_PARA_ERROR));
        queueSchedule.ScheduleDataBuffAll(dataEnqueue);
        int32_t reTry = 0;
        while (reTry++ < 3) {
            if (clientEntity->asyncDataState_ == dgw::AsyncDataState::FSM_ASYNC_DATA_INIT) {
                break;
            }
            sleep(2);
        }
        EXPECT_EQ(clientEntity->asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_INIT);
        bindRelation.UnBind(srcEntity, dstEntity);
        bindRelation.Order();
        QueueScheduleDestroy(queueSchedule);
        GlobalMockObject::verify();
    }

    TEST_F(QueueScheduleSTest, ScheduleDataBuffAll_MemQueue_DstClientQ_Failed_InvalidHeadLen)
    {
        GlobalMockObject::verify();
        bqs::BqsStatus ret = bqs::QueueManager::GetInstance().InitQueueManager(0, 0, true, "iniQ");
        EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

        auto &bindRelation = BindRelation::GetInstance();
        auto srcEntity = EntityInfo(261U, 0U);
        bqs::OptionalArg args = {};
        args.queueType = 1U;
        auto dstEntity = EntityInfo(271U, 0U, &args);
        bindRelation.Bind(srcEntity, dstEntity);
        bindRelation.Order();

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::CLIENT_Q, 0, dgw::EntityType::ENTITY_QUEUE, 271U,
            dgw::EntityDirection::DIRECTION_RECV);
        dgw::ClientEntity *clientEntity = reinterpret_cast<dgw::ClientEntity*>(entity.get());
        clientEntity->asyncDataState_ = dgw::AsyncDataState::FSM_ASYNC_ENTITY_DONE;

        bool dataEnqueue = true;
        int32_t buf = 1;
        int32_t *pmbuf = &buf;
        MOCKER(halQueueDeQueue)
            .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP((void **)&pmbuf))
            .will(returnValue((int)DRV_ERROR_NONE))
            .then(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
        uint32_t headBufSize = 128;
        char headBuf[128];
        void *headBufAddr = (void *)(&headBuf[0]);
        MOCKER(halMbufGetPrivInfo)
            .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
            .will(returnValue((int)DRV_ERROR_NONE));

        queueSchedule.ScheduleDataBuffAll(dataEnqueue);
        int32_t reTry = 0;
        while (reTry++ < 3) {
            if (clientEntity->asyncDataState_ == dgw::AsyncDataState::FSM_ASYNC_DATA_INIT) {
                break;
            }
            sleep(2);
        }
        EXPECT_EQ(clientEntity->asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_INIT);
        bindRelation.UnBind(srcEntity, dstEntity);
        bindRelation.Order();
        QueueScheduleDestroy(queueSchedule);
        GlobalMockObject::verify();
    }

    TEST_F(QueueScheduleSTest, ScheduleDataBuffAll_MemQueue_DstClientQ_Failed_InvalidDataPtr)
    {
        GlobalMockObject::verify();
        bqs::BqsStatus ret = bqs::QueueManager::GetInstance().InitQueueManager(0, 0, true, "iniQ");
        EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

        auto &bindRelation = BindRelation::GetInstance();
        auto srcEntity = EntityInfo(361U, 0U);
        bqs::OptionalArg args = {};
        args.queueType = 1U;
        auto dstEntity = EntityInfo(371U, 0U, &args);
        bindRelation.Bind(srcEntity, dstEntity);
        bindRelation.Order();

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::CLIENT_Q, 0, dgw::EntityType::ENTITY_QUEUE, 371U,
            dgw::EntityDirection::DIRECTION_RECV);
        dgw::ClientEntity *clientEntity = reinterpret_cast<dgw::ClientEntity*>(entity.get());
        clientEntity->asyncDataState_ = dgw::AsyncDataState::FSM_ASYNC_ENTITY_DONE;

        bool dataEnqueue = true;
        int32_t buf = 1;
        int32_t *pmbuf = &buf;
        MOCKER(halQueueDeQueue)
            .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP((void **)&pmbuf))
            .will(returnValue((int)DRV_ERROR_NONE))
            .then(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
        uint32_t headBufSize = 256;
        char headBuf[256];
        void *headBufAddr = (void *)(&headBuf[0]);
        MOCKER(halMbufGetPrivInfo)
            .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
            .will(returnValue((int)DRV_ERROR_NONE));
        uint64_t dataLen = 512UL;
        MOCKER(halMbufGetDataLen)
            .stubs().with(mockcpp::any(), outBoundP(&dataLen))
            .will(returnValue((int)DRV_ERROR_NONE));
        queueSchedule.ScheduleDataBuffAll(dataEnqueue);
        int32_t reTry = 0;
        while (reTry++ < 3) {
            if (clientEntity->asyncDataState_ == dgw::AsyncDataState::FSM_ASYNC_DATA_INIT) {
                break;
            }
            sleep(2);
        }
        EXPECT_EQ(clientEntity->asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_INIT);
        bindRelation.UnBind(srcEntity, dstEntity);
        bindRelation.Order();
        QueueScheduleDestroy(queueSchedule);
        GlobalMockObject::verify();
    }

    TEST_F(QueueScheduleSTest, ScheduleDataBuffAll_MemQueue_DstClientQ_Failed_GetBuffAddr)
    {
        GlobalMockObject::verify();
        bqs::BqsStatus ret = bqs::QueueManager::GetInstance().InitQueueManager(0, 0, true, "iniQ");
        EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

        auto &bindRelation = BindRelation::GetInstance();
        auto srcEntity = EntityInfo(461U, 0U);
        bqs::OptionalArg args = {};
        args.queueType = 1U;
        auto dstEntity = EntityInfo(471U, 0U, &args);
        bindRelation.Bind(srcEntity, dstEntity);
        bindRelation.Order();

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::CLIENT_Q, 0, dgw::EntityType::ENTITY_QUEUE, 471U,
            dgw::EntityDirection::DIRECTION_RECV);
        dgw::ClientEntity *clientEntity = reinterpret_cast<dgw::ClientEntity*>(entity.get());
        clientEntity->asyncDataState_ = dgw::AsyncDataState::FSM_ASYNC_ENTITY_DONE;

        bool dataEnqueue = true;
        int32_t buf = 1;
        int32_t *pmbuf = &buf;
        MOCKER(halQueueDeQueue)
            .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP((void **)&pmbuf))
            .will(returnValue((int)DRV_ERROR_NONE));
        uint32_t headBufSize = 256;
        char headBuf[256];
        void *headBufAddr = (void *)(&headBuf[0]);
        MOCKER(halMbufGetPrivInfo)
            .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
            .will(returnValue((int)DRV_ERROR_NONE));
        uint64_t dataLen = 512UL;
        MOCKER(halMbufGetDataLen)
            .stubs().with(mockcpp::any(), outBoundP(&dataLen))
            .will(returnValue((int)DRV_ERROR_NONE));
        MOCKER(halMbufGetBuffAddr)
            .stubs().with(mockcpp::any(),  outBoundP((void **)&pmbuf))
            .will(returnValue((int)DRV_ERROR_PARA_ERROR));
        queueSchedule.ScheduleDataBuffAll(dataEnqueue);
        int32_t reTry = 0;
        while (reTry++ < 3) {
            if (clientEntity->asyncDataState_ == dgw::AsyncDataState::FSM_ASYNC_DATA_INIT) {
                break;
            }
            sleep(2);
        }
        EXPECT_EQ(clientEntity->asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_INIT);
        bindRelation.UnBind(srcEntity, dstEntity);
        bindRelation.Order();
        QueueScheduleDestroy(queueSchedule);
        GlobalMockObject::verify();
    }

    TEST_F(QueueScheduleSTest, ScheduleDataBuffAll_MemQueue_DstClientQ_Failed_EnQueueBuff)
    {
        GlobalMockObject::verify();
        bqs::BqsStatus ret = bqs::QueueManager::GetInstance().InitQueueManager(0, 0, true, "iniQ");
        EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

        auto &bindRelation = BindRelation::GetInstance();
        auto srcEntity = EntityInfo(561U, 0U);
        bqs::OptionalArg args = {};
        args.queueType = 1U;
        auto dstEntity = EntityInfo(571U, 0U, &args);
        bindRelation.Bind(srcEntity, dstEntity);
        bindRelation.Order();

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::CLIENT_Q, 0, dgw::EntityType::ENTITY_QUEUE, 571U,
            dgw::EntityDirection::DIRECTION_RECV);
        dgw::ClientEntity *clientEntity = reinterpret_cast<dgw::ClientEntity*>(entity.get());
        clientEntity->asyncDataState_ = dgw::AsyncDataState::FSM_ASYNC_ENTITY_DONE;

        bool dataEnqueue = true;
        int32_t buf = 1;
        int32_t *pmbuf = &buf;
        MOCKER(halQueueDeQueue)
            .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP((void **)&pmbuf))
            .will(returnValue((int)DRV_ERROR_NONE));
        uint32_t headBufSize = 256;
        char headBuf[256];
        void *headBufAddr = (void *)(&headBuf[0]);
        MOCKER(halMbufGetPrivInfo)
            .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
            .will(returnValue((int)DRV_ERROR_NONE));
        uint64_t dataLen = 512UL;
        MOCKER(halMbufGetDataLen)
            .stubs().with(mockcpp::any(), outBoundP(&dataLen))
            .will(returnValue((int)DRV_ERROR_NONE));
        MOCKER(halMbufGetBuffAddr)
            .stubs().with(mockcpp::any(),  outBoundP((void **)&pmbuf))
            .will(returnValue((int)DRV_ERROR_NONE));
        MOCKER(halQueueEnQueueBuff)
            .stubs()
            .will(returnValue((int)DRV_ERROR_PARA_ERROR));
        queueSchedule.ScheduleDataBuffAll(dataEnqueue);
        int32_t reTry = 0;
        while (reTry++ < 3) {
            if (clientEntity->asyncDataState_ == dgw::AsyncDataState::FSM_ASYNC_DATA_INIT) {
                break;
            }
            sleep(2);
        }
        EXPECT_EQ(clientEntity->asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_INIT);
        bindRelation.UnBind(srcEntity, dstEntity);
        bindRelation.Order();
        QueueScheduleDestroy(queueSchedule);
        GlobalMockObject::verify();
    }

    TEST_F(QueueScheduleSTest, ScheduleDataBuffAll_MemQueue_DstClientQ_EnqueBufFull)
    {
        GlobalMockObject::verify();
        bqs::BqsStatus ret = bqs::QueueManager::GetInstance().InitQueueManager(0, 0, true, "iniQ");
        EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

        auto &bindRelation = BindRelation::GetInstance();
        auto srcEntity = EntityInfo(661U, 0U);
        bqs::OptionalArg args = {};
        args.queueType = 1U;
        auto dstEntity = EntityInfo(671U, 0U, &args);
        bindRelation.Bind(srcEntity, dstEntity);
        bindRelation.Order();

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::CLIENT_Q, 0, dgw::EntityType::ENTITY_QUEUE, 671U,
            dgw::EntityDirection::DIRECTION_RECV);
        dgw::ClientEntity *clientEntity = reinterpret_cast<dgw::ClientEntity*>(entity.get());
        clientEntity->asyncDataState_ = dgw::AsyncDataState::FSM_ASYNC_ENTITY_DONE;

        bool dataEnqueue = true;
        int32_t buf = 1;
        int32_t *pmbuf = &buf;
        MOCKER(halQueueDeQueue)
            .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP((void **)&pmbuf))
            .will(returnValue((int)DRV_ERROR_NONE));
        uint32_t headBufSize = 256;
        char headBuf[256];
        void *headBufAddr = (void *)(&headBuf[0]);
        MOCKER(halMbufGetPrivInfo)
            .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
            .will(returnValue((int)DRV_ERROR_NONE));
        uint64_t dataLen = 512UL;
        MOCKER(halMbufGetDataLen)
            .stubs().with(mockcpp::any(), outBoundP(&dataLen))
            .will(returnValue((int)DRV_ERROR_NONE));
        MOCKER(halMbufGetBuffAddr)
            .stubs().with(mockcpp::any(),  outBoundP((void **)&pmbuf))
            .will(returnValue((int)DRV_ERROR_NONE));
        MOCKER(halQueueEnQueueBuff)
            .stubs()
            .will(returnValue((int)DRV_ERROR_QUEUE_FULL));
        queueSchedule.ScheduleDataBuffAll(dataEnqueue);
        int32_t reTry = 0;
        while (reTry++ < 3) {
            if (clientEntity->asyncDataState_ == dgw::AsyncDataState::FSM_ASYNC_DATA_INIT) {
                break;
            }
            sleep(2);
        }
        EXPECT_EQ(clientEntity->asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_INIT);
        bindRelation.UnBind(srcEntity, dstEntity);
        bindRelation.Order();
        QueueScheduleDestroy(queueSchedule);
        GlobalMockObject::verify();
    }

    TEST_F(QueueScheduleSTest, ScheduleDataBuffAll_MemQueue_DstClientQ_Failed_Event)
    {
        GlobalMockObject::verify();
        bqs::BqsStatus ret = bqs::QueueManager::GetInstance().InitQueueManager(0, 0, true, "iniQ");
        EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

        auto &bindRelation = BindRelation::GetInstance();
        auto srcEntity = EntityInfo(761U, 0U);
        bqs::OptionalArg args = {};
        args.queueType = 1U;
        auto dstEntity = EntityInfo(771U, 0U, &args);
        bindRelation.Bind(srcEntity, dstEntity);
        bindRelation.Order();

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::CLIENT_Q, 0, dgw::EntityType::ENTITY_QUEUE, 771U,
            dgw::EntityDirection::DIRECTION_RECV);
        dgw::ClientEntity *clientEntity = reinterpret_cast<dgw::ClientEntity*>(entity.get());
        clientEntity->asyncDataState_ = dgw::AsyncDataState::FSM_ASYNC_DATA_INIT;

        bool dataEnqueue = true;
        int32_t buf = 1;
        int32_t *pmbuf = &buf;
        MOCKER(halQueueDeQueue)
            .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP((void **)&pmbuf))
            .will(returnValue((int)DRV_ERROR_NONE));
        uint32_t headBufSize = 256;
        char headBuf[256];
        void *headBufAddr = (void *)(&headBuf[0]);
        MOCKER(halMbufGetPrivInfo)
            .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
            .will(returnValue((int)DRV_ERROR_NONE));
        uint64_t dataLen = 512UL;
        MOCKER(halMbufGetDataLen)
            .stubs().with(mockcpp::any(), outBoundP(&dataLen))
            .will(returnValue((int)DRV_ERROR_NONE));
        MOCKER(halMbufGetBuffAddr)
            .stubs().with(mockcpp::any(),  outBoundP((void **)&pmbuf))
            .will(returnValue((int)DRV_ERROR_NONE));
        MOCKER(halQueueEnQueueBuff)
            .stubs()
            .will(returnValue((int)DRV_ERROR_NONE));
        MOCKER(&bqs::QueueManager::GetInstance().EnqueueAsynMemBuffEvent)
            .stubs()
            .will(returnValue((int)bqs::BQS_STATUS_PARAM_INVALID));
        queueSchedule.ScheduleDataBuffAll(dataEnqueue);
        int32_t reTry = 0;
        while (reTry++ < 3) {
            if (clientEntity->asyncDataState_ == dgw::AsyncDataState::FSM_ASYNC_DATA_SENT) {
                break;
            }
            sleep(2);
        }
        EXPECT_EQ(clientEntity->asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_SENT);
        bindRelation.UnBind(srcEntity, dstEntity);
        bindRelation.Order();
        QueueScheduleDestroy(queueSchedule);
        GlobalMockObject::verify();
    }

    TEST_F(QueueScheduleSTest, ScheduleDataBuffAll_MemQueue_DstClientQ_success00)
    {
        GlobalMockObject::verify();
        bqs::BqsStatus ret = bqs::QueueManager::GetInstance().InitQueueManager(0, 0, true, "iniQ");
        EXPECT_EQ(ret, bqs::BQS_STATUS_OK);

        auto &bindRelation = BindRelation::GetInstance();
        auto srcEntity = EntityInfo(861U, 0U);
        bqs::OptionalArg args = {};
        args.queueType = 1U;
        auto dstEntity = EntityInfo(871U, 0U, &args);
        bindRelation.Bind(srcEntity, dstEntity);
        bindRelation.Order();

        auto entity = dgw::EntityManager::Instance().GetEntityById(bqs::CLIENT_Q, 0, dgw::EntityType::ENTITY_QUEUE, 871U,
            dgw::EntityDirection::DIRECTION_RECV);
        dgw::ClientEntity *clientEntity = reinterpret_cast<dgw::ClientEntity*>(entity.get());
        clientEntity->asyncDataState_ = dgw::AsyncDataState::FSM_ASYNC_DATA_INIT;

        bool dataEnqueue = true;
        int32_t buf = 1;
        int32_t *pmbuf = &buf;
        MOCKER(halQueueDeQueue)
            .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP((void **)&pmbuf))
            .will(returnValue((int)DRV_ERROR_NONE));
        uint32_t headBufSize = 256U;
        char headBuf[256];
        void *headBufAddr = (void *)(&headBuf[0]);
        MOCKER(halMbufGetPrivInfo)
            .stubs().with(mockcpp::any(), outBoundP((void **)&headBufAddr), outBoundP(&headBufSize))
            .will(returnValue((int)DRV_ERROR_NONE));
        uint64_t dataLen = 512UL;
        MOCKER(halMbufGetDataLen)
            .stubs().with(mockcpp::any(), outBoundP(&dataLen))
            .will(returnValue((int)DRV_ERROR_NONE));
        MOCKER(halMbufGetBuffAddr)
            .stubs().with(mockcpp::any(),  outBoundP((void **)&pmbuf))
            .will(returnValue((int)DRV_ERROR_NONE));
        MOCKER(halQueueEnQueueBuff)
            .stubs()
            .will(returnValue((int)DRV_ERROR_NONE));
        queueSchedule.ScheduleDataBuffAll(dataEnqueue);
        int32_t reTry = 0;
        while (reTry++ < 3) {
            if (clientEntity->asyncDataState_ == dgw::AsyncDataState::FSM_ASYNC_DATA_SENT) {
                break;
            }
            sleep(2);
        }
        EXPECT_EQ(clientEntity->asyncDataState_, dgw::AsyncDataState::FSM_ASYNC_DATA_SENT);
        bindRelation.UnBind(srcEntity, dstEntity);
        bindRelation.Order();
        QueueScheduleDestroy(queueSchedule);
        GlobalMockObject::verify();
    }

    TEST_F(QueueScheduleSTest, ScheduleDataBuffAll_MemQueue_ProcessAsysnc_success01)
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
        queueSchedule.ScheduleDataBuffAll(dataEnqueue);
        QueueScheduleDestroy(queueSchedule);
        sleep(2);
        GlobalMockObject::verify();
    }

    TEST_F(QueueScheduleSTest, ScheduleDataBuffAll_MemQueue_ProcessAsysnc_success02)
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
        EntityInfo src(1298U, 0U);
        bqs::OptionalArg args = {};
        args.eType = dgw::EntityType::ENTITY_GROUP;
        EntityInfo dst(groupId, 0U, &args);
        bindRelation.Bind(src, dst);
        bindRelation.Order();
        bool dataEnqueue = true;
        queueSchedule.ScheduleDataBuffAll(dataEnqueue);
        QueueScheduleDestroy(queueSchedule);
        sleep(2);
        GlobalMockObject::verify();
    }

    TEST_F(QueueScheduleSTest, DaemonEnqueueEvent)
    {
        int32_t mbuf = 1;
        int32_t *pmbuf = &mbuf;
        MOCKER(halQueueDeQueue)
            .stubs().with(mockcpp::any(), mockcpp::any(), outBoundP((void **)&pmbuf))
            .will(returnValue((int)DRV_ERROR_NONE))
            .then(returnValue((int)DRV_ERROR_QUEUE_EMPTY));
        queueSchedule.DaemonEnqueueEvent(0U);
        EXPECT_EQ(ProfileManager::GetInstance(0U).enqueEventTrack_.srcQueueNum,
            BindRelation::GetInstance().GetOrderedSubscribeQueueId().size());
    }

    TEST_F(QueueScheduleSTest, ProcessMessage_Success)
    {
        GlobalMockObject::verify();
        MOCKER_CPP(&dgw::StateManager::Instance().GetState)
                .stubs()
                .will(returnValue((dgw::StateBase *)nullptr));
        const dgw::InnerMessage msg;
        dgw::EntityMaterial material = {};
        material.eType = dgw::EntityType::ENTITY_QUEUE;
        material.queueType = 1;
        dgw::EntityPtr entity = std::make_shared<dgw::SimpleEntity>(material, 0U);
        EXPECT_EQ(entity->ProcessMessage(msg), dgw::FsmStatus::FSM_FAILED);
        dgw::FsmState nextState = dgw::FsmState::FSM_IDLE_STATE;
        EXPECT_EQ(entity->ChangeState(nextState), dgw::FsmStatus::FSM_FAILED);
    }

    TEST_F(QueueScheduleSTest, AddDataObjToSendList_Failed)
    {
        GlobalMockObject::verify();
        dgw::EntityMaterial material = {};
        material.eType = dgw::EntityType::ENTITY_QUEUE;
        material.queueType = 1;
        dgw::EntityPtr entity = std::make_shared<dgw::SimpleEntity>(material, 0U);
        EXPECT_EQ(true, entity != nullptr);
        Mbuf *mbuf = 1;
        auto dataObj = dgw::DataObjManager::Instance().CreateDataObj(entity.get(), mbuf);
        EXPECT_EQ(entity->AddDataObjToRecvList(dataObj), dgw::FsmStatus::FSM_SUCCESS);
        EXPECT_EQ(entity->AddDataObjToRecvList(dataObj), dgw::FsmStatus::FSM_SUCCESS);
    }

    TEST_F(QueueScheduleSTest, PauseSubscribe_Failed)
    {
        GlobalMockObject::verify();
        MOCKER_CPP(&bqs::Subscribers::GetInstance().GetSubscribeManager)
                .stubs()
                .will(returnValue((bqs::SubscribeManager *)nullptr));
        dgw::EntityMaterial material = {};
        material.eType = dgw::EntityType::ENTITY_QUEUE;
        material.queueType = 1;
        dgw::EntityPtr entity = std::make_shared<dgw::SimpleEntity>(material, 0U);
        dgw::SimpleEntity fullEntity(material, 0U);
        EXPECT_EQ(true, entity != nullptr);
        entity->subscribeStatus_ = dgw::SubscribeStatus::SUBSCRIBE_PAUSE;
        EXPECT_EQ(entity->PauseSubscribe(fullEntity), dgw::FsmStatus::FSM_SUCCESS);
        EXPECT_EQ(entity->ResumeSubscribe(fullEntity), dgw::FsmStatus::FSM_FAILED);
        entity->subscribeStatus_ = dgw::SubscribeStatus::SUBSCRIBE_RESUME;
        EXPECT_EQ(entity->ResumeSubscribe(fullEntity), dgw::FsmStatus::FSM_SUCCESS);
    }

    TEST_F(QueueScheduleSTest, WaitPushState_success)
    {
        dgw::WaitPushState waitPushState;
        dgw::EntityMaterial material = {};
        material.eType = dgw::EntityType::ENTITY_QUEUE;
        material.queueType = 1;
        dgw::EntityPtr entity = std::make_shared<dgw::SimpleEntity>(material, 0U);
        dgw::InnerMessage msg;    
        msg.msgType = dgw::InnerMsgType::INNER_MSG_F2NF;
        EXPECT_EQ(dgw::FsmStatus::FSM_SUCCESS, waitPushState.ProcessMessage(*entity, msg));
    }

    TEST_F(QueueScheduleSTest, BroadcastStrategy_SearchFail)
    {
        dgw::BroadcastStrategy bcStrategy;
        std::vector<dgw::EntityPtr> selEntityVec;
        EXPECT_EQ(dgw::FsmStatus::FSM_FAILED, bcStrategy.Search(0, 0, selEntityVec, 0));
    }

    TEST_F(QueueScheduleSTest, HashStrategy_SearchFail)
    {
        dgw::HashStrategy hashStrategy;
        std::vector<dgw::EntityPtr> selEntityVec;
        EXPECT_EQ(dgw::FsmStatus::FSM_FAILED, hashStrategy.Search(0, 0, selEntityVec, 0));
    }

    TEST_F(QueueScheduleSTest, F2NF_with_halEschedWaitEventFail)
    {
        MOCKER(halEschedWaitEvent)
            .stubs()
            .will(invoke(halEschedWaitEventErrorOrTimeOut));
        MOCKER(halEschedSubscribeEvent)
            .stubs()
            .will(returnValue(DRV_ERROR_NONE));
        MOCKER(halEschedSetGrpEventQos)
            .stubs()
            .will(returnValue(DRV_ERROR_NONE));
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
        queueSchedule.F2NFThreadTask(1U, 0U, 5U);

        controlThread.join();
        EXPECT_FALSE(queueSchedule.running_);
    }
}