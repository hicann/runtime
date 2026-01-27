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
#include "feature_ctrl.h"
#include "aicpusd_hal_interface_ref.h"

using namespace AicpuSchedule;

class AICPUScheduleOpenTEST : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "AICPUScheduleOpenTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AICPUScheduleOpenTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AICPUScheduleOpenTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AICPUScheduleOpenTEST TearDown" << std::endl;
    }
};

TEST_F(AICPUScheduleOpenTEST, Check_default_feature) {
    FeatureCtrl::Init(0, 0U);
    EXPECT_FALSE(FeatureCtrl::IsAosCore());
    EXPECT_FALSE(FeatureCtrl::IsBindPidByHal());
    EXPECT_FALSE(FeatureCtrl::IsDoubleDieProduct());
    EXPECT_TRUE(FeatureCtrl::ShouldInitDrvThread());
    EXPECT_FALSE(FeatureCtrl::ShouldSubmitTaskOneByOne());
}

TEST_F(AICPUScheduleOpenTEST, Check_A2_feature) {
    FeatureCtrl::Init(5 << 8, 0U);
    EXPECT_TRUE(FeatureCtrl::IsBindPidByHal());
    EXPECT_FALSE(FeatureCtrl::IsDoubleDieProduct());
}

TEST_F(AICPUScheduleOpenTEST, Check_A3_feature) {
    char socVersion[] = "Ascend910_93";
    MOCKER(halGetSocVersion)
        .stubs()
        .with(mockcpp::any(), outBoundP(socVersion, strlen(socVersion)), mockcpp::any())
        .will(returnValue(DRV_ERROR_NONE));
    FeatureCtrl::Init(5 << 8, 0U);
    EXPECT_TRUE(FeatureCtrl::IsBindPidByHal());
    EXPECT_TRUE(FeatureCtrl::IsDoubleDieProduct());
}