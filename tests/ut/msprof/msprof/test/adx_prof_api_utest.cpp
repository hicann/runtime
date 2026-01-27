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
#include <iostream>
#include "errno/error_code.h"
#include "adx_prof_api.h"

using namespace Analysis::Dvvp::Adx;

class COMMON_ADX_PROF_API_STEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

TEST_F(COMMON_ADX_PROF_API_STEST, AdxIdeCreatePacket) {
    GlobalMockObject::verify();

    IdeBuffT outPut;
    int outLen = 0;
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxIdeCreatePacket(NULL, 0, outPut, outLen));
    AdxIdeFreePacket(outPut);
}

TEST_F(COMMON_ADX_PROF_API_STEST, AdxIdeSockReadData) {
    GlobalMockObject::verify();
    int outLen = 0;
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxIdeSockReadData(NULL, NULL, outLen));
}

TEST_F(COMMON_ADX_PROF_API_STEST, AdxIdeSockWriteData) {
    GlobalMockObject::verify();
    IdeBuffT outPut;
    int outLen = 0;
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxIdeSockWriteData(NULL, outPut, outLen));
}

TEST_F(COMMON_ADX_PROF_API_STEST, AdxIdeSockDupCreate) {
    GlobalMockObject::verify();
    EXPECT_EQ(nullptr, AdxIdeSockDupCreate(NULL));
    AdxIdeSockDestroy(NULL);
    AdxIdeSockDupDestroy(NULL);
}

TEST_F(COMMON_ADX_PROF_API_STEST, AdxGetAdxWorkPath) {
    GlobalMockObject::verify();
    EXPECT_STREQ("./", AdxGetAdxWorkPath().c_str());
}

TEST_F(COMMON_ADX_PROF_API_STEST, AdxIdeGetVfIdBySession) {
    GlobalMockObject::verify();
    HDC_SESSION session = (HDC_SESSION)0x12345678;
    int32_t vfId = 0;
    EXPECT_EQ(IDE_DAEMON_ERROR, AdxIdeGetVfIdBySession(session, vfId));
}