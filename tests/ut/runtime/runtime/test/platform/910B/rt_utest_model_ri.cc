/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <array>
#include <cstdlib>
#include <vector>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "runtime/rt.h"
#include "runtime/rt_inner_model.h"
#include "runtime/rts/rts_kernel.h"
#include "runtime/rt_inner_task.h"
#define private public
#define protected public
#include "runtime.hpp"
#include "context.hpp"
#include "model.hpp"
#include "stream.hpp"
#include "task.hpp"
#include "task_info.hpp"
#include "api_impl.hpp"
#include "dev_info_manage.h"
#undef protected
#undef private
#include "rt_unwrap.h"
#include "../../common/rt_utest_context_reset_helper.hpp"

using namespace testing;
using namespace cce::runtime;

class ModelRIGetTasksTest : public testing::Test {
protected:
    void SetUp() override
    {
        ASSERT_EQ(rtSetDevice(0), RT_ERROR_NONE);
        ASSERT_EQ(rtCtxGetCurrent(&originalContext_), RT_ERROR_NONE);
        ASSERT_EQ(rtModelCreate(&model_, 0U), RT_ERROR_NONE);
        mdl_ = rt_ut::UnwrapOrNull<Model>(model_);
        ASSERT_NE(mdl_, nullptr);
    }

    void TearDown() override
    {
        GlobalMockObject::verify();
        GlobalMockObject::reset();
        if (otherContext_ != nullptr) {
            EXPECT_EQ(rtCtxSetCurrent(originalContext_), RT_ERROR_NONE);
            EXPECT_EQ(rtCtxDestroy(otherContext_), RT_ERROR_NONE);
            EXPECT_EQ(rtCtxSetCurrent(originalContext_), RT_ERROR_NONE);
        }
        // Synthetic task lists belong only to this UT; never recycle stack TaskInfo objects.
        if (mdl_ != nullptr) {
            mdl_->streams_.clear();
        }
        for (auto stream : streams_) {
            Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);
            stm->delayRecycleTaskid_.clear();
        }
        for (auto stream : streams_) {
            EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
        }
        if (model_ != nullptr) {
            EXPECT_EQ(rtModelDestroy(model_), RT_ERROR_NONE);
        }
        ut::ForceResetPrimaryDeviceIfActive();
    }

    rtError_t PrepareModelWithTasks(const std::vector<uint32_t>& layout)
    {
        size_t index = 0U;
        for (const auto count : layout) {
            if (count > taskInfos_.size() - index) {
                return RT_ERROR_INVALID_VALUE;
            }
            rtStream_t stream = nullptr;
            const rtError_t error = rtStreamCreate(&stream, 0);
            if (error != RT_ERROR_NONE) {
                return error;
            }
            streams_.push_back(stream);
            Stream* stm = rt_ut::UnwrapOrNull<Stream>(stream);
            mdl_->streams_.push_back(stm);
            for (uint32_t i = 0U; i < count; ++i) {
                // Reuse IDs across streams to detect accidental taskId-only lookups.
                const uint16_t id = static_cast<uint16_t>(i + 1U);
                stm->delayRecycleTaskid_.push_back(id);
                TaskInfo& task = taskInfos_[index++];
                task.stream = stm;
                task.id = id;
                task.type = TS_TASK_TYPE_KERNEL_AICORE;
                task.taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_USER);
                expected_.push_back(&task);
            }
        }
        return RT_ERROR_NONE;
    }

    void MockTaskLookup(const int failedIndex = -1)
    {
        for (size_t i = 0U; i < expected_.size(); ++i) {
            TaskInfo* task = static_cast<TaskInfo*>(expected_[i]);
            TaskInfo* result = (static_cast<int>(i) == failedIndex) ? nullptr : task;
            MOCKER_CPP(&TaskFactory::GetTask)
                .stubs()
                .with(eq(task->stream->Id_()), eq(task->id))
                .will(returnValue(result));
        }
    }

    rtModel_t model_ = nullptr;
    rtContext_t originalContext_ = nullptr;
    rtContext_t otherContext_ = nullptr;
    Model* mdl_ = nullptr;
    std::vector<rtStream_t> streams_;
    std::array<TaskInfo, 8U> taskInfos_{};
    std::vector<rtTask_t> expected_;
};

