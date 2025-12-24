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
#include <errno.h>
#include <sys/stat.h>
#include "securec.h"

extern "C" {
#include "dlog_core.h"
#include "dlog_common.h"
#include "dlog_time.h"
}


class ApiForC : public testing::Test
{
public:
    void SetUp();
    void TearDown();
};
void ApiForC::SetUp()
{
}

void ApiForC::TearDown()
{
}

TEST_F(ApiForC, DlogSetlevelForC) {
    EXPECT_EQ(SYS_OK, DlogSetlevelForC(0, 1, 1));
    EXPECT_EQ(SYS_ERROR, DlogSetlevelForC(0, 1, -1));
    EXPECT_EQ(SYS_ERROR, DlogSetlevelForC(0, 5, 1));
    EXPECT_EQ(SYS_OK, DlogSetlevelForC(-1, 1, 1));
    GlobalMockObject::reset();
}

TEST_F(ApiForC, DlogGetlevelForC) {
    int enableEvent = -1;
    EXPECT_EQ(1, DlogGetlevelForC(1, &enableEvent));
    GlobalMockObject::reset();
}

TEST_F(ApiForC, CheckLogLevelForC) {
    EXPECT_EQ(1, CheckLogLevelForC(10, 3));
    GlobalMockObject::reset();
}
