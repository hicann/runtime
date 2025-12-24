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

#include <sys/file.h>
#include "securec.h"
#include "ide_common_log.h"
#include "ide_common_util.h"
#include "ide_platform_util.h"

extern void BackUpFile(IdeString logFile);
extern int GetFileFd(IdeString logFile);

class IDE_DAEMON_COMMON_LOG_TEST: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(IDE_DAEMON_COMMON_LOG_TEST, BackUpFile_Malloc)
{
    IdeString logFile = LOG_FILE;
    void *malloc_addr = (void *)0x0;

    MOCKER(malloc).stubs()
        .will(returnValue(malloc_addr));
    EXPECT_CALL(BackUpFile(logFile));
    GlobalMockObject::reset();
}

TEST_F(IDE_DAEMON_COMMON_LOG_TEST, BackUpFile_Strcpy_Failed)
{
    IdeString logFile = LOG_FILE;

    MOCKER(strcpy_s).stubs()
        .will(returnValue(EOK + 1));
    EXPECT_CALL(BackUpFile(logFile));
    GlobalMockObject::reset();
}

TEST_F(IDE_DAEMON_COMMON_LOG_TEST, BackUpFile_Strcpy)
{
    IdeString logFile = LOG_FILE;

    MOCKER(strcpy_s).stubs()
        .will(returnValue(EOK))
        .then(returnValue(EOK + 1));
    EXPECT_CALL(BackUpFile(logFile));
    GlobalMockObject::reset();
}

TEST_F(IDE_DAEMON_COMMON_LOG_TEST, BackUpFile_MmOpen)
{
    IdeString logFile = LOG_FILE;

    MOCKER(mmOpen2).stubs()
        .will(returnValue(-1));
    EXPECT_CALL(BackUpFile(logFile));
    GlobalMockObject::reset();
}

TEST_F(IDE_DAEMON_COMMON_LOG_TEST, BackUpFile_Flock)
{
    IdeString logFile = LOG_FILE;

    MOCKER(flock).stubs()
        .will(returnValue(-1));
    EXPECT_CALL(BackUpFile(logFile));
    GlobalMockObject::reset();
}

TEST_F(IDE_DAEMON_COMMON_LOG_TEST, BackUpFile_Stat_Failed)
{
    IdeString logFile = LOG_FILE;

    MOCKER(flock).stubs()
        .will(returnValue(0));
    MOCKER(stat).stubs()
        .will(returnValue(-1));
    EXPECT_CALL(BackUpFile(logFile));
    GlobalMockObject::reset();
}

TEST_F(IDE_DAEMON_COMMON_LOG_TEST, BackUpFile_Stat)
{
    IdeString logFile = LOG_FILE;

    MOCKER(flock).stubs()
        .will(returnValue(0));
    MOCKER(stat).stubs()
        .will(returnValue(0));
    EXPECT_CALL(BackUpFile(logFile));
    GlobalMockObject::reset();
}

TEST_F(IDE_DAEMON_COMMON_LOG_TEST, BackUpFile_Flock)
{
    IdeString logFile = LOG_FILE;
    struct stat logStat = { 0 };
    logStat.st_size = LOG_FILE_MAX_SIZE;

    MOCKER(flock).stubs()
        .will(returnValue(0));
    MOCKER(stat).stubs()
        .with(any(), outBoundP((struct stat *)&logStat))
        .will(returnValue(0));
    EXPECT_CALL(BackUpFile(logFile));
    GlobalMockObject::reset();
}

TEST_F(IDE_DAEMON_COMMON_LOG_TEST, GetFileFd_MmOpen_Failed)
{
    IdeString logFile = LOG_FILE;

    MOCKER(mmOpen2).stubs()
        .will(returnValue(-1));
    EXPECT_EQ(-1, GetFileFd(logFile));
    GlobalMockObject::reset();
}

TEST_F(IDE_DAEMON_COMMON_LOG_TEST, GetFileFd_Lstat_Failed)
{
    IdeString logFile = LOG_FILE;

    MOCKER(mmOpen2).stubs()
        .will(returnValue(0));
    MOCKER(lstat).stubs()
        .will(returnValue(-1));
    EXPECT_EQ(0, GetFileFd(logFile));
    GlobalMockObject::reset();
}

TEST_F(IDE_DAEMON_COMMON_LOG_TEST, GetFileFd_Lstat)
{
    IdeString logFile = LOG_FILE;
    struct stat buf = { 0 };
    buf.st_mode |= S_IFLNK;

    MOCKER(mmOpen2).stubs()
        .will(returnValue(0));
    MOCKER(lstat).stubs()
        .with(any(), outBoundP((struct stat *)&buf))
        .will(returnValue(0));
    EXPECT_EQ(0, GetFileFd(logFile));
    GlobalMockObject::reset();
}

TEST_F(IDE_DAEMON_COMMON_LOG_TEST, GetFileFd_Success)
{
    IdeString logFile = LOG_FILE;
    struct stat buf = { 0 };

    MOCKER(mmOpen2).stubs()
        .will(returnValue(0));
    MOCKER(lstat).stubs()
        .will(returnValue(0));
    EXPECT_EQ(0, GetFileFd(logFile));
    GlobalMockObject::reset();
}

TEST_F(IDE_DAEMON_COMMON_LOG_TEST, GetFileFd_Failed)
{
    IdeString logFile = LOG_FILE;
    struct stat buf = { 0 };
    buf.st_size = LOG_FILE_MAX_SIZE;

    MOCKER(mmOpen2).stubs()
        .will(returnValue(0))
        .then(returnValue(-1));
    MOCKER(lstat).stubs()
        .with(any(), outBoundP((struct stat *)&buf))
        .will(returnValue(0));
    MOCKER(BackUpFile).stubs();
    EXPECT_EQ(-1, GetFileFd(logFile));
    GlobalMockObject::reset();
}

TEST_F(IDE_DAEMON_COMMON_LOG_TEST, PrintIdeSelfLog_GetFileFd)
{
    EXPECT_CALL(PrintIdeSelfLog(nullptr, nullptr));
}

TEST_F(IDE_DAEMON_COMMON_LOG_TEST, PrintIdeSelfLog_Nullptr)
{
    IdeString msg = "this is test log";

    MOCKER(GetFileFd).stubs()
        .will(returnValue(-1));
    EXPECT_CALL(PrintIdeSelfLog(nullptr, "%s", msg));
    GlobalMockObject::reset();
}

TEST_F(IDE_DAEMON_COMMON_LOG_TEST, PrintIdeSelfLog_MmWrite)
{
    IdeString msg = "this is test log";

    MOCKER(GetFileFd).stubs()
        .will(returnValue(0));
    MOCKER(mmWrite).stubs()
        .will(returnValue(-1));
    EXPECT_CALL(PrintIdeSelfLog(nullptr, "%s", msg));
    GlobalMockObject::reset();
}

TEST_F(IDE_DAEMON_COMMON_LOG_TEST, PrintIdeSelfLog_Success)
{
    IdeString msg = "this is test log";

    MOCKER(GetFileFd).stubs()
        .will(returnValue(0));
    MOCKER(mmWrite).stubs()
        .will(returnValue(0));
    EXPECT_CALL(PrintIdeSelfLog(nullptr, "%s", msg));
    GlobalMockObject::reset();
}

