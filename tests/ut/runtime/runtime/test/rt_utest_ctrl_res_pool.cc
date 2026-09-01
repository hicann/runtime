/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstdio>
#include <stdlib.h>

#include "driver/ascend_hal.h"
#include "runtime/rt.h"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#define protected public
#include "engine.hpp"
#include "event.hpp"
#include "ctrl_stream.hpp"
#include "scheduler.hpp"
#include "runtime.hpp"
#include "task_info.hpp"
#include "ctrl_res_pool.hpp"
#undef private
#undef protected
#include "context.hpp"
#include "securec.h"
#include "api.hpp"
#include "npu_driver.hpp"
#include "thread_local_container.hpp"
#include "raw_device.hpp"

using namespace testing;
using namespace cce::runtime;

namespace {
void InitCtrlResEntryForTest(CtrlResEntry& entry)
{
    entry.taskBuffCellSize_ = sizeof(TaskInfo);
    entry.taskPool_ = new CtrlTaskPoolEntry[CTRL_TASK_POOL_SIZE];
    entry.taskList_ = new uint8_t[CTRL_TASK_POOL_SIZE];
    entry.taskBaseAddr_ = new uint8_t[static_cast<size_t>(CTRL_TASK_POOL_SIZE) * sizeof(TaskInfo)]();
    ASSERT_NE(entry.taskPool_, nullptr);
    ASSERT_NE(entry.taskList_, nullptr);
    ASSERT_NE(entry.taskBaseAddr_, nullptr);

    for (uint32_t i = 0U; i < CTRL_TASK_POOL_SIZE; ++i) {
        entry.taskPool_[i].taskBuff_ = entry.taskBaseAddr_ + static_cast<size_t>(i) * sizeof(TaskInfo);
        entry.taskList_[i] = CTRL_TASK_INVALID;
    }
}
} // namespace

class CtrlTaskPoolEntryTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "CtrlTaskPoolEntry test start" << std::endl;
        (void)rtSetSocVersion("Ascend910B1");
        ((Runtime*)Runtime::Instance())->SetIsUserSetSocVersion(false);
        ((Runtime*)Runtime::Instance())->SetDisableThread(true);
        Runtime* rtInstance = (Runtime*)Runtime::Instance();
        rtInstance->SetChipType(CHIP_CLOUD);
        GlobalContainer::SetRtChipType(CHIP_CLOUD);
        (void)rtSetTSDevice(0);
    }
    static void TearDownTestCase()
    {
        ((Runtime*)Runtime::Instance())->SetIsUserSetSocVersion(false);
        ((Runtime*)Runtime::Instance())->SetDisableThread(false);
    }

    virtual void SetUp() { (void)rtSetDevice(0); }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
    }

public:
    static Api* oldApi_;
};

TEST_F(CtrlTaskPoolEntryTest, ErrorMessageUtilsTest)
{
    // test ErrorMessageUtils
    const std::vector<std::string> errMsgKey;
    const std::vector<std::string> errMsgValue;
    RtInnerErrcodeType rtErrCode = RT_ERROR_STREAM_SYNC_TIMEOUT;
    char_t* funcName = nullptr;

    EXPECT_NE(&errMsgKey, nullptr);
    EXPECT_NE(&errMsgValue, nullptr);
    ErrorMessageUtils::RuntimeErrorMessage(0, errMsgKey, errMsgValue);
    ErrorMessageUtils::FuncErrorReason(rtErrCode, funcName);
    ErrorMessageUtils::FuncErrorReason(RT_ERROR_TSFW_AICPU_TIMEOUT, funcName);
}

TEST_F(CtrlTaskPoolEntryTest, AllocTaskIdSuccess)
{
    CtrlResEntry entry;
    InitCtrlResEntryForTest(entry);
    entry.resHeadIndex_ = 3U;
    entry.resTailIndex_ = 0U;

    uint32_t taskId = CTRL_INVALID_TASK_ID;
    entry.AllocTaskId(taskId);

    EXPECT_EQ(taskId, 3U);
    EXPECT_EQ(entry.lastTaskId_, 3U);
    EXPECT_EQ(entry.taskList_[3U], CTRL_TASK_VALID);
    EXPECT_EQ(entry.resHeadIndex_, 4U);
    EXPECT_EQ(entry.resTailIndex_, 0U);
}

