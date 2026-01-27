/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <dlfcn.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "ascend_hal.h"
#include "aicpu_async_event.h"

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
    Mbuf *mbuf = nullptr;
    halMbufChainGetMbuf(mbuf, 0, &mbuf);
    unsigned int num;
    halMbufChainGetMbufNum(mbuf, &num);
    halMbufChainAppend(mbuf, mbuf);
    halQueueInit(0);
    halMbufSetDataLen(mbuf, 0);
    EXPECT_EQ(halMbufAllocEx(0,0,0,0,&mbuf), 0);
}

