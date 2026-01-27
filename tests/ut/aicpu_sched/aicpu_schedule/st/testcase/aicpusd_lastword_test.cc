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
#include <vector>
#include "core/aicpusd_resource_manager.h"
#include "core/aicpusd_drv_manager.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "ascend_hal.h"
#include "profiling_adp.h"
#include "tsd.h"
#define private public
#include "aicpusd_info.h"
#include "aicpusd_interface.h"
#include "aicpusd_lastword.h"
#undef private

using namespace AicpuSchedule;
using namespace aicpu;

namespace AicpuSchedule {
class AicpuLastwordSTest : public testing::Test {
protected:
    static void SetUpTestCase() {}

    virtual void SetUp() {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};


TEST_F(AicpuLastwordSTest, RegLastwordCallbackTest) {
    uint64_t times = 0;
    auto TestLastword = [&times]() {
        times++;
    };
    std::function<void()> cancelReg;
    AicpusdLastword lastword;
    lastword.RegLastwordCallback("test", TestLastword, cancelReg);
    EXPECT_TRUE(cancelReg != nullptr);
    lastword.LastwordCallback();
    EXPECT_EQ(times, 1);
    lastword.LastwordCallback();
    EXPECT_EQ(times, 2);
    cancelReg();
    lastword.LastwordCallback();
    EXPECT_EQ(times, 2);

    lastword.RegLastwordCallback("test", nullptr, cancelReg);
}

TEST_F(AicpuLastwordSTest, RegLastwordCallbackTest_api) {
    uint64_t times = 0;
    auto TestLastword = [&times]() {
        times++;
    };
    std::function<void()> cancelReg;
    RegLastwordCallback("test", TestLastword, cancelReg);
    EXPECT_TRUE(cancelReg != nullptr);
    cancelReg();
}
}
