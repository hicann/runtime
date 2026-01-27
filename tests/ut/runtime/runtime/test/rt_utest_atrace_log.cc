/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <sys/time.h>
#include <cstdio>
#include <stdlib.h>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "driver/ascend_hal.h"
#include "securec.h"
#include "runtime/rt.h"
#define private public
#include "runtime.hpp"
#include "api.hpp"
#include "context.hpp"
#include "device.hpp"
#include "engine.hpp"
#include "task_info.hpp"
#include "label.hpp"
#include "npu_driver.hpp"
#include "model.hpp"
#include "task_res.hpp"
#undef private

using namespace testing;
using namespace cce::runtime;
class AtraceLog : public testing::Test {
protected:
    static void SetUpTestCase()
    {}

    static void TearDownTestCase()
    {}

    virtual void SetUp()
    {}

    virtual void TearDown()
    {}
};

TEST_F(AtraceLog, TrySaveAtraceLogsFailed)
{
    TraEventHandle handle{0};
    MOCKER(AtraceEventReportSync).stubs().will(returnValue(TRACE_FAILURE));
    TrySaveAtraceLogs(handle);
    EXPECT_EQ(handle, 0);
}