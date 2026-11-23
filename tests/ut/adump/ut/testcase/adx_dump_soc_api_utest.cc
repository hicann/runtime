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

class ADX_DUMP_SOC_HELPER_TEST : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() { GlobalMockObject::verify(); }
};

TEST_F(ADX_DUMP_SOC_HELPER_TEST, IdeDumpStart)
{
    const char* privInfo = "127.0.0.1:22118;0;123";
    MOCKER_CPP(&Adx::AdxDumpRecord::Init).stubs().will(returnValue(-1));
    IDE_SESSION session = IdeDumpStart(privInfo);
    EXPECT_EQ(0, session);

    privInfo = "127.0.0.1:22118";
    session = IdeDumpStart(privInfo);
    EXPECT_EQ(session, nullptr);

    MOCKER_CPP(&Adx::AdxDumpSocHelper::Init).stubs().will(returnValue(true));
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
    dumpChunk.flag = IDE_DUMP_NONE_FLAG;
    const IdeDumpChunk constDumpChunk = dumpChunk;
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, IdeDumpData(nullptr, nullptr));
    EXPECT_EQ(IDE_DAEMON_INVALID_PARAM_ERROR, IdeDumpData(session, nullptr));
    EXPECT_EQ(IDE_DAEMON_NONE_ERROR, IdeDumpEnd(session));
}

// 新回传 flag 的 device 侧真实处理（能力探测等）：SOC 直调解析 host 库——UT 环境无
// host 库加载（弱符号未绑定、dlopen(RTLD_NOLOAD) 查不到），应同步回"不支持"错误码，
// 不触碰 fileName、不进文件分片路径（老实现此处为 nullptr 解引用崩溃）。
TEST_F(ADX_DUMP_SOC_HELPER_TEST, IdeDumpData_UnsupportedFlag)
{
    IDE_SESSION session = (IDE_SESSION)0xFFFFF000;
    IdeDumpChunk dumpChunk = {};
    unsigned char ch = 'a';
    dumpChunk.fileName = nullptr; // 新 flag 的合法形态：无文件名
    dumpChunk.dataBuf = &ch;
    dumpChunk.bufLen = 1;
    dumpChunk.isLastChunk = 1;
    dumpChunk.offset = -1;
    // 守卫已删（PR 主功能）：新 flag 现在真实进入 DataProcess → GetHostDumpEntry。
    // UT 环境无 host 库（弱符号未绑定、dlopen(RTLD_NOLOAD) 查不到）→ 整链同步回
    // CHANNEL_ERROR，不触碰 fileName、不进文件分片路径。
    dumpChunk.flag = IDE_DUMP_CHECKSUPPORT;
    EXPECT_EQ(IDE_DAEMON_CHANNEL_ERROR, IdeDumpData(session, &dumpChunk));
    dumpChunk.flag = IDE_DUMP_REQ_WITH_ID;
    EXPECT_EQ(IDE_DAEMON_CHANNEL_ERROR, IdeDumpData(session, &dumpChunk));
    dumpChunk.flag = IDE_DUMP_REQ_WITH_OPINFO;
    EXPECT_EQ(IDE_DAEMON_CHANNEL_ERROR, IdeDumpData(session, &dumpChunk));
}
