/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#define protected public
#include "task_info.h"
#include "task_manager.h"
#include "task_manager_xpu.hpp"
#undef protected
#undef private

using namespace cce::runtime;

class TaskProcFuncRegisterXpuTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(TaskProcFuncRegisterXpuTest, RegTaskFunc_Success)
{
    // RegTaskFunc just calls TaskFuncReg() and RegXpuTaskFunc()
    // In UT environment, these may be stubbed or mocked
    // This test verifies the function can be called without crash
    EXPECT_NO_THROW(RegTaskFunc());
}