TEST_F(ModelRIGetTasksTest, stream_get_tasks_filters_inner_tasks)
{
    ASSERT_EQ(PrepareModelWithTasks({3U}), RT_ERROR_NONE);
    Stream* const stream = taskInfos_[0].stream;
    for (const size_t index : {0U, 2U}) {
        taskInfos_[index].taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_INNER);
    }
    taskInfos_[1].type = TS_TASK_TYPE_KERNEL_AICPU;
    MockTaskLookup();
    uint32_t count = 0U;
    ASSERT_EQ(stream->StreamGetTasks(nullptr, &count), RT_ERROR_NONE);
    EXPECT_EQ(count, 1U);
    rtTask_t tasks[2] = {expected_[0], expected_[2]};
    count = 2U;
    ASSERT_EQ(stream->StreamGetTasks(tasks, &count), RT_ERROR_NONE);
    EXPECT_EQ(count, 1U);
    EXPECT_EQ(tasks[0], expected_[1]);
    EXPECT_EQ(tasks[1], nullptr);
    count = 0U;
    EXPECT_EQ(stream->StreamGetTasks(tasks, &count), RT_ERROR_INSUFFICIENT_INPUT_ARRAY);
    taskInfos_[1].taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_INNER);
    count = 2U;
    ASSERT_EQ(stream->StreamGetTasks(tasks, &count), RT_ERROR_NONE);
    EXPECT_EQ(count, 0U);
    EXPECT_EQ(tasks[0], nullptr);
}

TEST_F(ModelRIGetTasksTest, model_get_tasks_normal)
{
    ASSERT_EQ(PrepareModelWithTasks({2U, 3U}), RT_ERROR_NONE);
    // A disabled task remains in the list; never modify the list between queries.
    taskInfos_[0].updateFlag = static_cast<uint8_t>(TaskUpdateFlag::RT_TASK_DISABLE);
    MockTaskLookup();
    uint32_t count = 0U;
    ASSERT_EQ(rtModelGetTasks(model_, nullptr, &count), RT_ERROR_NONE);
    ASSERT_EQ(count, 5U);
    std::vector<rtTask_t> tasks(count);
    count = static_cast<uint32_t>(tasks.size());
    ASSERT_EQ(rtModelGetTasks(model_, tasks.data(), &count), RT_ERROR_NONE);
    EXPECT_EQ(count, 5U);
    EXPECT_EQ(tasks, expected_);
    EXPECT_NE(tasks[0], tasks[2]); // Task ID 1 belongs to two different streams.

    // Repeat the two-phase query once to check that enumeration preserves the model.
    count = 0U;
    ASSERT_EQ(rtModelGetTasks(model_, nullptr, &count), RT_ERROR_NONE);
    ASSERT_EQ(count, 5U);
    tasks.assign(count, nullptr);
    count = static_cast<uint32_t>(tasks.size());
    ASSERT_EQ(rtModelGetTasks(model_, tasks.data(), &count), RT_ERROR_NONE);
    EXPECT_EQ(count, 5U);
    EXPECT_EQ(tasks, expected_);
}

