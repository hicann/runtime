/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <string>
#include <cassert>
#include <iostream>

#include "acl/acl.h"
#include "common/log_inner.h"
#include "acl/acl_rt.h"
#include "acl_rt_impl_base.h"

#include "set_device_vxx.h"
#include "runtime/dev.h"
#include "runtime/stream.h"
#include "runtime/context.h"
#include "runtime/event.h"
#include "runtime/mem.h"
#include "runtime/kernel.h"
#include "runtime/base.h"
#include "runtime/config.h"
#include "acl/acl_rt_allocator.h"
#include "acl_stub.h"
#define private public
#include "aclrt_impl/init_callback_manager.h"
#undef private

#include <gtest/gtest.h>
#include <gmock/gmock.h>

using namespace testing;
using namespace std;
using namespace acl;

class UTEST_ACL_Modelri : public testing::Test
{
protected:
    void SetUp() override
    {
        MockFunctionTest::aclStubInstance().ResetToDefaultMock();
        ON_CALL(MockFunctionTest::aclStubInstance(), GetPlatformResWithLock(_, _))
            .WillByDefault(Return(true));
    }
    void TearDown() override
    {
        Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));
    }
};

TEST_F(UTEST_ACL_Modelri, TestaclmdlRICaptureBegin)
{
    aclrtStream stream = (aclrtStream)0x01;
    aclmdlRICaptureMode mode = ACL_MODEL_RI_CAPTURE_MODE_GLOBAL;
    auto ret = aclmdlRICaptureBegin(stream, mode);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamBeginCapture(_,_))
            .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclmdlRICaptureBegin(stream, mode);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamBeginCapture(_,_))
            .WillOnce(Return(ACL_ERROR_RT_FEATURE_NOT_SUPPORT));
    ret = aclmdlRICaptureBegin(stream, mode);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(UTEST_ACL_Modelri, TestaclmdlRICaptureGetInfo)
{
    aclrtStream stream = (aclrtStream)0x01;
    auto ret = aclmdlRICaptureGetInfo(stream, nullptr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    aclmdlRICaptureStatus status = ACL_MODEL_RI_CAPTURE_STATUS_NONE;
    aclmdlRI modelRI = nullptr;
    ret = aclmdlRICaptureGetInfo(stream, &status, &modelRI);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(status, ACL_MODEL_RI_CAPTURE_STATUS_ACTIVE);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamGetCaptureInfo(_,_,_))
            .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclmdlRICaptureGetInfo(stream, &status, &modelRI);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Modelri, TestaclmdlRICaptureEnd)
{
    aclrtStream stream = (aclrtStream)0x01;
    aclmdlRI modelRI = nullptr;
    auto ret = aclmdlRICaptureEnd(stream, &modelRI);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamEndCapture(_,_))
            .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclmdlRICaptureEnd(stream, &modelRI);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamEndCapture(_,_))
            .WillOnce(Return(ACL_ERROR_RT_FEATURE_NOT_SUPPORT));
    ret = aclmdlRICaptureEnd(stream, &modelRI);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(UTEST_ACL_Modelri, TestaclmdlRIDebugPrint)
{
    aclmdlRI modelRI = (aclmdlRI)0x02;
    auto ret = aclmdlRIDebugPrint(modelRI);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtModelDebugDotPrint(_))
            .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclmdlRIDebugPrint(modelRI);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Modelri, TestaclmdlRIDebugJsonPrint)
{
    aclmdlRI modelRI = (aclmdlRI)0x02;
    auto ret = aclmdlRIDebugJsonPrint(modelRI, "graph_dump.json", 0);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtModelDebugJsonPrint(_,_,_))
            .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclmdlRIDebugJsonPrint(modelRI, "graph_dump.json", 0);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Modelri, TestaclmdlRICaptureThreadExchangeMode)
{
    aclmdlRICaptureMode mode = ACL_MODEL_RI_CAPTURE_MODE_GLOBAL;
    auto ret = aclmdlRICaptureThreadExchangeMode(&mode);
    EXPECT_EQ(mode, ACL_MODEL_RI_CAPTURE_MODE_RELAXED);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtThreadExchangeCaptureMode(_))
            .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclmdlRICaptureThreadExchangeMode(&mode);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtThreadExchangeCaptureMode(_))
            .WillOnce(Return(ACL_ERROR_RT_FEATURE_NOT_SUPPORT));
    ret = aclmdlRICaptureThreadExchangeMode(&mode);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(UTEST_ACL_Modelri, TestaclmdlRIDestroy_CaptureModel)
{
    aclmdlRI modelRI = (aclmdlRI)0x02;
    auto ret = aclmdlRIDestroy(modelRI);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtModelDestroy(_))
            .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclmdlRIDestroy(modelRI);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Modelri, TestaclmdlRIExecuteAsync_CaptureModel)
{
    aclmdlRI modelRI = (aclmdlRI)0x02;
    aclrtStream stream = (aclrtStream)0x01;
    auto ret = aclmdlRIExecuteAsync(modelRI, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtModelExecute(_,_,_))
            .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclmdlRIExecuteAsync(modelRI, stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Modelri, TestaclmdlRICaptureTaskGrpBegin)
{
    aclrtStream stream = (aclrtStream)0x01;
    auto ret = aclmdlRICaptureTaskGrpBegin(stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsStreamBeginTaskGrp(_))
            .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclmdlRICaptureTaskGrpBegin(stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsStreamBeginTaskGrp(_))
            .WillOnce(Return(ACL_ERROR_RT_FEATURE_NOT_SUPPORT));
    ret = aclmdlRICaptureTaskGrpBegin(stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(UTEST_ACL_Modelri, TestaclmdlRICaptureTaskGrpEnd)
{
    aclrtStream stream = (aclrtStream)0x01;
    aclrtTaskGrp handle = nullptr;
    auto ret = aclmdlRICaptureTaskGrpEnd(stream, &handle);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsStreamEndTaskGrp(_,_))
            .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclmdlRICaptureTaskGrpEnd(stream, &handle);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsStreamEndTaskGrp(_,_))
            .WillOnce(Return(ACL_ERROR_RT_FEATURE_NOT_SUPPORT));
    ret = aclmdlRICaptureTaskGrpEnd(stream, &handle);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(UTEST_ACL_Modelri, TestaclmdlRICaptureTaskUpdateBegin)
{
    aclrtStream stream = (aclrtStream)0x01;
    aclrtTaskGrp handle = (aclrtTaskGrp)0x02;
    auto ret = aclmdlRICaptureTaskUpdateBegin(stream, handle);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsStreamBeginTaskUpdate(_,_))
            .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclmdlRICaptureTaskUpdateBegin(stream, handle);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsStreamBeginTaskUpdate(_,_))
            .WillOnce(Return(ACL_ERROR_RT_FEATURE_NOT_SUPPORT));
    ret = aclmdlRICaptureTaskUpdateBegin(stream, handle);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(UTEST_ACL_Modelri, TestaclmdlRICaptureTaskUpdateEnd)
{
    aclrtStream stream = (aclrtStream)0x01;
    auto ret = aclmdlRICaptureTaskUpdateEnd(stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsStreamEndTaskUpdate(_))
            .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclmdlRICaptureTaskUpdateEnd(stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsStreamEndTaskUpdate(_))
            .WillOnce(Return(ACL_ERROR_RT_FEATURE_NOT_SUPPORT));
    ret = aclmdlRICaptureTaskUpdateEnd(stream);
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}