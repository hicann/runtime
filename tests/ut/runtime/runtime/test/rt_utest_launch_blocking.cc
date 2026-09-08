/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include <memory>
#include <mockcpp/mockcpp.hpp>
#include "runtime/rts/rts_stream.h"

#define private public
#include "stream_launch_blocking.hpp"
#include "model.hpp"
#include "raw_device.hpp"
#include "runtime.hpp"
#include "stream.hpp"
#undef private

using cce::runtime::RawDevice;
using cce::runtime::Runtime;
using cce::runtime::Stream;
using cce::runtime::StreamLaunchBlocking;
using mockcpp::GlobalMockObject;
using mockcpp::invoke;
using mockcpp::returnValue;

namespace {
constexpr uint32_t TEST_DEVICE_ID = 3U;
int32_t g_synchronizeCount = 0;
rtError_t g_synchronizeResult = RT_ERROR_NONE;

rtError_t SynchronizeStub(Stream* stm, const bool isNeedWaitSyncCq, int32_t timeout)
{
    UNUSED(stm);
    UNUSED(isNeedWaitSyncCq);
    UNUSED(timeout);
    ++g_synchronizeCount;
    return g_synchronizeResult;
}
} // namespace

class LaunchBlockingTest : public testing::Test {
protected:
    void SetUp() override
    {
        g_synchronizeCount = 0;
        g_synchronizeResult = RT_ERROR_NONE;
        launchBlockingEnvEnabledBefore_ = Runtime::Instance()->launchBlockingEnvEnabled_;
        Runtime::Instance()->launchBlockingEnvEnabled_ = false;
        device_.featureSet_[static_cast<size_t>(cce::runtime::RtOptionalFeatureType::RT_FEATURE_LAUNCH_BLOCKING)] =
            true;
        stream_ = std::make_unique<Stream>(&device_, 0U);
        MOCKER_CPP_VIRTUAL(&device_, &RawDevice::GetDevRunningState)
            .stubs()
            .will(returnValue(static_cast<uint32_t>(DEV_RUNNING_DOWN)));
        MOCKER_CPP_VIRTUAL(stream_.get(), &Stream::Synchronize).stubs().will(invoke(SynchronizeStub));
    }

    void TearDown() override
    {
        Runtime::Instance()->launchBlockingEnvEnabled_ = launchBlockingEnvEnabledBefore_;
        StreamLaunchBlocking::ReleaseLaunchBlockingState(stream_.get());
        stream_.reset();
        GlobalMockObject::verify();
    }

    void SetMode(const uint32_t mode)
    {
        StreamLaunchBlocking* state = nullptr;
        ASSERT_EQ(StreamLaunchBlocking::GetLaunchBlockingState(stream_.get(), state), RT_ERROR_NONE);
        ASSERT_NE(state, nullptr);
        state->SetMode(mode);
    }

    RawDevice device_{TEST_DEVICE_ID};
    std::unique_ptr<Stream> stream_;
    bool launchBlockingEnvEnabledBefore_ = false;
};

TEST_F(LaunchBlockingTest, DisabledDoesNotSync)
{
    EXPECT_FALSE(StreamLaunchBlocking::ShouldLaunchBlock(stream_.get()));
    EXPECT_EQ(g_synchronizeCount, 0);
}

TEST_F(LaunchBlockingTest, StateIsCreatedOnlyWhenNeeded)
{
    EXPECT_EQ(stream_->launchBlockingState_.Value(), nullptr);
    EXPECT_FALSE(StreamLaunchBlocking::IsNonBlockingLaunchActive(stream_.get()));

    SetMode(RT_STREAM_LAUNCH_BLOCKING_MODE_BLOCKING);
    StreamLaunchBlocking* const state = stream_->launchBlockingState_.Value();
    ASSERT_NE(state, nullptr);
    EXPECT_EQ(state->GetMode(), RT_STREAM_LAUNCH_BLOCKING_MODE_BLOCKING);
}

TEST_F(LaunchBlockingTest, EnabledNonCaptureSyncsOnce)
{
    Runtime::Instance()->launchBlockingEnvEnabled_ = true;
    const bool shouldBlock = StreamLaunchBlocking::ShouldLaunchBlock(stream_.get());
    EXPECT_TRUE(shouldBlock);
    EXPECT_EQ(stream_->Synchronize(false), RT_ERROR_NONE);
    EXPECT_EQ(g_synchronizeCount, 1);
}

TEST_F(LaunchBlockingTest, EnabledGraphCaptureSkipsSync)
{
    Runtime::Instance()->launchBlockingEnvEnabled_ = true;
    stream_->SetCaptureStatus(RT_STREAM_CAPTURE_STATUS_ACTIVE);
    EXPECT_FALSE(StreamLaunchBlocking::ShouldLaunchBlock(stream_.get()));
    EXPECT_EQ(g_synchronizeCount, 0);
}

