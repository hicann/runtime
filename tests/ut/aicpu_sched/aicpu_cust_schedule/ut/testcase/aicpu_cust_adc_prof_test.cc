/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <string>
#include <list>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "profiling_adp.h"
#include "aicpu_prof.h"
#include "ascend_hal.h"
#include "tdt/status.h"
#include "tdt/tdt_server.h"
#include "task_queue.h"

using namespace aicpu;

class AICPUCustScheduleStubAdcProfTEST : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "AICPUCustScheduleStubAdcProfTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AICPUCustScheduleStubAdcProfTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AICPUCustScheduleStubAdcProfTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        std::cout << "AICPUCustScheduleStubAdcProfTEST TearDown" << std::endl;
    }
};

TEST_F(AICPUCustScheduleStubAdcProfTEST, CustIsProfOpen) {
    GetSystemTick();
    GetSystemTickFreq();
    auto ret = IsProfOpen();
    EXPECT_EQ(ret, false);

}

TEST_F(AICPUCustScheduleStubAdcProfTEST, CustSetProfHandle) {
    NowMicros();
    std::string test = "test";
    SendToProfiling(test, test);
    auto ret = SetProfHandle(nullptr);
    UpdateMode(true);
    EXPECT_EQ(ret, 0);
}

TEST_F(AICPUCustScheduleStubAdcProfTEST, CustSetMsprofReporterCallback) {
    char tag[3] = {'a', 'b', 'c'};
    ProfMessage profMsg(tag);
    InitProfiling(0, 0, 0);
    InitProfilingDataInfo(0, 0, 0);
    ReleaseProfiling();
    SetProfilingFlagForKFC(1);
    LoadProfilingLib();
    MsprofReporterCallback reportCallback = nullptr;
    auto ret = SetMsprofReporterCallback(reportCallback);
    EXPECT_EQ(ret, static_cast<int32_t>(ProfStatusCode::PROFILINE_SUCCESS));
}

TEST_F(AICPUCustScheduleStubAdcProfTEST, CustIsSupportedProfData) {
    auto ret = IsSupportedProfData();
    EXPECT_EQ(ret, false);
}

extern int SetQueueWorkMode(unsigned int devid, unsigned int qid, int mode);
extern int buff_get_phy_addr (void *buf, unsigned long long *phyAddr);
TEST_F(AICPUCustScheduleStubAdcProfTEST, CustDCStubTest) {
    int ret = SetQueueWorkMode(0, 0, 0);
    EXPECT_EQ(ret, 0);

    ret = halQueueInit(0);
    EXPECT_EQ(ret, 0);

    ret = halQueueSubscribe(0, 0, 0, 0);
    EXPECT_EQ(ret, 0);

    ret = halQueueUnsubscribe(0, 0);
    EXPECT_EQ(ret, 0);

    ret = halQueueSubF2NFEvent(0, 0, 0);
    EXPECT_EQ(ret, 0);

    ret = halQueueUnsubF2NFEvent(0, 0);
    EXPECT_EQ(ret, 0);

    ret = halQueueDeQueue(0, 0, nullptr);
    EXPECT_EQ(ret, 0);

    ret = halQueueEnQueue(0, 0, nullptr);
    EXPECT_EQ(ret, 0);

    Mbuf *mbuf = nullptr;
    ret = halMbufFree(mbuf);
    EXPECT_EQ(ret, 0);

    ret = halMbufGetPrivInfo(nullptr, nullptr, nullptr);
    EXPECT_EQ(ret, 0);

    ret = buff_get_phy_addr(nullptr, nullptr);
    EXPECT_EQ(ret, 0);

    unsigned int outLen = 0;
    ret = halGrpQuery(GRP_QUERY_GROUP, nullptr, 0, nullptr, &outLen);
    EXPECT_EQ(ret, 0);

    GroupShareAttr attrForGroup;
    ret = halGrpAddProc(nullptr, 0, attrForGroup);
    EXPECT_EQ(ret, 0);

    ret = halGrpAttach(nullptr, 0);
    EXPECT_EQ(ret, 0);

    ret = halBuffInit(nullptr);
    EXPECT_EQ(ret, 0);

    uint32_t deviceID = 0;
    std::list<uint32_t> bindCoreList = {0};
    ret = tdt::TDTServerInit(deviceID, bindCoreList);
    EXPECT_EQ(ret, 0);

    ret = tdt::TDTServerStop();
    EXPECT_EQ(ret, 0);

    DataPreprocess::TaskQueueMgr::GetInstance().OnPreprocessEvent(0U);
    UpdateModelMode(false);
    const bool openRet = IsModelProfOpen();
    EXPECT_EQ(openRet, false);
}

TEST_F(AICPUCustScheduleStubAdcProfTEST, StubGetErrDesc) {
    std::string ret = tdt::StatusFactory::GetInstance()->GetErrDesc(2);
    EXPECT_EQ(ret, "");
}

TEST_F(AICPUCustScheduleStubAdcProfTEST, StubGetErrCodeDesc) {
    std::string ret = tdt::StatusFactory::GetInstance()->GetErrCodeDesc(2);
    EXPECT_EQ(ret, "");
}
