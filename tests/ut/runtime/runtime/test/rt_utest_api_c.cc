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
extern "C" 
{
#include "runtime/c/kernel.h"
}

#undef protected
#undef private

using namespace testing;

extern "C"
{
    rtError_t rtDevBinaryRegister(const rtDevBinary_t* bin, void **hdl);
}

class ApiCTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        // setup nano resource
    }

    static void TearDownTestCase()
    {
        // setup nano resource
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
         GlobalMockObject::verify();
    }
};

TEST_F(ApiCTest, rtDevBinaryRegister_Null)
{
    rtError_t error;
    void *handle;
    error = rtDevBinaryRegister(NULL, &handle);
    EXPECT_EQ(error, RT_ERROR_NONE);
}