/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <list>
#include <dlfcn.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "ascend_hal.h"
#include "tdt/status.h"
#include "tdt_server.h"
#include "tdt/tdt_device.h"
#include "tdt/train_mode.h"
#define private public
#include "task_queue.h"
#undef private

class AICPUScheduleStubTEST : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "AICPUScheduleStubTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AICPUScheduleStubTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AICPUScheduleStubTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        std::cout << "AICPUScheduleStubTEST TearDown" << std::endl;
    }
};

TEST_F(AICPUScheduleStubTEST, stubTest) {
    DataPreprocess::TaskQueueMgr::GetInstance();
    DataPreprocess::TaskQueueMgr::GetInstance().OnPreprocessEvent(0U);
    EXPECT_EQ(DataPreprocess::TaskQueueMgr::GetInstance().cancelLastword_, nullptr);
}
 
TEST_F(AICPUScheduleStubTEST, TDTServerInit) {
    uint32_t deviceID = 0;
    std::list<uint32_t> bindCoreList = {0};
    int32_t ret = tdt::TDTServerInit(deviceID, bindCoreList);
    EXPECT_EQ(ret, 0);
}
 
TEST_F(AICPUScheduleStubTEST, TDTServerStop) {
    int32_t ret = tdt::TDTServerStop();
    EXPECT_EQ(ret, 0);
}
 
TEST_F(AICPUScheduleStubTEST, GetErrDesc) {
    std::string ret = tdt::StatusFactory::GetInstance()->GetErrDesc(2);
    EXPECT_EQ(ret, "");
}
 
TEST_F(AICPUScheduleStubTEST, GetErrCodeDesc) {
    std::string ret = tdt::StatusFactory::GetInstance()->GetErrCodeDesc(2);
    EXPECT_EQ(ret, "");
}

TEST_F(AICPUScheduleStubTEST, TdtDevicePushData) {
    SetTrainMode(MEFLAG);
    const std::string channelName = "test";
    std::vector<tdt::DataItem> items;
    int32_t ret = tdt::TdtDevicePushData(channelName, items);
    EXPECT_EQ(ret, 1);
}
