/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include <fstream>
#include <functional>

#include "mockcpp/mockcpp.hpp"
#include "thread.h"
#include "mmpa_stub.h"

using namespace Adx;

// mmpa 桩全局标志 g_mmCreateTaskWitchDeatchFlag 由 mmpa_stub.h 声明：
// 置 2 使 mmCreateTaskWithDetach 返回 -1
namespace {
void *ThreadEntry(void *arg)
{
    return arg;
}
}

class TinyThreadWithoutAttrUtest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        g_mmCreateTaskWitchDeatchFlag = 0;
        GlobalMockObject::verify();
    }
};

TEST_F(TinyThreadWithoutAttrUtest, Test_CreateTask_Success)
{
    mmUserBlock_t funcBlock{};
    funcBlock.procFunc = ThreadEntry;
    funcBlock.pulArg = this;
    mmThread tid = 0;
    EXPECT_EQ(Thread::CreateTask(tid, funcBlock), 0);
    EXPECT_EQ(Thread::CreateDetachTask(tid, funcBlock), 0);
}

TEST_F(TinyThreadWithoutAttrUtest, Test_CreateDetachTask_Failed)
{
    mmUserBlock_t funcBlock{};
    funcBlock.procFunc = ThreadEntry;
    funcBlock.pulArg = this;
    mmThread tid = 0;
    g_mmCreateTaskWitchDeatchFlag = 2;
    EXPECT_EQ(Thread::CreateDetachTask(tid, funcBlock), -1);
}
