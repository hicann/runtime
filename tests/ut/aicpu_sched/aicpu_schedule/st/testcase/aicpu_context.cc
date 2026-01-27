/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "aicpu_context.h"
#include "aicpusd_context.h"
#include "gtest/gtest.h"
#include <cstdint>
#include <stdio.h>
#include <stdlib.h>
#include <queue>
#include <exception>
#include <string>
#include <functional>

using namespace aicpu;
using namespace std;

class AiCPUContextSt : public ::testing::Test {
public:
    virtual void SetUp()
    {}

    virtual void TearDown()
    {}
};

TEST_F(AiCPUContextSt, AiCPUContextStSuccess)
{
    SetTaskAndStreamId(0, 0);
    uint64_t taskId = 0xFFFF;
    uint32_t streamId = 0xFFFF;
    GetTaskAndStreamId(taskId, streamId);
    EXPECT_EQ(taskId, 0);
    EXPECT_EQ(streamId, 0);

    for (uint32_t chlLoop = AICPU_DVPP_CHL_VPC; chlLoop < AICPU_DVPP_CHL_BUTT; chlLoop++) {
        AicpuDvppChlType chlType = AicpuDvppChlType(chlLoop);
        int32_t chlId = GetStreamDvppChannelId(0, chlType);
        EXPECT_EQ(chlId, -1);
        chlId = GetStreamDvppChannelId(1, chlType);
        EXPECT_EQ(chlId, -1);
        chlId = GetCurTaskDvppChannelId(chlType);
        EXPECT_EQ(chlId, -1);
        chlId = InitStreamDvppChannel(0, chlType, 1);
        EXPECT_EQ(chlId, 1);
        chlId = GetCurTaskDvppChannelId(chlType);
        EXPECT_EQ(chlId, 1);
        chlId = InitStreamDvppChannel(0, chlType, 2);
        EXPECT_EQ(chlId, 1);
        chlId = GetStreamDvppChannelId(0, chlType);
        EXPECT_EQ(chlId, 1);
        chlId = UnInitStreamDvppChannel(0, chlType);
        EXPECT_EQ(chlId, 1);
        chlId = GetCurTaskDvppChannelId(chlType);
        EXPECT_EQ(chlId, -1);
        chlId = GetStreamDvppChannelId(0, chlType);
        EXPECT_EQ(chlId, -1);
        chlId = InitStreamDvppChannel(0, chlType, 2);
        EXPECT_EQ(chlId, 2);
        chlId = GetCurTaskDvppChannelId(chlType);
        EXPECT_EQ(chlId, 2);
        chlId = GetStreamDvppChannelId(0, chlType);
        EXPECT_EQ(chlId, 2);
        chlId = UnInitStreamDvppChannel(0, chlType);
        EXPECT_EQ(chlId, 2);
        chlId = GetCurTaskDvppChannelId(chlType);
        EXPECT_EQ(chlId, -1);
        chlId = GetStreamDvppChannelId(0, chlType);
        EXPECT_EQ(chlId, -1);
        InitStreamDvppChannel(0, AICPU_DVPP_CHL_VPC, 2);
        uint8_t *buff = reinterpret_cast<uint8_t *>(0xf00400000040);
        SetStreamDvppBuffBychlType(AICPU_DVPP_CHL_VPC, 16 * 1024 * 1024, buff);
        SetStreamDvppBuffByStreamId(AICPU_DVPP_CHL_VPC, 0, 16 * 1024 * 1024, buff);
        uint8_t *outBuff = nullptr;
        uint64_t outLen = 0;
        GetDvppBufAndLenBychlType(AICPU_DVPP_CHL_VPC, &outBuff, &outLen);
        EXPECT_EQ(outLen, 16 * 1024 * 1024);
        GetDvppBufAndLenByStreamId(0, AICPU_DVPP_CHL_VPC, &outBuff);
        EXPECT_EQ(outBuff, reinterpret_cast<uint8_t *>(0xf00400000040));
    }
}
TEST_F(AiCPUContextSt, AiCPUContextStFail)
{
    SetTaskAndStreamId(0, 0);
    uint64_t taskId = 0xFFFF;
    uint32_t streamId = 0xFFFF;
    GetTaskAndStreamId(taskId, streamId);
    EXPECT_EQ(taskId, 0);
    EXPECT_EQ(streamId, 0);

    InitStreamDvppChannel(0, AICPU_DVPP_CHL_BUTT, 2);
    uint8_t *buff = reinterpret_cast<uint8_t *>(0xf00400000040);
    SetStreamDvppBuffBychlType(AICPU_DVPP_CHL_BUTT, 16 * 1024 * 1024, buff);
    SetStreamDvppBuffByStreamId(AICPU_DVPP_CHL_BUTT, 0, 16 * 1024 * 1024, buff);
    uint8_t *outBuff = nullptr;
    uint64_t outLen = 0;
    GetDvppBufAndLenBychlType(AICPU_DVPP_CHL_BUTT, &outBuff, &outLen);
    GetDvppBufAndLenByStreamId(0, AICPU_DVPP_CHL_BUTT, &outBuff);
}
TEST_F(AiCPUContextSt, SetBlockIdxAndBlockNum)
{
    auto ret = SetBlockIdxAndBlockNum(1, 2);
    EXPECT_EQ(ret, 0);
    uint32_t blockIdx = GetBlockIdx();
    EXPECT_EQ(blockIdx, 1);
    uint32_t blockNum = GetBlockNum();
    EXPECT_EQ(blockNum, 2);
}

TEST_F(AiCPUContextSt, SetAicpuBlockIdxAndBlockNum)
{
    auto ret = SetBlockIdxAndBlockNum(1, 2);
    EXPECT_EQ(ret, 0);
    uint32_t blockIdx = AicpuGetBlockIdx();
    EXPECT_EQ(blockIdx, 1);
    uint32_t blockNum = AicpuGetBlockNum();
    EXPECT_EQ(blockNum, 2);
}

TEST_F(AiCPUContextSt, SetAicpuStreamIdAndTaskId)
{
    SetTaskAndStreamId(0, 0);
    uint32_t taskId = AicpuGetTaskId();
    EXPECT_EQ(taskId, 0);
    uint32_t streamId = AicpuGetStreamId();
    EXPECT_EQ(streamId, 0);
}