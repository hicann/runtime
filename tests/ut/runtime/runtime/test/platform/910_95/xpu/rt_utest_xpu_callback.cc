/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "rt_inner_xpu.h"
#include "error_codes/rt_error_codes.h"


class XpuCallbackTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "XpuCallbackTest SetUP" << std::endl;

        std::cout << "XpuCallbackTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "XpuCallbackTest end" << std::endl;
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

void CallbackFunc(rtExceptionInfo_t *exceptionInfo) {
        printf("XpuTaskFail callback");
}

TEST_F(XpuCallbackTest, create_xpu_set_task_fail_callback_should_success)
{
    char *regName ="lltruntime";
    rtError_t error = rtXpuSetTaskFailCallback(RT_DEV_TYPE_DPU, regName, CallbackFunc);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

TEST_F(XpuCallbackTest, create_xpu_set_task_fail_callback_should_fail_when_regName_is_null)
{
    char *regName = nullptr;
    rtError_t error = rtXpuSetTaskFailCallback(RT_DEV_TYPE_DPU, regName, CallbackFunc);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(XpuCallbackTest, create_xpu_set_task_fail_callback_should_fail_when_devType_is_not_dpu)
{
    char *regName ="lltruntime";
    rtError_t error = rtXpuSetTaskFailCallback(RT_DEV_TYPE_REV, regName, CallbackFunc);
    EXPECT_EQ(error, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(XpuCallbackTest, create_xpu_set_task_fail_callback_should_success_when_callbackFunc_is_null)
{
    char *regName ="lltruntime";
    rtError_t error = rtXpuSetTaskFailCallback(RT_DEV_TYPE_DPU, regName, nullptr);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
}