TEST_F(ModelRIGetTasksTest, model_get_tasks_abnormal)
{
    ASSERT_EQ(PrepareModelWithTasks({2U, 3U}), RT_ERROR_NONE);
    MOCKER_CPP(&TaskFactory::GetTask).expects(never());
    uint32_t count = 0U;
    EXPECT_EQ(rtModelGetTasks(nullptr, nullptr, &count), ACL_ERROR_RT_PARAM_INVALID);
    std::vector<rtTask_t> tasks(4U, expected_.front());
    EXPECT_EQ(rtModelGetTasks(model_, tasks.data(), nullptr), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(tasks, std::vector<rtTask_t>(4U, expected_.front()));
}

// STC custom_gettasks_3: construct the empty model list only in UT.
TEST_F(ModelRIGetTasksTest, custom_gettasks_3)
{
    MOCKER_CPP(&TaskFactory::GetTask).expects(never());
    uint32_t count = 0U;
    ASSERT_EQ(rtModelGetTasks(model_, nullptr, &count), RT_ERROR_NONE);
    EXPECT_EQ(count, 0U);
    rtTask_t tasks[3] = {model_, model_, model_};
    count = 3U;
    ASSERT_EQ(rtModelGetTasks(model_, tasks, &count), RT_ERROR_NONE);
    EXPECT_EQ(count, 0U);
    for (auto task : tasks) {
        EXPECT_EQ(task, nullptr);
    }
}

// STC custom_gettasks_4: no business submissions does not imply empty device task lists.
TEST_F(ModelRIGetTasksTest, custom_gettasks_4)
{
    ASSERT_EQ(PrepareModelWithTasks({0U, 0U}), RT_ERROR_NONE);
    MOCKER_CPP(&TaskFactory::GetTask).expects(never());
    uint32_t count = 0U;
    ASSERT_EQ(rtModelGetTasks(model_, nullptr, &count), RT_ERROR_NONE);
    EXPECT_EQ(count, 0U);
    rtTask_t tasks[3] = {model_, model_, model_};
    count = 3U;
    ASSERT_EQ(rtModelGetTasks(model_, tasks, &count), RT_ERROR_NONE);
    EXPECT_EQ(count, 0U);
    for (auto task : tasks) {
        EXPECT_EQ(task, nullptr);
    }
}

TEST_F(ModelRIGetTasksTest, model_get_tasks_capacity_less)
{
    ASSERT_EQ(PrepareModelWithTasks({2U, 3U}), RT_ERROR_NONE);
    MockTaskLookup();
    std::vector<rtTask_t> tasks(5U, model_);
    uint32_t count = 4U;
    EXPECT_EQ(rtModelGetTasks(model_, tasks.data(), &count), ACL_ERROR_RT_INSUFFICIENT_INPUT_ARRAY);
    EXPECT_EQ(count, 4U);
    EXPECT_EQ(
        std::vector<rtTask_t>(tasks.begin(), tasks.begin() + 4),
        std::vector<rtTask_t>(expected_.begin(), expected_.begin() + 4));
    EXPECT_EQ(tasks[4], model_);

    // Recover from insufficient capacity without adding or removing model tasks.
    count = 0U;
    ASSERT_EQ(rtModelGetTasks(model_, nullptr, &count), RT_ERROR_NONE);
    ASSERT_EQ(count, 5U);
    tasks.resize(count);
    count = static_cast<uint32_t>(tasks.size());
    ASSERT_EQ(rtModelGetTasks(model_, tasks.data(), &count), RT_ERROR_NONE);
    EXPECT_EQ(count, 5U);
    EXPECT_EQ(tasks, expected_);
}

TEST_F(ModelRIGetTasksTest, model_get_tasks_capacity_zero)
{
    ASSERT_EQ(PrepareModelWithTasks({2U, 3U}), RT_ERROR_NONE);
    MockTaskLookup();
    rtTask_t task = model_;
    uint32_t count = 0U;
    EXPECT_EQ(rtModelGetTasks(model_, &task, &count), ACL_ERROR_RT_INSUFFICIENT_INPUT_ARRAY);
    EXPECT_EQ(count, 0U);
    EXPECT_EQ(task, model_);
}

TEST_F(ModelRIGetTasksTest, model_get_tasks_capacity_larger)
{
    ASSERT_EQ(PrepareModelWithTasks({2U, 3U}), RT_ERROR_NONE);
    MockTaskLookup();
    std::vector<rtTask_t> tasks(9U, model_);
    uint32_t count = 8U;
    ASSERT_EQ(rtModelGetTasks(model_, tasks.data(), &count), RT_ERROR_NONE);
    EXPECT_EQ(count, 5U);
    for (size_t i = 0U; i < 8U; ++i) {
        EXPECT_EQ(tasks[i], i < 5U ? expected_[i] : nullptr);
    }
    EXPECT_EQ(tasks[8], model_);
}

TEST_F(ModelRIGetTasksTest, model_get_tasks_factory_lookup_failed)
{
    ASSERT_EQ(PrepareModelWithTasks({2U, 3U}), RT_ERROR_NONE);
    MockTaskLookup(2);
    std::vector<rtTask_t> tasks(8U, model_);
    uint32_t count = 8U;
    EXPECT_EQ(rtModelGetTasks(model_, tasks.data(), &count), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(count, 8U); // ByStream preserves the input count on a factory lookup error.
    // Task pointers are validated before writing any output elements.
    EXPECT_EQ(tasks, std::vector<rtTask_t>(8U, model_));
    count = 1U;
    EXPECT_EQ(rtModelGetTasks(model_, tasks.data(), &count), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(count, 1U);
    EXPECT_EQ(tasks, std::vector<rtTask_t>(8U, model_));
    count = 0U;
    EXPECT_EQ(rtModelGetTasks(model_, nullptr, &count), ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(count, 0U);
    EXPECT_EQ(taskInfos_[2].stream->StreamGetTasks(nullptr, &count), RT_ERROR_INVALID_VALUE);
}

TEST_F(ModelRIGetTasksTest, model_get_tasks_context_null)
{
    MOCKER_CPP(&ApiImpl::CurrentContext).stubs().will(returnValue(static_cast<Context*>(nullptr)));
    uint32_t count = 0U;
    EXPECT_EQ(rtModelGetTasks(model_, nullptr, &count), ACL_ERROR_RT_CONTEXT_NULL);
}

TEST_F(ModelRIGetTasksTest, model_get_tasks_context_mismatch)
{
    ASSERT_EQ(rtCtxCreate(&otherContext_, 0U, 0), RT_ERROR_NONE);
    ASSERT_EQ(rtCtxSetCurrent(otherContext_), RT_ERROR_NONE);
    uint32_t count = 0U;
    EXPECT_EQ(rtModelGetTasks(model_, nullptr, &count), ACL_ERROR_RT_MODEL_CONTEXT);
}

TEST_F(ModelRIGetTasksTest, model_get_tasks_filters_inner_tasks)
{
    ASSERT_EQ(PrepareModelWithTasks({3U, 3U}), RT_ERROR_NONE);
    for (const size_t index : {0U, 2U, 3U, 5U}) {
        taskInfos_[index].taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_INNER);
    }
    // 用户 DEFAULT 类型和 AddStream 的 Notify 不能仅因类型而被过滤。
    taskInfos_[1].type = TS_TASK_TYPE_KERNEL_AICPU;
    taskInfos_[4].type = TS_TASK_TYPE_NOTIFY_RECORD;
    MockTaskLookup();
    uint32_t count = 0U;
    ASSERT_EQ(rtModelGetTasks(model_, nullptr, &count), RT_ERROR_NONE);
    EXPECT_EQ(count, 2U);
    rtTask_t tasks[4] = {model_, model_, model_, model_};
    count = 1U;
    EXPECT_EQ(rtModelGetTasks(model_, tasks, &count), ACL_ERROR_RT_INSUFFICIENT_INPUT_ARRAY);
    EXPECT_EQ(count, 1U);
    EXPECT_EQ(tasks[0], expected_[1]);
    EXPECT_EQ(tasks[1], model_);
    count = 3U;
    ASSERT_EQ(rtModelGetTasks(model_, tasks, &count), RT_ERROR_NONE);
    EXPECT_EQ(count, 2U);
    EXPECT_EQ(tasks[0], expected_[1]);
    EXPECT_EQ(tasks[1], expected_[4]);
    EXPECT_EQ(tasks[2], nullptr);
    EXPECT_EQ(tasks[3], model_);
    taskInfos_[1].taskOwner = taskInfos_[4].taskOwner = static_cast<uint8_t>(TaskOwner::RT_TASK_INNER);
    count = 0U;
    ASSERT_EQ(rtModelGetTasks(model_, nullptr, &count), RT_ERROR_NONE);
    EXPECT_EQ(count, 0U);
    count = 3U;
    ASSERT_EQ(rtModelGetTasks(model_, tasks, &count), RT_ERROR_NONE);
    EXPECT_EQ(count, 0U);
    EXPECT_EQ(tasks[0], nullptr);
    EXPECT_EQ(tasks[1], nullptr);
    EXPECT_EQ(tasks[2], nullptr);
    EXPECT_EQ(tasks[3], model_);
}

// A re-executed process prevents earlier tests from pre-initializing the C API's static feature cache.
TEST(ModelRIGetTasksFeatureTest, model_get_tasks_feature_not_supported)
{
    const std::string originalStyle = ::testing::GTEST_FLAG(death_test_style);
    ::testing::GTEST_FLAG(death_test_style) = "threadsafe";
    EXPECT_EXIT(
        {
            if (Runtime::Instance() == nullptr) {
                std::_Exit(2);
            }
            MOCKER_CPP(&DevInfoManage::IsSupportChipFeature).stubs().will(returnValue(false));
            uint32_t count = 0U;
            const rtError_t result = rtModelGetTasks(nullptr, nullptr, &count);
            GlobalMockObject::verify();
            GlobalMockObject::reset();
            std::_Exit(result == ACL_ERROR_RT_FEATURE_NOT_SUPPORT ? 0 : 1);
        },
        ::testing::ExitedWithCode(0), "");
    ::testing::GTEST_FLAG(death_test_style) = originalStyle;
}
