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
#include "adx_dump_soc_helper.h"

class ADX_DUMP_SOC_HELPER_TEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(ADX_DUMP_SOC_HELPER_TEST, IdeDumpStart)
{
    const char* privInfo = "127.0.0.1:22118;0;123";
    MOCKER_CPP(&Adx::AdxDumpRecord::Init)
        .stubs()
        .will(returnValue(-1));
    IDE_SESSION session = IdeDumpStart(privInfo);
    EXPECT_EQ(0, session);

    privInfo = "127.0.0.1:22118";
    session = IdeDumpStart(privInfo);
    EXPECT_EQ(session, nullptr);

    MOCKER_CPP(&Adx::AdxDumpSocHelper::Init)
        .stubs()
        .will(returnValue(true));
    privInfo = "127.0.0.1:22118;123";
    session = IdeDumpStart(privInfo);
    EXPECT_EQ(session, nullptr);
}

TEST_F(ADX_DUMP_SOC_HELPER_TEST, IdeDumpData)
{
    IDE_SESSION session = (IDE_SESSION)0xFFFFF000;
    IdeDumpChunk dumpChunk;
    unsigned char ch = 'a';
    dumpChunk.fileName = "/home/test.log";
    dumpChunk.dataBuf = &ch;
    dumpChunk.bufLen = 1;
    dumpChunk.isLastChunk = 0;
    dumpChunk.offset = 0;
    dumpChunk.flag = IDE_DUMP_NONE_FLAG ;
    const IdeDumpChunk constDumpChunk = dumpChunk;
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, IdeDumpData(nullptr, nullptr));
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, IdeDumpData(session, nullptr));
    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, IdeDumpEnd(session));
}

