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
#include "osal_linux.h"
#include "osal_mem.h"
#include "atomic.h"

class OSAL_LITEOS_STEST : public testing::Test {
protected:
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
        GlobalMockObject::reset();
    }
};

TEST_F(OSAL_LITEOS_STEST, CallocTest)
{
    char *str = (char*)OsalCalloc(sizeof(char) * 10);
    EXPECT_EQ((str == NULL), false);
    OSAL_MEM_FREE(str);
    MOCKER(OsalMalloc)
        .stubs()
        .will(returnValue((void*)NULL));
    char *str2 = (char*)OsalCalloc(sizeof(char) * 10);
    EXPECT_EQ((str2 == NULL), true);
}

TEST_F(OSAL_LITEOS_STEST, AtomicTest)
{
    volatile int32_t index;
    AtomicInit(&index, 0);
    EXPECT_EQ(AtomicLoad(&index), 0);

    AtomicAdd(&index, 1);
    int32_t currWriteCusor = AtomicLoad(&index);
    int32_t nextWriteCusor = currWriteCusor + 1;
    bool ret = AtomicCompareExchangeWeak(&index, nextWriteCusor, currWriteCusor);
    EXPECT_EQ(ret, false);
    EXPECT_EQ(AtomicLoad(&index), 2);
}