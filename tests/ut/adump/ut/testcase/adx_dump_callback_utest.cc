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

#include "adx_dump_record.h"
#include "adx_dump_process.h"
#include "adx_datadump_callback.h"
#include "mmpa_api.h"
class ADX_DUMP_CALLBACK_UTEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

int messageCallbackStub1(const struct Adx::DumpChunk *data, int len)
{
    if ((sizeof(Adx::DumpChunk) + data->bufLen) == len) {
        printf("messageCallbackStub1 ok\n");
        return 0;
    } else {
        return -1;
    }
}

int messageCallbackStub2(const struct Adx::DumpChunk *data, int len)
{
    if ((sizeof(Adx::DumpChunk) + data->bufLen) == len) {
        printf("messageCallbackStub2 ok\n");
        return 0;
    } else {
        return -1;
    }
}

TEST_F(ADX_DUMP_CALLBACK_UTEST, AdxRegDumpProcessCallBack)
{
    EXPECT_EQ(IDE_DAEMON_OK, Adx::AdxRegDumpProcessCallBack(messageCallbackStub1));
    EXPECT_EQ(IDE_DAEMON_OK, Adx::AdxRegDumpProcessCallBack(messageCallbackStub2));
    EXPECT_EQ(IDE_DAEMON_ERROR, Adx::AdxRegDumpProcessCallBack(nullptr));
}

TEST_F(ADX_DUMP_CALLBACK_UTEST, AdxUnRegDumpProcessCallBack)
{
    Adx::AdxUnRegDumpProcessCallBack();
    Adx::AdxUnRegDumpProcessCallBack();
    EXPECT_EQ(IDE_DAEMON_OK, Adx::AdxRegDumpProcessCallBack(messageCallbackStub2));
    Adx::AdxUnRegDumpProcessCallBack();
}
