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
#include "ascend_hal.h"
#include "type_def.h"
#include "aicpusd_status.h"
#define private public
#include "aicpusd_message_queue.h"
#undef private

using namespace AicpuSchedule;

class AicpusdMessageQueueTest : public testing::Test {
protected:
    virtual void SetUp() {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};


namespace {
uint32_t g_starsRegister[33] = {};

drvError_t halResAddrMapFake(unsigned int devId, struct res_addr_info *res_info, unsigned long *va, unsigned int *len)
{
    *va = reinterpret_cast<uint64_t>(g_starsRegister);
    *len = sizeof(uint32_t) / sizeof(uint8_t);
    return DRV_ERROR_NONE;
}
}


TEST_F(AicpusdMessageQueueTest, InitMessageQueueSuccess)
{
    MessageQueue::GetInstance();
    MessageQueue inst;

    const uint32_t deviceId = 1;
    const std::vector<uint32_t> aicpuPhyIds = {1,2,3,4};
    MOCKER(halResAddrMap).stubs().will(invoke(halResAddrMapFake));
    const int32_t ret = inst.InitMessageQueue(deviceId, aicpuPhyIds);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdMessageQueueTest, InitMessageQueueGetAddrFail)
{
    MessageQueue inst;

    const uint32_t deviceId = 1;
    const std::vector<uint32_t> aicpuPhyIds = {1,2,3,4};
    MOCKER(halResAddrMap).stubs().will(returnValue(DRV_ERROR_BAD_ADDRESS));
    const int32_t ret = inst.InitMessageQueue(deviceId, aicpuPhyIds);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AicpusdMessageQueueTest, InitMessageQueueGetCqeFail)
{
    MessageQueue inst;

    const uint32_t deviceId = 1;
    const std::vector<uint32_t> aicpuPhyIds = {1,2,3,4};
    MOCKER(halResAddrMap).stubs().will(returnValue(DRV_ERROR_BAD_ADDRESS));
    const int32_t ret = inst.InitMessageQueue(deviceId, aicpuPhyIds);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AicpusdMessageQueueTest, InitMessageQueueForThreadSuccess)
{
    MessageQueue inst;

    const uint32_t deviceId = 1;
    const std::vector<uint32_t> aicpuPhyIds = {1,2,3,4};
    MOCKER(halResAddrMap).stubs().will(invoke(halResAddrMapFake));
    int32_t ret = inst.InitMessageQueue(deviceId, aicpuPhyIds);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    ret = inst.InitMessageQueueForThread(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdMessageQueueTest, InitMessageQueueHardThreadSuccess)
{
    MessageQueue::GetInstance();
    MessageQueue inst;
    inst.isEnableHardThread_ = true;

    const uint32_t deviceId = 1;
    const std::vector<uint32_t> aicpuPhyIds = {1,2,3,4};
    MOCKER(halResAddrMap).stubs().will(invoke(halResAddrMapFake));
    int32_t ret = inst.InitMessageQueue(deviceId, aicpuPhyIds);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    ret = inst.InitMessageQueueForThread(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdMessageQueueTest, InitMessageQueueForThreadResetStatusFail)
{
    MessageQueue inst;

    const uint32_t deviceId = 1;
    const std::vector<uint32_t> aicpuPhyIds = {1,2,3,4};
    MOCKER(halResAddrMap).stubs().will(invoke(halResAddrMapFake));
    int32_t ret = inst.InitMessageQueue(deviceId, aicpuPhyIds);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    MOCKER_CPP(&MessageQueue::ResetMessageQueueStatus).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_DRV_ERR));
    ret = inst.InitMessageQueueForThread(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AicpusdMessageQueueTest, InitMessageQueueForThreadInitStatusFuncFail)
{
    MessageQueue inst;

    const uint32_t deviceId = 1;
    const std::vector<uint32_t> aicpuPhyIds = {1,2,3,4};
    MOCKER(halResAddrMap).stubs().will(invoke(halResAddrMapFake));
    int32_t ret = inst.InitMessageQueue(deviceId, aicpuPhyIds);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    MOCKER_CPP(&MessageQueue::InitMessageQueueStatusReadFunc).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_DRV_ERR));
    ret = inst.InitMessageQueueForThread(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AicpusdMessageQueueTest, InitMessageQueueForThreadInitDataFuncFail)
{
    MessageQueue inst;

    const uint32_t deviceId = 1;
    const std::vector<uint32_t> aicpuPhyIds = {1,2,3,4};
    MOCKER(halResAddrMap).stubs().will(invoke(halResAddrMapFake));
    int32_t ret = inst.InitMessageQueue(deviceId, aicpuPhyIds);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    MOCKER_CPP(&MessageQueue::InitMessageQueueDataReadFunc).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_DRV_ERR));
    ret = inst.InitMessageQueueForThread(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AicpusdMessageQueueTest, InitMessageQueueForThreadInitRspFuncFail)
{
    MessageQueue inst;

    const uint32_t deviceId = 1;
    const std::vector<uint32_t> aicpuPhyIds = {1,2,3,4};
    MOCKER(halResAddrMap).stubs().will(invoke(halResAddrMapFake));
    int32_t ret = inst.InitMessageQueue(deviceId, aicpuPhyIds);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    MOCKER_CPP(&MessageQueue::InitMessageQueueRspFunc).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_DRV_ERR));
    ret = inst.InitMessageQueueForThread(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

TEST_F(AicpusdMessageQueueTest, InitMessageQueueForThreadInintCqeFail)
{
    MessageQueue inst;

    const uint32_t deviceId = 1;
    const std::vector<uint32_t> aicpuPhyIds = {1,2,3,4};
    MOCKER(halResAddrMap).stubs().will(invoke(halResAddrMapFake));
    int32_t ret = inst.InitMessageQueue(deviceId, aicpuPhyIds);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    MOCKER_CPP(&MessageQueue::InitCqeAddr).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_DRV_ERR));
    ret = inst.InitMessageQueueForThread(0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DRV_ERR);
}