TEST_F(CtrlTaskPoolEntryTest, AllocTaskIdWhenPoolFull)
{
    CtrlResEntry entry;
    InitCtrlResEntryForTest(entry);
    entry.resHeadIndex_ = 5U;
    entry.resTailIndex_ = 6U;

    uint32_t taskId = 100U;
    entry.AllocTaskId(taskId);

    EXPECT_EQ(taskId, CTRL_INVALID_TASK_ID);
    EXPECT_EQ(entry.resHeadIndex_, 5U);
    EXPECT_EQ(entry.resTailIndex_, 6U);
    EXPECT_EQ(entry.taskList_[5U], CTRL_TASK_INVALID);
}

TEST_F(CtrlTaskPoolEntryTest, GetTaskByValidAndInvalidTaskId)
{
    CtrlResEntry entry;
    InitCtrlResEntryForTest(entry);
    constexpr uint32_t taskId = 8U;

    EXPECT_EQ(entry.GetTask(taskId), nullptr);

    entry.taskList_[taskId] = CTRL_TASK_VALID;
    TaskInfo* task = entry.GetTask(taskId);
    ASSERT_NE(task, nullptr);
    EXPECT_EQ(reinterpret_cast<uint8_t*>(task), entry.taskPool_[taskId].taskBuff_);

    entry.taskList_[taskId] = CTRL_TASK_INVALID;
    EXPECT_EQ(entry.GetTask(taskId), nullptr);
    EXPECT_EQ(entry.GetTask(CTRL_TASK_POOL_SIZE), nullptr);
}

TEST_F(CtrlTaskPoolEntryTest, RecycleTaskMoveTailForward)
{
    CtrlResEntry entry;
    InitCtrlResEntryForTest(entry);
    entry.resHeadIndex_ = 5U;
    entry.resTailIndex_ = 2U;
    entry.taskList_[2U] = CTRL_TASK_VALID;
    entry.taskList_[3U] = CTRL_TASK_INVALID;
    entry.taskList_[4U] = CTRL_TASK_VALID;

    entry.RecycleTask(2U);

    EXPECT_EQ(entry.taskList_[2U], CTRL_TASK_INVALID);
    EXPECT_EQ(entry.resTailIndex_, 4U);
    EXPECT_EQ(entry.taskList_[4U], CTRL_TASK_VALID);
}

TEST_F(CtrlTaskPoolEntryTest, RecycleTaskWithInvalidTaskId)
{
    CtrlResEntry entry;
    InitCtrlResEntryForTest(entry);
    entry.resHeadIndex_ = 1U;
    entry.resTailIndex_ = 0U;

    entry.RecycleTask(CTRL_TASK_POOL_SIZE);

    EXPECT_EQ(entry.resHeadIndex_, 1U);
    EXPECT_EQ(entry.resTailIndex_, 0U);
}

TEST_F(CtrlTaskPoolEntryTest, TearDownIsIdempotent)
{
    CtrlResEntry entry;
    InitCtrlResEntryForTest(entry);

    entry.TearDown();
    EXPECT_EQ(entry.taskPool_, nullptr);
    EXPECT_EQ(entry.taskList_, nullptr);
    EXPECT_EQ(entry.taskBaseAddr_, nullptr);
    EXPECT_EQ(entry.dev_, nullptr);

    entry.TearDown();
    EXPECT_EQ(entry.taskPool_, nullptr);
    EXPECT_EQ(entry.taskList_, nullptr);
    EXPECT_EQ(entry.taskBaseAddr_, nullptr);
    EXPECT_EQ(entry.dev_, nullptr);
}
