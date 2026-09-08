/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstdint>

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "dev_info_manage.h"
#include "platform_manager_v2.h"
#include "runtime/rt.h"
#include "soc_info.h"

#include "coprocessor_stream.hpp"
#include "device.hpp"
#include "device_sq_cq_pool.hpp"
#include "runtime.hpp"
#include "stream_david.hpp"
#include "stream_sqcq_manage.hpp"

using namespace cce::runtime;

namespace {
constexpr uintptr_t SIMT_STACK_ADDR = 0x123456789ABCULL;
constexpr uintptr_t STACK_PHY_ADDR = 0x23456789ABCDULL;
constexpr uint32_t TEST_SQ_ID = 100U;
constexpr uint32_t TEST_CQ_ID = 101U;

struct SqCqAllocateCapture {
    bool called = false;
    bool hasInfoEx = false;
    uint32_t drvFlag = 0U;
    uint32_t msgLen = 0U;
    rtStreamInfoExMsg_t infoEx = {};
};

SqCqAllocateCapture g_sqCqAllocateCapture;

rtError_t StubGetChipTypeFromPlatform(const char_t* const socName, rtChipType_t& chipType)
{
    UNUSED(socName);
    chipType = CHIP_CLOUD_V5;
    return RT_ERROR_NONE;
}

rtError_t CaptureNormalSqCqAllocate(
    Driver* const driver, const uint32_t deviceId, const uint32_t tsId, const uint32_t drvFlag, uint32_t* const sqId,
    uint32_t* const cqId, uint32_t* const info, const uint32_t len, uint32_t* const msg, const uint32_t msgLen,
    const int32_t retryCount)
{
    UNUSED(driver);
    UNUSED(deviceId);
    UNUSED(tsId);
    UNUSED(info);
    UNUSED(len);
    UNUSED(retryCount);
    g_sqCqAllocateCapture.called = true;
    g_sqCqAllocateCapture.drvFlag = drvFlag;
    g_sqCqAllocateCapture.msgLen = msgLen;
    if ((msg != nullptr) && (msgLen == sizeof(rtStreamInfoExMsg_t))) {
        g_sqCqAllocateCapture.infoEx = *reinterpret_cast<const rtStreamInfoExMsg_t*>(msg);
        g_sqCqAllocateCapture.hasInfoEx = true;
    }
    *sqId = TEST_SQ_ID;
    *cqId = TEST_CQ_ID;
    return RT_ERROR_NONE;
}
} // namespace

class Arch9201StreamInfoExTest : public testing::Test {
protected:
    void SetUp() override
    {
        GlobalMockObject::reset();
        g_sqCqAllocateCapture = {};
        Runtime* const runtime = Runtime::Instance();
        oldRuntimeChipType_ = runtime->GetChipType();
        oldGlobalChipType_ = GlobalContainer::GetRtChipType();
        MOCKER(GetChipTypeFromPlatform).stubs().will(invoke(StubGetChipTypeFromPlatform));
        ASSERT_EQ(rtSetDevice(0), RT_ERROR_NONE);
        device_ = runtime->DeviceRetain(0U, 0U);
        ASSERT_NE(device_, nullptr);
        oldSimtStackAddr_ = device_->GetSimtStackPhyBase();
        device_->SetSimtStackPhyBase(reinterpret_cast<void*>(SIMT_STACK_ADDR));
    }

    void TearDown() override
    {
        Runtime* const runtime = Runtime::Instance();
        if (device_ != nullptr) {
            device_->SetSimtStackPhyBase(const_cast<void*>(oldSimtStackAddr_));
            runtime->DeviceRelease(device_);
            device_ = nullptr;
        }
        (void)rtDeviceReset(0);
        runtime->SetChipType(oldRuntimeChipType_);
        GlobalContainer::SetRtChipType(oldGlobalChipType_);
        GlobalMockObject::verify();
    }

    void MockNormalSqCqAllocate()
    {
        MOCKER_CPP_VIRTUAL(device_, &Device::GetStackPhyBase32k)
            .stubs()
            .will(returnValue(reinterpret_cast<const void*>(STACK_PHY_ADDR)));
        MOCKER_CPP_VIRTUAL(device_->Driver_(), &Driver::NormalSqCqAllocate)
            .expects(once())
            .will(invoke(CaptureNormalSqCqAllocate));
    }

    void ExpectSimtInfoEx() const
    {
        ASSERT_TRUE(g_sqCqAllocateCapture.called);
        ASSERT_TRUE(g_sqCqAllocateCapture.hasInfoEx);
        EXPECT_EQ(g_sqCqAllocateCapture.msgLen, sizeof(rtStreamInfoExMsg_t));
        const rtStreamInfoExMsg_t& infoEx = g_sqCqAllocateCapture.infoEx;
        EXPECT_EQ(infoEx.head.type, static_cast<uint32_t>(StreamInfoExHeaderType::TS_SQCQ_NORMAL_TYPE));
        EXPECT_EQ(infoEx.body.kisSimtStkBaseAddrLow, static_cast<uint32_t>(SIMT_STACK_ADDR));
        EXPECT_EQ(
            infoEx.body.kisSimtStkBaseAddrHigh,
            static_cast<uint16_t>(static_cast<uint64_t>(SIMT_STACK_ADDR) >> UINT32_BIT_NUM));
        EXPECT_EQ(infoEx.body.kisSimtWarpStkSize, device_->GetSimtWarpStkSize());
        EXPECT_EQ(infoEx.body.kisSimtDvgWarpStkSize, device_->GetSimtDvgWarpStkSize());
        EXPECT_EQ(infoEx.body.poolId, device_->GetPoolId());
        EXPECT_EQ(infoEx.body.poolIdMax, device_->GetPoolIdMax());
        EXPECT_EQ(infoEx.body.stackPhyBaseAddrLow, static_cast<uint32_t>(STACK_PHY_ADDR));
        EXPECT_EQ(
            infoEx.body.stackPhyBaseAddrHigh,
            static_cast<uint32_t>(static_cast<uint64_t>(STACK_PHY_ADDR) >> UINT32_BIT_NUM));
    }

