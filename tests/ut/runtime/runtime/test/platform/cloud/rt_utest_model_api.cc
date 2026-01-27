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
#include "runtime/rt.h"
#include "runtime.hpp"
#include "device.hpp"
#include "stream.hpp"
#include "npu_driver.hpp"
#include "context.hpp"

using namespace cce::runtime;
namespace {
class ModelApiTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        (void)rtSetDevice(0);
    }

    static void TearDownTestCase()
    {
        rtDeviceReset(0);
    }

    virtual void SetUp()
    {
        GlobalMockObject::verify();
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};
}

TEST_F(ModelApiTest, ContextIsValid)
{
    const Runtime *const rtInstance = Runtime::Instance();
    EXPECT_NE(rtInstance, nullptr);
    Context *const curCtx = rtInstance->CurrentContext();
    EXPECT_NE(curCtx, nullptr);
    Device *dev = curCtx->Device_();
    EXPECT_NE(dev, nullptr);
}