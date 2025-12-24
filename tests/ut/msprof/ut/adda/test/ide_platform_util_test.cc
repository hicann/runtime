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

#include "ide_platform_util.h"
#include "ide_common_util.h"
#include "config.h"

using namespace IdeDaemon::Common::Config;
using namespace Adx;
extern int g_sprintf_s_flag;

class IDE_PLATFORM_UTIL_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(IDE_PLATFORM_UTIL_TEST, IdeRead)
{
    void *handle = (void *)0x12345;
    void *read_buf = NULL;
    int read_len = 0;
    enum IdeChannel channel = IdeChannel::IDE_CHANNEL_SOCK;

    MOCKER(IdeSockReadData)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(HdcRead)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    struct IdeTransChannel tranHandle = {IdeChannel::IDE_CHANNEL_SOCK, handle};
    EXPECT_EQ(IDE_DAEMON_OK, IdeRead(tranHandle, &read_buf, &read_len, IDE_DAEMON_BLOCK));
    tranHandle.type = IdeChannel::IDE_CHANNEL_HDC;
    EXPECT_EQ(IDE_DAEMON_OK, IdeRead(tranHandle, &read_buf, &read_len, IDE_DAEMON_BLOCK));
}

TEST_F(IDE_PLATFORM_UTIL_TEST, IdeRead_noblock)
{
    void *handle = (void *)0x12345;
    void *read_buf = NULL;
    int read_len = 0;
    enum IdeChannel channel = IdeChannel::IDE_CHANNEL_SOCK;

    MOCKER(IdeSockReadData)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(HdcReadNb)
        .stubs()
        .will(returnValue(IDE_DAEMON_RECV_NODATA));

    struct IdeTransChannel tranHandle = {IdeChannel::IDE_CHANNEL_HDC, handle};
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeRead(tranHandle, &read_buf, &read_len, IDE_DAEMON_NOBLOCK));

    GlobalMockObject::verify();
    MOCKER(HdcReadNb)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    EXPECT_EQ(IDE_DAEMON_OK, IdeRead(tranHandle, &read_buf, &read_len, IDE_DAEMON_NOBLOCK));

}

TEST_F(IDE_PLATFORM_UTIL_TEST, IdeRealFileRemove )
{
    //file NULL
    EXPECT_EQ(IDE_DAEMON_ERROR,IdeRealFileRemove(NULL));
    MOCKER(mmRealPath)
        .stubs()
        .will(returnValue(EN_ERROR))
        .then(returnValue(EN_OK));
    //mmRealPath
    EXPECT_EQ(IDE_DAEMON_OK,IdeRealFileRemove("/rroot/123/ide_daemon/"));
    EXPECT_EQ(IDE_DAEMON_OK,IdeRealFileRemove("/rroot/123/ide_daemon/"));

    MOCKER(IdeXmalloc)
        .stubs()
        .will(returnValue((void *)NULL));
    EXPECT_EQ(IDE_DAEMON_ERROR,IdeRealFileRemove("/rroot/123/ide_daemon/"));
}

