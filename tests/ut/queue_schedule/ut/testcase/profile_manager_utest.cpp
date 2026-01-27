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
#include "mockcpp/ChainingMockHelper.h"

#define private public
#define protected public
#include "profile_manager.h"
#undef private
#undef protected

using namespace std;
using namespace bqs;

class BQS_PROFILE_MANAGER_UTest : public testing::Test, public ProfileManager {
protected:
    virtual void SetUp()
    {
        cout << "Before bqs_profile_manager_utest" << endl;
        profile_.UpdateProfilingMode(ProfilingMode::PROFILING_OPEN);
    }

    virtual void TearDown()
    {
        cout << "After bqs_profile_manager_utest" << endl;
        profile_.UpdateProfilingMode(ProfilingMode::PROFILING_CLOSE);
        GlobalMockObject::verify();
    }

public:
    ProfileManager profile_;
};

TEST_F(BQS_PROFILE_MANAGER_UTest, Test)
{
    profile_.InitProfileManager(0);
    profile_.InitMaker(1, 1);
    profile_.SetSrcQueueNum(1);
    profile_.AddCopyTotalCost(1);
    profile_.AddMbufFreeCost(1);
    profile_.SetRelationCost(1);
    profile_.Setf2NFCost(1);
    profile_.TryMarker(1);
    EXPECT_EQ(profile_.GetProfilingMode(), ProfilingMode::PROFILING_OPEN);
}

TEST_F(BQS_PROFILE_MANAGER_UTest, TryMarkerTest)
{
    profile_.logThresholdTick_ = 10;
    profile_.InitMaker(1, 1);
    profile_.enqueEventTrack_.totalCost = 40;
    profile_.TryMarker(1);
    EXPECT_EQ(profile_.GetProfilingMode(), ProfilingMode::PROFILING_OPEN);
}

TEST_F(BQS_PROFILE_MANAGER_UTest, DoMarkerForHcclEvent)
{
    profile_.recvReqEventTrack_.hcclImprobeNum = 1;
    profile_.DoMarkerForRecvReqEvent(0);
    profile_.DoMarkerForRecvCompEvent(0);
    profile_.DoMarkerForSendCompEvent(0);
    EXPECT_EQ(profile_.GetProfilingMode(), ProfilingMode::PROFILING_OPEN);
}