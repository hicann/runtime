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
#include "ide_task_register.h"
#include "ide_common_util.h"

using namespace Adx;
extern int IdeDaemonTestMain(int argc, char *argv[]);
extern int SingleProcessStart(std::string &lock);
extern int AdxStartUpInit();
extern int IdeDaemonStartUp();

class IDE_DAEMON_TEST_UTEST: public testing::Test {
protected:
    virtual void SetUp() {

    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(IDE_DAEMON_TEST_UTEST, IdeDaemonRegisterModules)
{
    IdeDaemonRegisterModules();

    // 1.check hdc
    EXPECT_TRUE(g_ideComponentsFuncs.init[IDE_COMPONENT_HDC] != NULL);
    EXPECT_TRUE(g_ideComponentsFuncs.destroy[IDE_COMPONENT_HDC] != NULL);
    EXPECT_EQ(NULL, g_ideComponentsFuncs.sockProcess[IDE_COMPONENT_HDC]);
    EXPECT_EQ(NULL, g_ideComponentsFuncs.hdcProcess[IDE_COMPONENT_HDC]);

    // 2.check cmd
    EXPECT_TRUE(g_ideComponentsFuncs.init[IDE_COMPONENT_CMD] == NULL);
    EXPECT_TRUE(g_ideComponentsFuncs.destroy[IDE_COMPONENT_CMD] == NULL);
    EXPECT_TRUE(g_ideComponentsFuncs.sockProcess[IDE_COMPONENT_CMD] == NULL);
    EXPECT_TRUE(g_ideComponentsFuncs.hdcProcess[IDE_COMPONENT_CMD] == NULL);

    // 3.check send file
    EXPECT_TRUE(g_ideComponentsFuncs.init[IDE_COMPONENT_SEND_FILE] == NULL);
    EXPECT_TRUE(g_ideComponentsFuncs.destroy[IDE_COMPONENT_SEND_FILE] == NULL);
    EXPECT_TRUE(g_ideComponentsFuncs.sockProcess[IDE_COMPONENT_SEND_FILE] == NULL);
    EXPECT_TRUE(g_ideComponentsFuncs.hdcProcess[IDE_COMPONENT_SEND_FILE] == NULL);
}

TEST_F(IDE_DAEMON_TEST_UTEST, SingleProcessStart)
{
    GlobalMockObject::verify();
    std::string lock;
    MOCKER(mmOpen2)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    MOCKER(IdeLockFcntl)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));
    MOCKER(IdeFcntl)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0))
        .then(returnValue(-1))
        .then(returnValue(0));

    EXPECT_EQ(-1, SingleProcessStart(lock));
    EXPECT_EQ(-1, SingleProcessStart(lock));
    EXPECT_EQ(-1, SingleProcessStart(lock));
    EXPECT_EQ(-1, SingleProcessStart(lock));
    EXPECT_EQ(0, SingleProcessStart(lock));

}

TEST_F(IDE_DAEMON_TEST_UTEST, AdxStartUpInit)
{
    GlobalMockObject::verify();
    std::string lock;
    MOCKER(DaemonInit)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));
    MOCKER(HdcCreateHdcServerProc)
        .stubs()
        .will(returnValue((void*)0));

    EXPECT_EQ(IDE_DAEMON_ERROR, AdxStartUpInit());
    EXPECT_EQ(IDE_DAEMON_OK, AdxStartUpInit());

}

TEST_F(IDE_DAEMON_TEST_UTEST, IdeDaemonStartUp)
{
    GlobalMockObject::verify();
    std::string lock;

    MOCKER(SingleProcessStart)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(1));

    MOCKER(dlog_init)
        .stubs();

    MOCKER(AdxStartUpInit)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    MOCKER(DlogSetAttr)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    MOCKER(DaemonDestroy)
        .stubs();

    MOCKER(IdeRealFileRemove)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR))
        .then(returnValue(IDE_DAEMON_OK));

    EXPECT_EQ(IDE_DAEMON_ERROR, IdeDaemonStartUp());
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeDaemonStartUp());
    EXPECT_EQ(IDE_DAEMON_OK, IdeDaemonStartUp());
}
