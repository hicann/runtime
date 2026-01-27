/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#define private public

#include "server/statistic_manager.h"

#undef private

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "server/bind_relation.h"

namespace bqs {
    class StatisticManagerUTest : public testing::Test {
    protected:
        static void SetUpTestCase()
        {
        }

        virtual void SetUp()
        {
        }

        virtual void TearDown()
        {
            GlobalMockObject::verify();
        }

        StatisticManager instance;
    };

    TEST_F(StatisticManagerUTest, StatisticManagerUTest_TEST)
    {
        instance.StartStatisticManager(10, 10);
        instance.EventScheduleStat();
        instance.DataScheduleFailedStat();
        instance.RelationEnqueueStat();
        instance.RelationDequeueStat();
        instance.GetRelationEnqueCnt();
        instance.GetRelationDequeCnt();
        instance.F2nfEnqueueStat();
        instance.DataQueueEnqueueFailStat();
        instance.DataQueueEnqueueFullStat();
        instance.F2nfDequeueStat();
        instance.BindStat();
        instance.UnbindStat();
        instance.GetBindStat();
        instance.GetAllBindStat();
        instance.ResponseStat();
        instance.SubscribeNum(2);
        instance.BindNum(4);
        instance.PauseSubscribe();
        instance.ResumeSubscribe();
        instance.DumpStatistic();
        instance.StopStatisticManager();
        instance.AddScheduleEmpty();
        instance.HcclMpiRecvReqFalseAwakenStat();
        instance.HcclMpiRecvReqEmptySchedStat();
        instance.HcclMpiSendCompFalseAwakenStat();
        instance.HcclMpiSendCompEmptySchedStat();
        instance.HcclMpiRecvCompFalseAwakenStat();
        instance.HcclMpiRecvCompEmptySchedStat();
        instance.F2nfEventFalseAwakenStat();
        instance.HcclMpiRecvFailStat();
        instance.HcclMpiSendFailStat();
        instance.RecvReqEventSupplyStat();
        EXPECT_EQ(instance.bindNum_.load(), 4U);
        EXPECT_EQ(instance.abnormalBindNum_.load(), 0U);
        EXPECT_EQ(instance.subscribeNum_.load(), 2U);
        EXPECT_EQ(instance.pauseSubscribeNum_.load(), 0U);
    }

    TEST_F(StatisticManagerUTest, StatisticManagerUTest_StartStop_TEST)
    {
        instance.existEntityFlag_.store(true);
        instance.StartStatisticManager(10, 10, true, 1, 1);
        EXPECT_EQ(instance.abnormalInterval_, 10U);
        sleep(2);
        instance.DumpChannelStatistic();
        instance.StopStatisticManager();
    }
}
