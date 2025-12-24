/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>

#include "acl/acl.h"
#include "acl/ops/acl_cblas.h"
#include "common/common_inner.h"

using namespace testing;
using namespace std;

class UTEST_ACL_BuiltinOpApi : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {}

};

TEST_F(UTEST_ACL_BuiltinOpApi, CastOpTest)
{
    aclopHandle *handle = nullptr;
    int64_t shape[2] = {16, 32};
    aclTensorDesc *inputDesc = aclCreateTensorDesc(ACL_FLOAT16, 2, shape, ACL_FORMAT_ND);
    aclTensorDesc *outputDesc = aclCreateTensorDesc(ACL_FLOAT16, 2, shape, ACL_FORMAT_ND);
    aclDataBuffer *inputBuffer = aclCreateDataBuffer(nullptr, 0);
    aclDataBuffer *outputBuffer = aclCreateDataBuffer(nullptr, 0);

    acl::SetCastHasTruncateAttr(true);
    ASSERT_NE(aclopCreateHandleForCast(inputDesc, outputDesc, false, &handle), ACL_SUCCESS);
    ASSERT_EQ(aclopCreateHandleForCast(inputDesc, outputDesc, false,&handle), ACL_ERROR_OP_NOT_FOUND);

    ASSERT_NE(aclopCast(inputDesc, inputBuffer, outputDesc, outputBuffer, false, nullptr), ACL_SUCCESS);
    ASSERT_EQ(aclopCast(inputDesc, inputBuffer, outputDesc, outputBuffer, false, nullptr), ACL_ERROR_OP_NOT_FOUND);

    aclDestroyTensorDesc(inputDesc);
    aclDestroyTensorDesc(outputDesc);
    aclDestroyDataBuffer(inputBuffer);
    aclDestroyDataBuffer(outputBuffer);
    aclopDestroyHandle(handle);
}