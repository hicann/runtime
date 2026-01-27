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
#include "task_queue.h"
#include "tdt/status.h"
#include "tdt_server.h"

class AICPUScheduleStubHelper710TEST : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "AICPUScheduleStubHelper710TEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AICPUScheduleStubHelper710TEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AICPUScheduleStubHelper710TEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        std::cout << "AICPUScheduleStubHelper710TEST TearDown" << std::endl;
    }
};

TEST_F(AICPUScheduleStubHelper710TEST, stubTest) {
    DataPreprocess::TaskQueueMgr::GetInstance().OnPreprocessEvent(0);
    std::list<uint32_t> list = {0};
    tdt::StatusFactory::GetInstance()->RegisterErrorNo(0, "helper710");
    tdt::StatusFactory::GetInstance()->GetErrDesc(0);
    auto ret = tdt::StatusFactory::GetInstance()->GetErrCodeDesc(0);
    EXPECT_STREQ(ret.c_str(), "");
}

 
TEST_F(AICPUScheduleStubHelper710TEST, TDTServerInit) {
    std::list<uint32_t> a = {0};
    int32_t ret = tdt::TDTServerInit(0, a);
    EXPECT_EQ(ret, 0);
}
 
TEST_F(AICPUScheduleStubHelper710TEST, TDTServerStop) {
    int32_t ret = tdt::TDTServerStop();
    EXPECT_EQ(ret, 0);
}