// TEST_F(AicpusdMessageQueueTest, ReadMsq4StatusSuccess)
// {
//     MessageQueue inst;
//     MsqStatus ret = inst.ReadMsqT1Status();
//     EXPECT_EQ(ret.valid, 0);
// }

TEST_F(AicpusdMessageQueueTest, ReadMsq0DataFail)
{
    MessageQueue inst;
    MsqDatas datas = {};
    const uint32_t msgSize = 0U;
    inst.ReadMsqT0Data(msgSize, datas);
    EXPECT_EQ(datas.data0, 0);
}

TEST_F(AicpusdMessageQueueTest, ReadMsq4DataFail)
{
    MessageQueue inst;
    MsqDatas datas = {};
    const uint32_t msgSize = 0U;
    inst.ReadMsqT1Data(msgSize, datas);
    EXPECT_EQ(datas.data0, 0);
}

TEST_F(AicpusdMessageQueueTest, ReadMsq0DataSuccess)
{
    MessageQueue inst;
    MsqDatas datas = {};
    const uint32_t msgSize = 4U;
    inst.ReadMsqT0Data(msgSize, datas);
    EXPECT_EQ(datas.data0, 0);
}

TEST_F(AicpusdMessageQueueTest, ReadMsq4DataSuccess)
{
    MessageQueue inst;
    MsqDatas datas = {};
    const uint32_t msgSize = 4U;
    inst.ReadMsqT1Data(msgSize, datas);
    EXPECT_EQ(datas.data0, 0);
}

TEST_F(AicpusdMessageQueueTest, WaitMsqInfoOnceFail)
{
    MessageQueue inst;
    const uint32_t deviceId = 1;
    const std::vector<uint32_t> aicpuPhyIds = {1,2,3,4};
    MOCKER(halResAddrMap).stubs().will(invoke(halResAddrMapFake));
    const int32_t ret = inst.InitMessageQueue(deviceId, aicpuPhyIds);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

    MsqDatas datas = {};
    const bool ret1 = MessageQueue::WaitMsqInfoOnce(datas);
    EXPECT_EQ(ret1, false);
}

// TEST_F(AicpusdMessageQueueTest, WaitMsqInfoOnceSuccess)
// {
//     MessageQueue inst;
//     const uint32_t deviceId = 1;
//     const std::vector<uint32_t> aicpuPhyIds = {1,2,3,4};

//     MsqStatus status = {};
//     status.valid = 1;
//     MOCKER_CPP(&MessageQueue::ReadMsqT0Status).stubs().will(returnValue(status));
//     MOCKER(halResAddrMap).stubs().will(invoke(halResAddrMapFake));
//     const int32_t ret = inst.InitMessageQueue(deviceId, aicpuPhyIds);
//     EXPECT_EQ(ret, AICPU_SCHEDULE_OK);

//     MsqDatas datas = {};
//     const bool ret1 = MessageQueue::WaitMsqInfoOnce(datas);
//     EXPECT_EQ(ret1, true);
// }

TEST_F(AicpusdMessageQueueTest, SendResponseSuccess)
{
    MessageQueue inst;
    const uint32_t deviceId = 1;
    const std::vector<uint32_t> aicpuPhyIds = {1,2,3,4};
    MOCKER(halResAddrMap).stubs().will(invoke(halResAddrMapFake));
    const int32_t ret = inst.InitMessageQueue(deviceId, aicpuPhyIds);
    inst.SendResponse(1, 1);
    MessageQueue::SendMsqT1Response();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpusdMessageQueueTest, InitCqeAddrSuccess)
{
    MessageQueue inst;
    const uint32_t deviceId = 1;
    const std::vector<uint32_t> aicpuPhyIds = {1, 2, 3, 4};
    MOCKER(halResAddrMap).stubs().will(invoke(halResAddrMapFake));
    int32_t ret = inst.InitMessageQueue(deviceId, aicpuPhyIds);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    inst.cqeBaseAddr_ = nullptr;
    ret = inst.InitCqeAddr(3U);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(PtrToValue(PtrToPtr<uint32_t, void>(inst.cqeAddr_)), 64U);
}

TEST_F(AicpusdMessageQueueTest, InitCqeAddrFail1)
{
    MessageQueue inst;
    const uint32_t deviceId = 1;
    const std::vector<uint32_t> aicpuPhyIds = {1, 2, 3, 4};
    MOCKER(halResAddrMap).stubs().will(invoke(halResAddrMapFake));
    int32_t ret = inst.InitMessageQueue(deviceId, aicpuPhyIds);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    inst.cqeBaseAddr_ = nullptr;
    ret = inst.InitCqeAddr(5U);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}
