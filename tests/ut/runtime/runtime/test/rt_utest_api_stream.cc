/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "rt_utest_api.hpp"

class ApiStreamTest : public testing::Test {
public:
    static Driver *driver_;
    static rtChipType_t originType_;
    static bool disableFlag_;
protected:
    static void SetUpTestCase()
    {
        (void)rtSetSocVersion("Ascend910");
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        originType_ = Runtime::Instance()->GetChipType();
        disableFlag_ = rtInstance->GetDisableThread();
        rtInstance->SetDisableThread(true);
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        rtInstance->SetChipType(CHIP_CLOUD);
        GlobalContainer::SetRtChipType(CHIP_CLOUD);
        (void)rtSetDevice(0);
        (void)rtSetTSDevice(1);
        delete rawDevice;
        std::cout << "ApiStreamTest SetUpTestCase finish:" << std::endl;
    }

    static void TearDownTestCase()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(originType_);
        GlobalContainer::SetRtChipType(originType_);
        GlobalMockObject::verify();
        Context * const curCtx = Runtime::Instance()->CurrentContext();
        EXPECT_EQ(curCtx != nullptr, true);
        curCtx->DefaultStream_()->pendingNum_.Set(0U);
        MOCKER_CPP_VIRTUAL(curCtx->Device_(), &Device::GetDevRunningState).stubs().will(returnValue(1U));
        StubClearHalSqSendAndRecvCnt(0);
        rtDeviceReset(0);
        GlobalMockObject::verify();
        ((Runtime *)Runtime::Instance())->SetIsUserSetSocVersion(false);
        (void)rtSetSocVersion("");
        rtInstance->SetDisableThread(disableFlag_);
    }

    virtual void SetUp()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        RawDevice *rawDevice = new RawDevice(0);
        MOCKER_CPP_VIRTUAL(rawDevice, &RawDevice::SetTschVersionForCmodel).stubs().will(ignoreReturnValue());
        rtInstance->SetChipType(CHIP_CLOUD);
        GlobalContainer::SetRtChipType(CHIP_CLOUD);
        delete rawDevice;
    }

    virtual void TearDown()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        rtInstance->SetChipType(originType_);
        GlobalContainer::SetRtChipType(originType_);
        GlobalMockObject::verify();
    }
};

Driver* ApiStreamTest::driver_ = nullptr;
rtChipType_t ApiStreamTest::originType_ = CHIP_CLOUD;
bool ApiStreamTest::disableFlag_ = false;

TEST_F(ApiStreamTest, rtGetAvailStreamNum)
{
    rtError_t error;
    uint32_t avaliStrCount;

    error = rtGetAvailStreamNum(RT_NORMAL_STREAM, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetAvailStreamNum(RT_NORMAL_STREAM, &avaliStrCount);
    EXPECT_EQ(error, ACL_RT_SUCCESS);

    Runtime *rtInstance = (Runtime *)Runtime::Instance();
    rtChipType_t type = rtInstance->chipType_;
    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    error = rtGetAvailStreamNum(RT_NORMAL_STREAM, &avaliStrCount);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    GlobalContainer::SetRtChipType(type);

    error = rtGetAvailStreamNum(RT_HUGE_STREAM, NULL);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    error = rtGetAvailStreamNum(RT_HUGE_STREAM, &avaliStrCount);
    EXPECT_EQ(error, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    GlobalContainer::SetRtChipType(type);

    int32_t code = (int32_t)DRV_ERROR_INVALID_VALUE;
    MOCKER(halResourceInfoQuery)
        .stubs()
        .will(returnValue(code));
    error = rtGetAvailStreamNum(RT_NORMAL_STREAM, &avaliStrCount);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);

    GlobalContainer::SetRtChipType(CHIP_CLOUD);
    error = rtGetAvailStreamNum(RT_NORMAL_STREAM, &avaliStrCount);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
    GlobalContainer::SetRtChipType(type);
}
