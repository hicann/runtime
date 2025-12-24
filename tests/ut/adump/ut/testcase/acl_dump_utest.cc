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
class ACL_DUMP_UTEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

int32_t messageCallbackStub1(const struct acldumpChunk * data, int32_t len)
{
    if((sizeof(acldumpChunk) + data->bufLen) == len) {
        printf("messageCallbackStub1 ok\n");
        return 0;
    } else {
        return -1;
    }
}

int32_t messageCallbackStub2(const struct acldumpChunk * data, int32_t len)
{
    if((sizeof(acldumpChunk) + data->bufLen) == len) {
        printf("messageCallbackStub2 ok\n");
        return 0;
    } else {
        return -1;
    }
}

TEST_F(ACL_DUMP_UTEST, acldumpRegCallback)
{
    acldumpUnregCallback();
    acldumpUnregCallback();
    acldumpRegCallback(messageCallbackStub1, 0);
    acldumpRegCallback(messageCallbackStub2, 0);
    acldumpUnregCallback();
    acldumpRegCallback(nullptr, 0);
    acldumpRegCallback(messageCallbackStub1, 1);
    acldumpRegCallback(messageCallbackStub2, 1);
    EXPECT_EQ(ACL_ERROR_FAILURE, acldumpRegCallback(nullptr, 1));
}
