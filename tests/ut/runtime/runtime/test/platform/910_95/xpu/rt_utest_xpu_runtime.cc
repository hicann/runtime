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
#define private public
#define protected public
#include "runtime.hpp"
#include "context.hpp"
#include "xpu_context.hpp"
#undef private
#undef protected

using namespace cce::runtime;
class XpuRuntimeTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "XpuRuntimeTest SetUP" << std::endl;

        std::cout << "XpuRuntimeTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "XpuRuntimeTest end" << std::endl;
    }

    virtual void SetUp()
    {}

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(XpuRuntimeTest, createStreamArgRes_Success)
{
    Runtime *rt = new Runtime();
    Context *ctx = new Context(nullptr,true);
    RefObject<Context *> &refObj = rt->priCtxs_[0][0];
    refObj.SetVal(ctx);
    MOCKER(ContextManage::EraseContextFromSet).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP_VIRTUAL(ctx,&Context::TearDown).stubs().will(returnValue(RT_ERROR_NONE));
    MOCKER_CPP(&Context::ContextOutUse).stubs().will(returnValue(0UL));
    XpuContext *xpuCtx = new XpuContext(nullptr,true);
    rt->xpuCtxt_ = xpuCtx;
    DELETE_O(rt);
    EXPECT_TRUE(true);
}
