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
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "adx_prof_api.h"

using namespace Analysis::Dvvp::Adx;

class ADX_PROF_API_UTEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {

    }
};


TEST_F(ADX_PROF_API_UTEST, AdxIdeCreatePacket) {
    GlobalMockObject::verify();

    IdeBuffT outPut;
    int outLen = 0;
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxIdeCreatePacket(NULL, 0, outPut, outLen));

    EXPECT_EQ(IDE_DAEMON_OK, AdxIdeCreatePacket("test", 0, outPut, outLen));
    AdxIdeFreePacket(outPut);
}

TEST_F(ADX_PROF_API_UTEST, AdxIdeFreePacket) {
    GlobalMockObject::verify();
    MOCKER(free)
        .stubs();
    IdeBuffT outPut = (IdeBuffT)0x12345678;
    AdxIdeFreePacket(outPut);
    EXPECT_EQ(outPut, nullptr);
}