TEST_F(LaunchBlockingTest, EnabledModelStreamSkipsSync)
{
    Runtime::Instance()->launchBlockingEnvEnabled_ = true;
    Model model;
    stream_->SetModel(&model);

    EXPECT_FALSE(StreamLaunchBlocking::ShouldLaunchBlock(stream_.get()));
    EXPECT_EQ(g_synchronizeCount, 0);
    stream_->SetModel(nullptr);
}

TEST_F(LaunchBlockingTest, EnabledBoundStreamSkipsSync)
{
    Runtime::Instance()->launchBlockingEnvEnabled_ = true;
    stream_->SetBindFlag(true);

    EXPECT_FALSE(StreamLaunchBlocking::ShouldLaunchBlock(stream_.get()));
    EXPECT_EQ(g_synchronizeCount, 0);
    stream_->SetBindFlag(false);
}

TEST_F(LaunchBlockingTest, SpecialPurposeStreamsSkipBlocking)
{
    Runtime::Instance()->launchBlockingEnvEnabled_ = true;
    SetMode(RT_STREAM_LAUNCH_BLOCKING_MODE_BLOCKING);
    const uint32_t originalFlags = stream_->flags_;
    const uint32_t unsupportedFlags[] = {RT_STREAM_PERSISTENT, RT_STREAM_AICPU, RT_STREAM_CP_PROCESS_USE};

    for (const uint32_t flags : unsupportedFlags) {
        stream_->flags_ = flags;
        EXPECT_FALSE(StreamLaunchBlocking::ShouldLaunchBlock(stream_.get()));
    }
    stream_->flags_ = originalFlags;
    EXPECT_EQ(g_synchronizeCount, 0);
}

TEST_F(LaunchBlockingTest, RegularStreamFlagsSupportBlocking)
{
    Runtime::Instance()->launchBlockingEnvEnabled_ = true;
    const uint32_t originalFlags = stream_->flags_;
    const uint32_t supportedFlags[] = {RT_STREAM_FAST_LAUNCH, RT_STREAM_FAST_SYNC, RT_STREAM_HUGE};

    for (const uint32_t flags : supportedFlags) {
        stream_->flags_ = flags;
        EXPECT_TRUE(StreamLaunchBlocking::ShouldLaunchBlock(stream_.get()));
    }
    stream_->flags_ = originalFlags;
}

TEST_F(LaunchBlockingTest, SyncErrorPropagates)
{
    Runtime::Instance()->launchBlockingEnvEnabled_ = true;
    g_synchronizeResult = cce::runtime::RT_ERROR_STREAM_ABORT;
    EXPECT_EQ(stream_->Synchronize(false), cce::runtime::RT_ERROR_STREAM_ABORT);
    EXPECT_EQ(g_synchronizeCount, 1);
}

TEST_F(LaunchBlockingTest, AsyncModeOverridesEnabledEnvironment)
{
    Runtime::Instance()->launchBlockingEnvEnabled_ = true;
    SetMode(RT_STREAM_LAUNCH_BLOCKING_MODE_NON_BLOCKING);
    EXPECT_FALSE(StreamLaunchBlocking::ShouldLaunchBlock(stream_.get()));
}

TEST_F(LaunchBlockingTest, SyncModeOverridesDisabledEnvironment)
{
    SetMode(RT_STREAM_LAUNCH_BLOCKING_MODE_BLOCKING);
    EXPECT_TRUE(StreamLaunchBlocking::ShouldLaunchBlock(stream_.get()));
}

TEST_F(LaunchBlockingTest, UnsupportedDeviceIgnoresSyncMode)
{
    device_.featureSet_[static_cast<size_t>(cce::runtime::RtOptionalFeatureType::RT_FEATURE_LAUNCH_BLOCKING)] = false;
    SetMode(RT_STREAM_LAUNCH_BLOCKING_MODE_BLOCKING);
    EXPECT_FALSE(StreamLaunchBlocking::ShouldLaunchBlock(stream_.get()));
}

TEST_F(LaunchBlockingTest, NonBlockingSectionOverridesSyncMode)
{
    SetMode(RT_STREAM_LAUNCH_BLOCKING_MODE_BLOCKING);
    EXPECT_EQ(StreamLaunchBlocking::NonBlockingLaunchBegin(stream_.get()), RT_ERROR_NONE);
    EXPECT_FALSE(StreamLaunchBlocking::ShouldLaunchBlock(stream_.get()));

    EXPECT_EQ(StreamLaunchBlocking::NonBlockingLaunchEnd(stream_.get()), RT_ERROR_NONE);
    EXPECT_EQ(g_synchronizeCount, 1);
    EXPECT_TRUE(StreamLaunchBlocking::ShouldLaunchBlock(stream_.get()));
}
