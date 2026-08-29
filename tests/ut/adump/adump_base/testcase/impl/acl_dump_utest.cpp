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
#include "mockcpp/mockcpp.hpp"
#define protected public
#define private public

#include "acl_dump.h"
#include "adx_dump_record.h"
#include "adx_dump_process.h"
#include "mmpa_api.h"
#include "error_manager_stub.h"
#include "adx_datadump_callback.h"

int32_t messageCallbackStub(const struct acldumpChunk* data, int32_t len)
{
    if ((sizeof(acldumpChunk) + data->bufLen) == len) {
        printf("messageCallbackStub ok\n");
        return 0;
    } else {
        return -1;
    }
}

class ACL_DUMP_UTEST : public testing::Test {
protected:
    virtual void SetUp() { ClearLastReportedErrorCode(); }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        ClearLastReportedErrorCode();
    }
};

TEST_F(ACL_DUMP_UTEST, TestAcldumpRegCallbackSuccess)
{
    acldumpUnregCallback();
    aclError ret = acldumpRegCallback(messageCallbackStub, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    acldumpUnregCallback();
}

TEST_F(ACL_DUMP_UTEST, TestAcldumpRegCallbackNullPointer)
{
    acldumpUnregCallback();
    aclError ret = acldumpRegCallback(nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);
    EXPECT_EQ(GetLastReportedErrorCode(), "EP0007");
    acldumpUnregCallback();
}

TEST_F(ACL_DUMP_UTEST, TestAcldumpRegCallbackInvalidFlag)
{
    acldumpUnregCallback();
    aclError ret1 = acldumpRegCallback(messageCallbackStub, 1);
    EXPECT_EQ(ret1, ACL_ERROR_FAILURE);
    EXPECT_EQ(GetLastReportedErrorCode(), "EP0006");

    ClearLastReportedErrorCode();
    aclError ret2 = acldumpRegCallback(messageCallbackStub, -1);
    EXPECT_EQ(ret2, ACL_ERROR_FAILURE);
    EXPECT_EQ(GetLastReportedErrorCode(), "EP0006");

    ClearLastReportedErrorCode();
    aclError ret3 = acldumpRegCallback(nullptr, 1);
    EXPECT_EQ(ret3, ACL_ERROR_FAILURE);
    EXPECT_EQ(GetLastReportedErrorCode(), "EP0007");

    acldumpUnregCallback();
}

TEST_F(ACL_DUMP_UTEST, TestAcldumpRegCallbackRegisterFailed)
{
    acldumpUnregCallback();
    MOCKER(Adx::AdxRegDumpProcessCallBack).stubs().will(returnValue(IDE_DAEMON_ERROR));
    aclError ret = acldumpRegCallback(messageCallbackStub, 0);
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);
    acldumpUnregCallback();
}

TEST_F(ACL_DUMP_UTEST, TestAcldumpUnregCallback)
{
    acldumpUnregCallback();
    aclError ret = acldumpRegCallback(messageCallbackStub, 0);
    EXPECT_EQ(ret, ACL_SUCCESS);
    acldumpUnregCallback();
    acldumpUnregCallback();
}