    Device* device_ = nullptr;
    const void* oldSimtStackAddr_ = nullptr;
    rtChipType_t oldRuntimeChipType_ = CHIP_END;
    rtChipType_t oldGlobalChipType_ = CHIP_END;
};

TEST_F(Arch9201StreamInfoExTest, DavidStreamSqCqAllocationPassesSimtInfoEx)
{
    DavidStream stream(device_, 0U, RT_STREAM_ACSQ_LOCK, nullptr);
    MockNormalSqCqAllocate();
    MOCKER_CPP_VIRTUAL(device_->Driver_(), &Driver::GetSqAddrInfo).stubs().will(returnValue(RT_ERROR_NONE));
    uint32_t sqId = 0U;
    uint32_t cqId = 0U;
    uint64_t sqAddr = 0ULL;

    ASSERT_EQ(device_->GetStreamSqCqManage()->AllocDavidStreamSqCq(&stream, 0U, 0U, sqId, cqId, sqAddr), RT_ERROR_NONE);
    EXPECT_EQ(sqId, TEST_SQ_ID);
    EXPECT_EQ(cqId, TEST_CQ_ID);
    EXPECT_EQ(g_sqCqAllocateCapture.drvFlag & static_cast<uint32_t>(TSDRV_FLAG_REMOTE_ID), 0U);
    ExpectSimtInfoEx();
    EXPECT_NE(
        g_sqCqAllocateCapture.infoEx.body.validFlag & static_cast<uint64_t>(InfoExValidFlag::INFO_EX_BODY_FLAG_STREAM),
        0ULL);
    EXPECT_EQ(g_sqCqAllocateCapture.infoEx.body.streamFlag.bits.sqLock, 1U);
    EXPECT_EQ(g_sqCqAllocateCapture.infoEx.body.streamFlag.bits.waitLock, 1U);
}

TEST_F(Arch9201StreamInfoExTest, CoprocessorStreamSqCqAllocationPassesSimtInfoEx)
{
    constexpr uint32_t streamFlags = RT_STREAM_CP_PROCESS_USE | RT_STREAM_ACSQ_LOCK;
    CoprocessorStream stream(device_, 0U, streamFlags);
    MockNormalSqCqAllocate();
    uint32_t sqId = 0U;
    uint32_t cqId = 0U;

    ASSERT_EQ(
        device_->GetStreamSqCqManage()->AllocStreamSqCq(
            &stream, 0U, static_cast<uint32_t>(TSDRV_FLAG_REMOTE_ID), sqId, cqId),
        RT_ERROR_NONE);
    EXPECT_EQ(sqId, TEST_SQ_ID);
    EXPECT_EQ(cqId, TEST_CQ_ID);
    EXPECT_EQ(g_sqCqAllocateCapture.drvFlag, static_cast<uint32_t>(TSDRV_FLAG_REMOTE_ID));
    ExpectSimtInfoEx();
    EXPECT_NE(
        g_sqCqAllocateCapture.infoEx.body.validFlag & static_cast<uint64_t>(InfoExValidFlag::INFO_EX_BODY_FLAG_STREAM),
        0ULL);
    EXPECT_EQ(g_sqCqAllocateCapture.infoEx.body.streamFlag.bits.sqLock, 1U);
    EXPECT_EQ(g_sqCqAllocateCapture.infoEx.body.streamFlag.bits.waitLock, 1U);
}

TEST_F(Arch9201StreamInfoExTest, AclGraphSqCqPreAllocationPassesSimtInfoExWithoutStream)
{
    MockNormalSqCqAllocate();
    rtDeviceSqCqInfo_t sqCqInfo = {};

    ASSERT_EQ(
        device_->GetDeviceSqCqManage()->AllocSqCqFromDrv(&sqCqInfo, static_cast<uint32_t>(TSDRV_FLAG_NO_SQ_MEM)),
        RT_ERROR_NONE);
    EXPECT_EQ(sqCqInfo.sqId, TEST_SQ_ID);
    EXPECT_EQ(sqCqInfo.cqId, TEST_CQ_ID);
    EXPECT_EQ(g_sqCqAllocateCapture.drvFlag, static_cast<uint32_t>(TSDRV_FLAG_NO_SQ_MEM));
    ExpectSimtInfoEx();
    EXPECT_EQ(
        g_sqCqAllocateCapture.infoEx.body.validFlag & static_cast<uint64_t>(InfoExValidFlag::INFO_EX_BODY_FLAG_STREAM),
        0ULL);
    EXPECT_EQ(g_sqCqAllocateCapture.infoEx.body.streamFlag.u32, 0U);
}
